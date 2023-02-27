import 'package:coolors_inspired_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_menu_item.dart';

Future<dynamic> showExportMenu(BuildContext context, WidgetRef ref) {
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
                iconData: Icons.link_outlined,
                label: 'Copy URL',
                hasNavigation: false,
              ),
              AppMenuItem(
                iconData: Icons.description_outlined,
                label: 'PDF',
                hasNavigation: false,
              ),
              AppMenuItem(
                iconData: Icons.image_outlined,
                label: 'Image',
                hasNavigation: false,
              ),
              AppMenuItem(
                iconData: Icons.polyline_outlined,
                label: 'SVG',
                hasNavigation: false,
              ),
              AppMenuItem(
                iconData: Icons.palette_outlined,
                label: 'ASE',
                hasNavigation: false,
              ),
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
