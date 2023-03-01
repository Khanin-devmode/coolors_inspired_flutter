import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:coolors_inspired_flutter/logics/auth_logic.dart';

Future<dynamic> showSignInMenu(BuildContext context, WidgetRef ref) {
  final auth = ref.watch(authenticationProvider);

  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding:
              const EdgeInsets.only(top: 24, right: 24, bottom: 48, left: 24),
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
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                  const Text(
                    'Hello!',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    width: 42,
                    height: 42,
                  )
                ],
              ),
              const Text(
                'Continue to sign up for free. If you already have an account, we will log you in.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 242, 242, 242)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 32,
                        child: Icon(FontAwesomeIcons.google),
                      ),
                      const Text(
                        'Sign in with Google',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      Container(
                        width: 32,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  auth.signInWithGoogle(context, () {
                    Navigator.pop(context);
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              // TextButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color>(
              //         const Color.fromARGB(255, 16, 107, 243)),
              //     foregroundColor:
              //         MaterialStateProperty.all<Color>(Colors.black),
              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12.0),
              //       ),
              //     ),
              //   ),
              //   onPressed: () => {},
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 4.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: const [
              //         Text(
              //           'Continue with email address',
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.w500,
              //               fontSize: 16),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              defaultTargetPlatform == TargetPlatform.iOS
                  ? TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 242, 242, 242)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        auth.signInWithApple();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 32,
                              child: Icon(
                                FontAwesomeIcons.apple,
                                size: 24,
                              ),
                            ),
                            const Text(
                              'Sign in with Apple',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            Container(
                              width: 32,
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 28),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                  children: [
                    const TextSpan(text: 'By Continuing, you agree to our '),
                    TextSpan(
                      text: 'Term of Service.',
                      style: const TextStyle(color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchUrlString('https://flutter.dev');
                        },
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                  children: [
                    const TextSpan(text: 'Read our '),
                    TextSpan(
                      text: 'Privacy Policy.',
                      style: const TextStyle(color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchUrlString('https://flutter.dev');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

Future<void> _launchUrlString(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw 'Could not launch $urlString';
  }
}
