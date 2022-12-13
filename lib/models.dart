import 'package:flutter/material.dart';

class ColorObj {
  ColorObj(this.color, this.colorCode, this.isLocked);

  Color color;
  String colorCode;
  bool isLocked;
}

String getHexCode(Color color) {
  return color.hashCode.toRadixString(16).substring(2).toUpperCase();
}
