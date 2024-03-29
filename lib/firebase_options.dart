// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAUlD-bBmHG_yn2sCHx1itTssB0PdFVAM0',
    appId: '1:407916430803:web:0d95b32606d7d8004adb26',
    messagingSenderId: '407916430803',
    projectId: 'coolors-clone',
    authDomain: 'coolors-clone.firebaseapp.com',
    storageBucket: 'coolors-clone.appspot.com',
    measurementId: 'G-W0E7QNBEE6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4VOEbVUhziZXTCA98L8d4OdrTpppRXb4',
    appId: '1:407916430803:android:e7d88b7940dd366f4adb26',
    messagingSenderId: '407916430803',
    projectId: 'coolors-clone',
    storageBucket: 'coolors-clone.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbDaqpwh7iu78Itt7f7g2Ki_B7rmWRopI',
    appId: '1:407916430803:ios:b545e29e8fa484ba4adb26',
    messagingSenderId: '407916430803',
    projectId: 'coolors-clone',
    storageBucket: 'coolors-clone.appspot.com',
    iosClientId: '407916430803-cfm71estqs47sjkiutg7n4hv8l8c26kk.apps.googleusercontent.com',
    iosBundleId: 'com.example.coolorsInspiredFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbDaqpwh7iu78Itt7f7g2Ki_B7rmWRopI',
    appId: '1:407916430803:ios:b545e29e8fa484ba4adb26',
    messagingSenderId: '407916430803',
    projectId: 'coolors-clone',
    storageBucket: 'coolors-clone.appspot.com',
    iosClientId: '407916430803-cfm71estqs47sjkiutg7n4hv8l8c26kk.apps.googleusercontent.com',
    iosBundleId: 'com.example.coolorsInspiredFlutter',
  );
}
