import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';
import 'package:random_color/random_color.dart';

//app state for ui.
final isPickingColorProvider = StateProvider<bool>((ref) => false);
final activeColorIndexProvider = StateProvider<int>((ref) => 0);
final colorBeforePickingProvider = StateProvider<List<ColorObj>>((ref) => []);
final hexTextControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

//app state for colors list.
class ColorListNotifier extends StateNotifier<List<ColorObj>>
    with HistoryMixin<List<ColorObj>> {
  ColorListNotifier()
      : super([
          // ColorObj(Colors.red, getHexCode(Colors.red), false),
          // ColorObj(Colors.green, getHexCode(Colors.green), false),
          // ColorObj(Colors.blue, getHexCode(Colors.blue), false),
          // ColorObj(Colors.yellow, getHexCode(Colors.yellow), false),
          // ColorObj(Colors.purple, getHexCode(Colors.purple), false),
        ]);

  void initRandomColor() {
    RandomColor randomColor = RandomColor();
    List<ColorObj> newColorList = [];

    for (int i = 0; i < 5; i++) {
      var newColor = randomColor.randomColor();
      newColorList.add(ColorObj(newColor, getHexCode(newColor), false));
    }

    state = newColorList;
  }

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

  void addColor() {
    RandomColor randomColor = RandomColor();
    var newColor = randomColor.randomColor();
    ColorObj newColorObj = ColorObj(newColor, getHexCode(newColor), false);

    state = [...state, newColorObj];
  }

  // void removeColor() {
  //   state = state.sublist(0, state.length - 1);
  //   print(state);
  // }

  void removeColor(ColorObj targetColor) {
    if (state.length > 1) {
      state = state.where((color) => color != targetColor).toList();
    }
  }

  void pickColor(int selectedIndex, Color newColor) {
    var newColorObj =
        ColorObj(newColor, getHexCode(newColor), state[selectedIndex].isLocked);

    state = List<ColorObj>.generate(state.length,
        (index) => selectedIndex != index ? state[index] : newColorObj);
  }

  void update(List<ColorObj> newColorList) {
    state = newColorList;
  }
}

final colorListProvider =
    StateNotifierProvider<ColorListNotifier, List<ColorObj>>(
  (ref) {
    return ColorListNotifier();
  },
);

mixin HistoryMixin<T> on StateNotifier<T> {
  List<T> _history = [];

  int _undoIndex = 0;

  bool get _canUndo => _undoIndex + 1 < _history.length;

  bool get _canRedo => _undoIndex > 0;

  @override
  set state(T value) {
    _clearRedoHistory();
    _history.insert(0, value);
    super.state = value;
  }

  void undo() {
    if (_canUndo) {
      super.state = _history[++_undoIndex];
    }
  }

  void redo() {
    if (_canRedo) {
      super.state = _history[--_undoIndex];
    }
  }

  void reset() {
    if (_history.isNotEmpty) {
      final initialState = _history.last;
      _history.clear();
      super.state = initialState;
      _history.insert(0, initialState);
      _undoIndex = 0;
    }
  }

  void _clearRedoHistory() {
    _history = _history.sublist(_undoIndex, _history.length);
    _undoIndex = 0;
  }

  bool getCanRedo() {
    return _canRedo;
  }

  bool getCanUndo() {
    return _canUndo;
  }
}
