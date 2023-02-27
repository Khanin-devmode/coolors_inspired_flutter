import 'package:coolors_inspired_flutter/components/color_menu.dart';
import 'package:coolors_inspired_flutter/components/snack_bar.dart';
import 'package:coolors_inspired_flutter/logics/app_logic.dart';
import 'package:coolors_inspired_flutter/components/sign_in_menu.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/logics/db_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_menu_item.dart';
import 'package:coolors_inspired_flutter/logics/auth_logic.dart';

Future<dynamic> showViewPaletteMenu(
    BuildContext context, WidgetRef ref, bool isSaveable, bool isDeleteable) {
  List<ColorObj> colorList = ref.watch(colorListProvider);
  int activeIndex = ref.watch(activeColorIndexProvider);
  final user = ref.watch(authStateProvider).value;
  final db = ref.watch(databaseProvider);

  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppMenuItem(
                  iconData: Icons.auto_fix_high_outlined,
                  label: 'Open in Generator',
                  hasNavigation: false,
                  menuFuncton: () {},
                ),
                isSaveable
                    ? AppMenuItem(
                        iconData: Icons.favorite_border_outlined,
                        label: 'Save Palette',
                        hasNavigation: false,
                        menuFuncton: user != null
                            ? () {
                                List<String> colorPalette = colorList
                                    .map((color) => color.colorCode)
                                    .toList();
                                db.savePalette(colorPalette, user.uid, () {
                                  Navigator.pop(context);
                                  showSnackBar(context, 'Palette Saved.');
                                });
                              }
                            : () {
                                Navigator.pop(context);
                                showSignInMenu(context, ref);
                              },
                      )
                    : SizedBox(),
                isDeleteable
                    ? AppMenuItem(
                        iconData: Icons.remove,
                        label: 'Delete Palette',
                        hasNavigation: false,
                        menuFuncton: () {},
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 18),
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
              ],
            ),
          ),
        );
      });
}
