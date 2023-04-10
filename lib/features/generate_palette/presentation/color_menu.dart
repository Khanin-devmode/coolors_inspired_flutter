import 'package:coolors_inspired_flutter/components/snack_bar.dart';
import 'package:coolors_inspired_flutter/features/generate_palette/logic/app_logic.dart';
import 'package:coolors_inspired_flutter/features/auth/presentation/sign_in_menu.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/features/library_and_explore/logic/db_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/app_menu_item.dart';
import 'package:coolors_inspired_flutter/features/auth/logic/auth_logic.dart';
import '../logic/export_functions.dart';

Future<dynamic> showColorMenu(
    BuildContext context, WidgetRef ref, ColorObj selectedColor) {
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
                  iconData: Icons.colorize,
                  label: 'Pick Colors',
                  hasNavigation: false,
                  menuFuncton: () {
                    Navigator.pop(context);
                    ref
                        .read(isPickingColorProvider.notifier)
                        .update((state) => !state);
                    ref
                        .read(colorBeforePickingProvider.notifier)
                        .update((state) => colorList);
                  },
                ),
                AppMenuItem(
                  iconData: Icons.add,
                  label: 'Add Colors',
                  hasNavigation: false,
                  menuFuncton: () {
                    ref.read(colorListProvider.notifier).addColor();
                    Navigator.pop(context);
                  },
                ),
                AppMenuItem(
                  iconData: Icons.remove,
                  label: 'Remove Color',
                  hasNavigation: false,
                  menuFuncton: () {
                    ref
                        .read(colorListProvider.notifier)
                        .removeColor(colorList[activeIndex]);
                    Navigator.pop(context);
                  },
                ),
                AppMenuItem(
                  iconData: Icons.favorite_border,
                  label: 'Save Color',
                  hasNavigation: false,
                  menuFuncton: user == null
                      ? () {
                          Navigator.pop(context);
                          showSignInMenu(context, ref);
                        }
                      : () {
                          db.saveColor(
                              colorList[activeIndex].colorCode, user.uid, () {
                            Navigator.pop(context);
                            showSnackBar(context, 'Color saved');
                          });
                        },
                ),
                AppMenuItem(
                    iconData: Icons.copy,
                    label: 'Copy Color',
                    hasNavigation: false,
                    menuFuncton: () {
                      copyColorCode(context, selectedColor.colorCode);
                      Navigator.pop(context);
                    }),
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
