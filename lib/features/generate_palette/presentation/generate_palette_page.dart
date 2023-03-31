import 'package:coolors_inspired_flutter/features/generate_palette/presentation/color_menu.dart';
import 'package:coolors_inspired_flutter/features/auth/presentation/sign_in_menu.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/features/auth/logic/auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/features/generate_palette/logic/app_logic.dart';
import 'package:go_router/go_router.dart';
import 'more_menu.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'color_picker_tab.dart';
import 'package:shake/shake.dart';

class GeneratePalettePage extends ConsumerStatefulWidget {
  const GeneratePalettePage({Key? key}) : super(key: key);

  @override
  GeneratePalettePageState createState() => GeneratePalettePageState();
}

class GeneratePalettePageState extends ConsumerState<GeneratePalettePage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(colorListProvider.notifier).initRandomColor();
    });

    ShakeDetector.autoStart(
      onPhoneShake: () {
        ref.read(colorListProvider.notifier).generateColor();
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 500,
      shakeThresholdGravity: 1.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ColorObj> colorList = ref.watch(colorListProvider);
    bool isPickingColor = ref.watch(isPickingColorProvider);
    int activeIndex = ref.watch(activeColorIndexProvider);
    List<ColorObj> previousColorList = ref.watch(colorBeforePickingProvider);

    final user = ref.watch(authStateProvider).value;

    Size size = MediaQuery.of(context).size;
    double top = MediaQuery.of(context).padding.top;
    double bottom = MediaQuery.of(context).padding.bottom;
    double availableHeight =
        size.height - kBottomNavigationBarHeight - top - bottom;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  ref
                      .read(colorListProvider.notifier)
                      .reorder(oldIndex, newIndex);
                },
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  colorList.length,
                  (i) => ReorderableDragStartListener(
                    key: Key('DRAGGABLE_ROW_$i'),
                    index: i,
                    child: ColorRow(
                      objIndex: i,
                      key: Key('COLOR_ROW_$i'),
                      colorObj: colorList[i],
                      toggleLock: () => ref
                          .read(colorListProvider.notifier)
                          .toggleLock(colorList[i]),
                      isPickingColor: isPickingColor,
                      activeIndex: activeIndex,
                      height: (availableHeight / (colorList.length))
                          .roundToDouble(),
                    ),
                  ),
                ),
              ),
            ),
            if (isPickingColor)
              ColorPickerTab(
                  colorList: colorList,
                  activeIndex: activeIndex,
                  previousColorList: previousColorList)
          ],
        ),
        bottomNavigationBar: !isPickingColor
            ? Container(
                height: kBottomNavigationBarHeight,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.undo_rounded),
                                  onPressed: ref
                                          .read(colorListProvider.notifier)
                                          .getCanUndo()
                                      ? () => ref
                                          .read(colorListProvider.notifier)
                                          .undo()
                                      : null,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.redo_rounded),
                                  onPressed: ref
                                          .read(colorListProvider.notifier)
                                          .getCanRedo()
                                      ? () => ref
                                          .read(colorListProvider.notifier)
                                          .redo()
                                      : null,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (() => ref
                              .read(colorListProvider.notifier)
                              .generateColor()),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 50,
                            child: const Text(
                              'Generate',
                              style: kGenLabel,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.more_horiz),
                              onPressed: () => showMoreMenu(context, ref),
                            ),
                            IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const LibraryExplorePage()),
                                  // );
                                  if (user != null) {
                                    GoRouter.of(context)
                                        .push('/library_explore');
                                  } else {
                                    showSignInMenu(context, ref);
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class ColorRow extends ConsumerWidget {
  const ColorRow(
      {Key? key,
      required this.colorObj,
      required this.toggleLock,
      required this.isPickingColor,
      required this.activeIndex,
      required this.objIndex,
      required this.height})
      : super(key: key);

  final ColorObj colorObj;
  final Function toggleLock;
  final bool isPickingColor;
  final int activeIndex;
  final int objIndex;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: !isPickingColor
          ? () {
              ref
                  .read(activeColorIndexProvider.notifier)
                  .update((state) => objIndex);
              showColorMenu(context, ref, colorObj);
            }
          : () => ref
              .read(activeColorIndexProvider.notifier)
              .update((state) => objIndex),
      child: Container(
        height: height,
        color: colorObj.color,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          !isPickingColor
              ? Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    colorObj.colorCode,
                    style: colorObj.color.isLight
                        ? kColorDarkLabelStyle
                        : kColorLightLabelStyle,
                  ),
                )
              : Container(),
          !isPickingColor
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () => toggleLock(),
                    child: Container(
                      width: 34,
                      alignment: Alignment.center,
                      child: colorObj.isLocked
                          ? Icon(
                              Icons.lock,
                              color: colorObj.color.isLight
                                  ? kDarkLabelClr
                                  : kWhiteLabelClr,
                              size: 34,
                            )
                          : const Icon(
                              Icons.lock_open_rounded,
                              color: Colors.white70,
                              size: 28,
                            ),
                    ),
                  ),
                )
              : Container(),
          if (isPickingColor && activeIndex == objIndex)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Icon(
                Icons.circle,
                color: colorObj.color.isLight ? kDarkLabelClr : kWhiteLabelClr,
                size: 14,
              ),
            )
        ]),
      ),
    );
  }
}
