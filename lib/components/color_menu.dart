import 'package:coolors_inspired_flutter/app_logic.dart';
import 'package:coolors_inspired_flutter/components/sign_in_menu.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_menu_item.dart';

Future<dynamic> showColorMenu(
    BuildContext context, WidgetRef ref, ColorObj selectedColor) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppMenuItem(
                iconData: Icons.colorize,
                label: 'Pick Colors',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.add,
                label: 'Add Colors',
                hasNavigation: false,
                menuFuncton: () =>
                    ref.read(colorObjProvider.notifier).addColor(),
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.remove,
                label: 'Remove Color',
                hasNavigation: false,
                menuFuncton: () =>
                    ref.read(colorObjProvider.notifier).removeColor(),
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.favorite_border,
                label: 'Save Color',
                hasNavigation: false,
                menuFuncton: () {
                  Navigator.pop(context);
                  showSignInMenu(context, ref);
                },
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.copy,
                label: 'Copy Color',
                hasNavigation: false,
                menuFuncton: () {
                  Clipboard.setData(
                      ClipboardData(text: selectedColor.colorCode));
                  showSnackBar(context, '${selectedColor.colorCode} copied');
                  Navigator.pop(context);
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: kGenLabel,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        );
      });
}

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
