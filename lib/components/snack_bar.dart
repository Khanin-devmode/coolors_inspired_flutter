import 'package:coolors_inspired_flutter/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1000),
      content: Container(
        height: 20,
        alignment: Alignment.center,
        child: Text(
          message,
        ),
      ),
      width: 280.0, // Width of the SnackBar.
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: kSnackBarBg,
    ),
  );
}
