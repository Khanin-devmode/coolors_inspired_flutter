import 'package:coolors_inspired_flutter/components/export_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_menu_item.dart';
import 'package:coolors_inspired_flutter/constants.dart';

Future<dynamic> showSignInMenu(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 12, right: 12, bottom: 24, left: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hello!'),
              Text(
                  'Continue to sign up for free. If you already hae an account, we will log you in')
            ],
          ),
        );
      });
}
