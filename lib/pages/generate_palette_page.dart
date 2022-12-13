import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_color/random_color.dart';
import 'package:shake/shake.dart';
import 'dart:math';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/app_logic.dart';

class GeneratePalettePage extends ConsumerWidget {
  GeneratePalettePage({super.key});

  // void _generateColor() {
  //   RandomColor randomColor = RandomColor();
  //   ColorObjList.asMap().forEach((key, value) {
  //     if (!value.isLocked) {
  //       var newColor = randomColor.randomColor();
  //       // setState(() {
  //       //   ColorObjList[key].color = newColor;
  //       //   ColorObjList[key].colorCode = getHexCode(newColor);
  //       // });
  //     }
  //   });
  // }

  void _toggleLock(ColorObj colorObj) {
    // int index = ColorObjList.indexOf(colorObj);
    // setState(() {
    //   ColorObjList[index].isLocked = !ColorObjList[index].isLocked;
    // });
  }

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
          // body: Column(
          //   children: ColorObjList.map((obj) => ColorRow(
          //         colorObj: obj,
          //         toggleLock: _toggleLock,
          //       )).toList(),
          // ),
          // body: ListView.builder(
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: ColorObjList.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Container(
          //         height: rng.nextDouble() * 150,
          //         color: ColorObjList[index].color,
          //         child: Text(ColorObjList[index].colorCode));
          //   },
          // ),
          body: ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) {
              // setState(() {
              //   if (oldIndex < newIndex) {
              //     newIndex -= 1;
              //   }
              //   final ColorObj item = ColorObjList.removeAt(oldIndex);
              //   ColorObjList.insert(newIndex, item);
              // });
            },
            physics: NeverScrollableScrollPhysics(),
            itemCount: colorObj.length,
            itemBuilder: (BuildContext context, int index) {
              return ColorRow(
                  colorObj: colorObj[index],
                  toggleLock: _toggleLock,
                  key: Key('$index'));
            },
          ),

          // body: ReorderableListView(
          //   children: <Widget>[
          //     for (int i = 0; i < ColorObjList.length; i += 1)
          //       ColorRow(
          //           key: Key('$i'),
          //           colorObj: ColorObjList[i],
          //           toggleLock: _toggleLock)
          //   ],
          //   onReorder: ((oldIndex, newIndex) {}),
          // ),
          // body: GridView.count(
          //   crossAxisCount: 2,
          //   children: ColorObjList.map((obj) => ColorRow(
          //         colorObj: obj,
          //         toggleLock: _toggleLock,
          //       )).toList(),
          // ),
          bottomNavigationBar: Container(
            height: 60,
            alignment: Alignment.center,
            child: GestureDetector(
                onTap: (() =>
                    ref.read(colorObjProvider.notifier).generateColor()),
                child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 50,
                    color: Colors.grey,
                    child: Text('Generate'))),
          )),
    );
  }
}

class ColorRow extends StatelessWidget {
  ColorRow({Key? key, required this.colorObj, required this.toggleLock})
      : super(key: key);

  final ColorObj colorObj;
  final Function toggleLock;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: colorObj.color,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(colorObj.colorCode),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (() {
                toggleLock(colorObj);
              }),
              child: Container(
                child: colorObj.isLocked
                    ? const Icon(Icons.lock_outline)
                    : const Icon(Icons.lock_open),
              ),
            ))
      ]),
    );
  }
}
