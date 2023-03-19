import 'package:coolors_inspired_flutter/features/generate_palette/logic/app_logic.dart';
import 'package:coolors_inspired_flutter/constants.dart';
import 'package:coolors_inspired_flutter/features/auth/logic/auth_logic.dart';
import 'package:coolors_inspired_flutter/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../components/app_menu_item.dart';

Future<dynamic> showUserMenu(BuildContext context, WidgetRef ref) {
  final auth = ref.watch(authenticationProvider);

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
                  iconData: Icons.exit_to_app,
                  label: 'Sign out',
                  hasNavigation: false,
                  menuFuncton: () {
                    //set app logic state with viewing palette
                    auth.signOut(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                AppMenuItem(
                  iconData: Icons.do_disturb_on_outlined,
                  label: 'Delete',
                  hasNavigation: false,
                  menuFuncton: () {
                    //set app logic state with viewing palette
                    showDeleteDialog(context, ref);
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

Future<void> showDeleteDialog(BuildContext context, WidgetRef ref) async {
  final auth = ref.watch(authenticationProvider);
  User? user = ref.watch(authStateProvider).value;

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm accout delete'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Would you like to confirm account deletion?'),
              Text('All you saved data will be lost.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              auth.deleteUser(user, () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              });
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
