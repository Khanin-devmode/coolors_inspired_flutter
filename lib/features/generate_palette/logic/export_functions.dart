import 'package:coolors_inspired_flutter/components/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyColorCode(BuildContext context, String colorCode) {
  Clipboard.setData(ClipboardData(text: colorCode));
  showSnackBar(context, '$colorCode copied');
}
