import 'package:coolors_inspired_flutter/app_logic.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_menu_item.dart';

Future<dynamic> showColorMenu(BuildContext context, WidgetRef ref) {
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
                  hasNavigation: true,
                  menuFuncton: () => print('something')),
              Divider(),
              AppMenuItem(
                iconData: Icons.add,
                label: 'Add Colors',
                hasNavigation: false,
                menuFuncton: () {
                  print('menu function evoke');
                  ref.read(colorObjProvider.notifier).addColor();
                },
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.remove,
                label: 'Remove Color',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.favorite_border,
                label: 'Save Color',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.copy,
                label: 'Copy Color',
                hasNavigation: false,
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
