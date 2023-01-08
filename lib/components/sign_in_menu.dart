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
          padding: EdgeInsets.only(top: 12, right: 12, bottom: 36, left: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 10,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ),
                  Text(
                    'Hello!',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  )
                ],
              ),
              Text(
                'Continue to sign up for free. If you already have an account, we will log you in',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueGrey),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () => {},
                child: Row(
                  children: [Icon(Icons.abc), Text('Continue wigh Google')],
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueGrey),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () => {},
                child: Row(
                  children: [Icon(Icons.abc), Text('Continue wigh Google')],
                ),
              ),
              Text(
                'Continue to sign up for free. If you already have an account, we will log you in',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        );
      });
}
