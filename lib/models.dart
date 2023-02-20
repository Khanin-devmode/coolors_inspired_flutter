import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ColorObj {
  ColorObj(this.color, this.colorCode, this.isLocked);

  Color color;
  String colorCode;
  bool isLocked;
}

class ColorDoc {
  ColorDoc(this.docId, this.color);

  String docId;
  Color color;
}

class ColorPaletteDoc {
  ColorPaletteDoc(this.docId, this.colors, this.timeCreated);
  String docId;
  List<Color> colors;
  Timestamp timeCreated;
}

String getHexCode(Color color) {
  return color.value.toRadixString(16).substring(2).toUpperCase();
}

Color hexToColor(String hex) {
  return Color(int.parse('ff$hex', radix: 16));
}
