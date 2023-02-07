import 'package:coolors_inspired_flutter/app_logic.dart';
import 'package:coolors_inspired_flutter/components/export_menu.dart';
import 'package:coolors_inspired_flutter/components/sign_in_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_menu_item.dart';
import 'package:coolors_inspired_flutter/constants.dart';

Future<dynamic> showMoreMenu(BuildContext context, WidgetRef ref) {
  final _auth = ref.watch(authenticationProvider);
  final data = ref.watch(authStateProvider);

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
                hasNavigation: false,
              ),
              Divider(),
              AppMenuItem(
                iconData: Icons.favorite_outline,
                label: 'Save palette',
                hasNavigation: false,
                menuFuncton: isSignIn()
                    ? () {}
                    : () {
                        Navigator.pop(context);
                        showSignInMenu(context, ref);
                      },
              ),
              Divider(),
              AppMenuItem(
                  iconData: Icons.share_outlined,
                  label: 'Export palette',
                  hasNavigation: true,
                  menuFuncton: () {
                    Navigator.pop(context);
                    showExportMenu(context, ref);
                  }),
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
              data.value != null
                  ? Column(
                      children: [
                        AppMenuItem(
                          iconData: Icons.exit_to_app,
                          label: 'Sign out ${data.value!.email}',
                          hasNavigation: false,
                          menuFuncton: () {
                            _auth.signOut();
                            Navigator.pop(context);
                          },
                        ),
                        Divider(),
                      ],
                    )
                  : Container(),
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

//temp function
bool isSignIn() {
  return false;
}
