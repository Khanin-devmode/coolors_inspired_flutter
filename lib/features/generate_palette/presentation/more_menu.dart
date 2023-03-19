import 'package:coolors_inspired_flutter/components/snack_bar.dart';
import 'package:coolors_inspired_flutter/features/generate_palette/presentation/user_menu.dart';
import 'package:coolors_inspired_flutter/features/generate_palette/logic/app_logic.dart';
import 'package:coolors_inspired_flutter/features/generate_palette/presentation/export_menu.dart';
import 'package:coolors_inspired_flutter/components/sign_in_menu.dart';
import 'package:coolors_inspired_flutter/features/library_and_explore/logic/db_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:coolors_inspired_flutter/features/library_and_explore/presentation/view_palette_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../components/app_menu_item.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/features/auth/logic/auth_logic.dart';

Future<dynamic> showMoreMenu(BuildContext context, WidgetRef ref) {
  final user = ref.watch(authStateProvider).value;
  final db = ref.watch(databaseProvider);

  List<ColorObj> colorList = ref.watch(colorListProvider);

  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppMenuItem(
                  iconData: Icons.visibility_outlined,
                  label: 'View palette',
                  hasNavigation: false,
                  menuFuncton: () {
                    ref
                        .read(viewingPaletteProvider.notifier)
                        .update((state) => colorList);
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return const ViewPalettePage();
                        },
                      ),
                    );
                  },
                ),
                AppMenuItem(
                  iconData: Icons.favorite_outline,
                  label: 'Save palette',
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
                ),
                AppMenuItem(
                    iconData: Icons.share_outlined,
                    label: 'Export palette',
                    hasNavigation: true,
                    menuFuncton: () {
                      Navigator.pop(context);
                      showExportMenu(context, ref);
                    }),
                const AppMenuItem(
                  iconData: Icons.tune_outlined,
                  label: 'Refine palette',
                  hasNavigation: false,
                ),
                const AppMenuItem(
                  iconData: Icons.design_services_outlined,
                  label: 'Other tools',
                  hasNavigation: false,
                ),
                const AppMenuItem(
                  iconData: Icons.settings_outlined,
                  label: 'Settings',
                  hasNavigation: false,
                ),
                user != null
                    ? Column(
                        children: [
                          AppMenuItem(
                            iconData: FontAwesomeIcons.user,
                            label: 'User',
                            hasNavigation: true,
                            menuFuncton: () {
                              Navigator.pop(context);
                              showUserMenu(context, ref);
                            },
                          ),
                        ],
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 5),
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
