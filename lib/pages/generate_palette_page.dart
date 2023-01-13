import 'package:coolors_inspired_flutter/components/color_menu.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/pages/library_explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/app_logic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    List<ColorObj> colorList = ref.watch(colorObjProvider);
    bool isPickingColor = ref.watch(isPickingColorProvider);
    int activeIndex = ref.watch(activeColorIndexProvider);

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
          children: [
            Expanded(
              child: Column(
                children: List.generate(
                  colorList.length,
                  (i) => ColorRow(
                    objIndex: i,
                    colorObj: colorList[i],
                    toggleLock: () => ref
                        .read(colorObjProvider.notifier)
                        .toggleLock(colorList[i]),
                    isPickingColor: isPickingColor,
                    activeIndex: activeIndex,
                  ),
                ),
              ),
            ),
            if (isPickingColor)
              DefaultTabController(
                initialIndex: 1,
                length: 3, //
                child: Column(
                  children: [
                    TabBar(
                      tabs: <Widget>[
                        Tab(
                          text: 'Library',
                          // icon: Icon(Icons.cloud_outlined),
                        ),
                        Tab(
                          text: 'Explore',
                          // icon: Icon(Icons.beach_access_sharp),
                        ),
                        Tab(
                          text: 'Test',
                          // icon: Icon(Icons.beach_access_sharp),
                        ),
                      ],
                    ),
                    Container(
                      height: 400,
                      child: TabBarView(
                        children: <Widget>[
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: ColorPicker(
                                pickerColor: colorList[activeIndex].color,
                                onColorChanged: ((value) => ref
                                    .read(colorObjProvider.notifier)
                                    .pickColor(activeIndex, value)),
                              ),
                            ),
                          ),
                          Center(
                            child: Text("It's rainy here"),
                          ),
                          Center(
                            child: Text("It's It's third page here"),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: (() => ref
                              .read(isPickingColorProvider.notifier)
                              .update((state) => !state)),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: (() => ref
                              .read(isPickingColorProvider.notifier)
                              .update((state) => !state)),
                          child: Text('Apply'),
                        )
                      ],
                    )
                  ],
                ),
              )
          ],
        ),
        bottomNavigationBar: !isPickingColor
            ? Container(
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
                          onTap: (() => ref
                              .read(colorObjProvider.notifier)
                              .generateColor()),
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
      required this.objIndex})
      : super(key: key);

  final ColorObj colorObj;
  final Function toggleLock;
  final bool isPickingColor;
  final int activeIndex;
  final int objIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: GestureDetector(
        onTap: !isPickingColor
            ? () => showColorMenu(context, ref, colorObj)
            : () => ref
                .read(activeColorIndexProvider.notifier)
                .update((state) => objIndex),
        child: Container(
          color: colorObj.color,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            !isPickingColor
                ? Padding(
                    padding: EdgeInsets.all(18.0),
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
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.circle),
              )
          ]),
        ),
      ),
    );
  }
}
