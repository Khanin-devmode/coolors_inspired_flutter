import 'package:coolors_inspired_flutter/components/snack_bar.dart';
import 'package:coolors_inspired_flutter/logics/app_logic.dart';
import 'package:coolors_inspired_flutter/components/sign_in_menu.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/logics/db_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_menu_item.dart';
import 'package:coolors_inspired_flutter/logics/auth_logic.dart';

Future<dynamic> showViewPaletteMenu(BuildContext context, WidgetRef ref) {
  final user = ref.watch(authStateProvider).value;
  final db = ref.watch(databaseProvider);
  List<ColorObj> viewingColors = ref.read(viewingPaletteProvider);

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
                  menuFuncton: () {
                    //set app logic state with viewing palette
                    ref.read(colorListProvider.notifier).update(viewingColors);
                    context.go('/');
                  },
                ),
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
