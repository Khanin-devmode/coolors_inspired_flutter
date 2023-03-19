import 'package:coolors_inspired_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/app_menu_item.dart';

Future<dynamic> showExportMenu(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const AppMenuItem(
                iconData: Icons.link_outlined,
                label: 'Copy URL',
                hasNavigation: false,
              ),
              const AppMenuItem(
                iconData: Icons.description_outlined,
                label: 'PDF',
                hasNavigation: false,
              ),
              const AppMenuItem(
                iconData: Icons.image_outlined,
                label: 'Image',
                hasNavigation: false,
              ),
              const AppMenuItem(
                iconData: Icons.polyline_outlined,
                label: 'SVG',
                hasNavigation: false,
              ),
              const AppMenuItem(
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
                      child: const Text(
                        'Cancel',
                        style: kGenLabel,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      });
}
