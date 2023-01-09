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
          padding:
              const EdgeInsets.only(top: 12, right: 12, bottom: 36, left: 12),
          decoration: const BoxDecoration(
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
                    width: 42,
                    height: 42,
                  )
                ],
              ),
              Text(
                'Continue to sign up for free. If you already have an account, we will log you in.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
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
                onPressed: () => Navigator.pop(context),
                child: Row(
                  children: [Icon(Icons.abc), Text('Continue wigh Google')],
                ),
              ),
              SizedBox(height: 32),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  children: [
                    TextSpan(text: 'By Continuing, you agree to our '),
                    TextSpan(text: 'Term of Service.'),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  children: [
                    TextSpan(text: 'Read our '),
                    TextSpan(text: 'Privacy Policy.'),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
