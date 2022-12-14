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

  void toggleLock(ColorObj colorObj) {
    // state[i].isLocked = !state[i].isLocked;
    List<ColorObj> newList = state
        .map((stateObj) => stateObj == colorObj
            ? ColorObj(stateObj.color, stateObj.colorCode, !stateObj.isLocked)
            : stateObj)
        .toList();

    state = newList;
  }

  void reorder(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    var colorObjList = state;
    final ColorObj item = colorObjList.removeAt(oldIndex);
    colorObjList.insert(newIndex, item);

    state = colorObjList;
  }
}

final colorObjProvider =
    StateNotifierProvider<ColorObjNotifier, List<ColorObj>>(
  (ref) {
    return ColorObjNotifier();
  },
);
