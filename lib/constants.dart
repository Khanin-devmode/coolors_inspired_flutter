import 'package:flutter/material.dart';

const kDarkLabelClr = Colors.black87;
const kWhiteLabelClr = Colors.white;

const kColorDarkLabelStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDarkLabelClr);
const kColorLightLabelStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kWhiteLabelClr);
const kGenLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: kDarkLabelClr);
const kSnackBarBg = Color.fromARGB(226, 61, 61, 61);

const kTabLabel = TextStyle(fontSize: 16, color: kDarkLabelClr);
const kMutedLabel = TextStyle(color: Colors.grey);

//Constants for firebase collection
const String kSavedColors = 'SavedColors';
const String kSavedPalettes = 'SavedPalettes';
const String kExplorePalattes = 'ExplorePalettes';
