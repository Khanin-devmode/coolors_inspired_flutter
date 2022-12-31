import 'package:flutter/material.dart';
import 'app_menu_item.dart';
import 'package:coolors_inspired_flutter/constants.dart';

Future<dynamic> showBottomMenu(BuildContext context) {
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
              // const Text('Modal BottomSheet'),
              // ElevatedButton(
              //   child: const Text('Close BottomSheet'),
              //   onPressed: () => Navigator.pop(context),
              // ),
              AppMenuItem(
                iconData: Icons.view_agenda,
                label: 'View palette',
                hasNavigation: true,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.favorite,
                label: 'Save palette',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.share,
                label: 'Export palette',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.settings,
                label: 'Refine palette',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.copy,
                label: 'Other tools',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.settings,
                label: 'Settings',
                hasNavigation: false,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cancel',
                      style: kGenLabel,
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
