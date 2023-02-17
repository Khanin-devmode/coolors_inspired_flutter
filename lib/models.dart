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

class ColorPalette {
  ColorPalette(this.docId, this.colorPalette, this.tiemCreated);
  String docId;
  List<Color> colorPalette;
  Timestamp tiemCreated;
}

String getHexCode(Color color) {
  return color.hashCode.toRadixString(16).substring(2).toUpperCase();
}
