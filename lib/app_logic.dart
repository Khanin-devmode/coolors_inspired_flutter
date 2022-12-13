import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';
import 'package:random_color/random_color.dart';

class ColorObjNotifier extends StateNotifier<List<ColorObj>> {
  ColorObjNotifier()
      : super([
          ColorObj(Colors.red, getHexCode(Colors.red), false),
          ColorObj(Colors.green, getHexCode(Colors.green), false),
          ColorObj(Colors.blue, getHexCode(Colors.blue), false),
          ColorObj(Colors.yellow, getHexCode(Colors.yellow), false),
          ColorObj(Colors.purple, getHexCode(Colors.purple), false),
        ]);

  void generateColor() {
    RandomColor randomColor = RandomColor();

    List<ColorObj> newColorList = [];
    for (ColorObj obj in state) {
      if (!obj.isLocked) {
        var newColor = randomColor.randomColor();

        newColorList.add(ColorObj(newColor, getHexCode(newColor), false));
      } else {
        newColorList.add(obj);
      }
    }

    state = newColorList;
  }

  void toggleLock() {}

  void reorder(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    var colorObjList = state;
    final ColorObj item = colorObjList.removeAt(oldIndex);
    colorObjList.insert(newIndex, item);

    state = colorObjList;
    // final ColorObj item = ColorObjList.removeAt(oldIndex);
    // ColorObjList.insert(newIndex, item);
  }
}

final colorObjProvider =
    StateNotifierProvider<ColorObjNotifier, List<ColorObj>>(
  (ref) {
    return ColorObjNotifier();
  },
);
