import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

final authenticationProvider = Provider<Authentication>((ref) {
  return Authentication();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChage;
});

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChage => _auth.authStateChanges();

  Future<void> signInWithGoogle(BuildContext context, Function callBack) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await _auth.signInWithCredential(credential);

      callBack();
    } on FirebaseAuthException catch (e) {
      // await showDialog(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     title: Text('Error Occured'),
      //     content: Text(e.toString()),
      //     actions: [
      //       TextButton(
      //           onPressed: () {
      //             Navigator.of(ctx).pop();
      //           },
      //           child: Text("OK"))
      //     ],
      //   ),
      // );
    }
  }

  //  SignOut the current user
  Future<void> signOut(Function callBack) async {
    await _auth.signOut().then((value) => callBack());
  }
}
