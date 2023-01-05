import 'package:coolors_inspired_flutter/components/color_menu.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/pages/library_explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/app_logic.dart';
import '../components/more_menu.dart';
import 'package:tinycolor2/tinycolor2.dart';

class GeneratePalettePage extends ConsumerWidget {
  const GeneratePalettePage({super.key});

  // void initState() {
  //   super.initState();
  //   ShakeDetector detector = ShakeDetector.autoStart(
  //     onPhoneShake: () {
  //       _generateColor();
  //     },
  //     minimumShakeCount: 1,
  //     // shakeSlopTimeMS: 500,
  //     // shakeCountResetTime: 1000,
  //     shakeThresholdGravity: 1.5,
  //   );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ColorObj> colorObj = ref.watch(colorObjProvider);

    return SafeArea(
      child: Scaffold(
          // body: ReorderableListView.builder(
          //   onReorder: (oldIndex, newIndex) {
          //     ref.read(colorObjProvider.notifier).reorder(oldIndex, newIndex);
          //   },
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: colorObj.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return ColorRow(
          //         colorObj: colorObj[index],
          // toggleLock: () => ref
          //     .read(colorObjProvider.notifier)
          //     .toggleLock(colorObj[index]),
          //         key: Key('$index'));
          //   },
          // ),
          body: Column(
            children: List.generate(
              colorObj.length,
              (i) => ColorRow(
                  colorObj: colorObj[i],
                  toggleLock: () => ref
                      .read(colorObjProvider.notifier)
                      .toggleLock(colorObj[i])),
            ),
          ),
          bottomNavigationBar: Container(
            height: 60,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.undo_rounded),
                                onPressed: ref
                                        .read(colorObjProvider.notifier)
                                        .getCanUndo()
                                    ? () => ref
                                        .read(colorObjProvider.notifier)
                                        .undo()
                                    : null,
                              ),
                              IconButton(
                                icon: Icon(Icons.redo_rounded),
                                onPressed: ref
                                        .read(colorObjProvider.notifier)
                                        .getCanRedo()
                                    ? () => ref
                                        .read(colorObjProvider.notifier)
                                        .redo()
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (() =>
                          ref.read(colorObjProvider.notifier).generateColor()),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 50,
                        child: Text(
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
                          icon: Icon(Icons.more_horiz),
                          onPressed: () => showMoreMenu(context, ref),
                        ),
                        IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LibraryExplorePage()),
                              );
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class ColorRow extends ConsumerWidget {
  const ColorRow({Key? key, required this.colorObj, required this.toggleLock})
      : super(key: key);

  final ColorObj colorObj;
  final Function toggleLock;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GestureDetector(
        onTap: () => showColorMenu(context, ref),
        child: Container(
          color: colorObj.color,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                colorObj.colorCode,
                style: colorObj.color.isLight
                    ? kColorDarkLabelStyle
                    : kColorLightLabelStyle,
              ),
            ),
            Padding(
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
            ),
          ]),
        ),
      ),
    );
  }
}
