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
              AppMenuItem(
                iconData: Icons.visibility_outlined,
                label: 'View palette',
                hasNavigation: true,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.favorite_outline,
                label: 'Save palette',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.share_outlined,
                label: 'Export palette',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.tune_outlined,
                label: 'Refine palette',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.design_services_outlined,
                label: 'Other tools',
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.settings_outlined,
                label: 'Settings',
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
