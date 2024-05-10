// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCW9W1pr5FcoJZrx4Q0G4OHiFPG9JpVVEo',
    appId: '1:331154362575:web:37a4c2467935960c9fa7ba',
    messagingSenderId: '331154362575',
    projectId: 'onder-lift',
    authDomain: 'onder-lift.firebaseapp.com',
    storageBucket: 'onder-lift.appspot.com',
    measurementId: 'G-LHZV5LDX4H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5uIM44Bet8d5dAfXNnPa1wpKDSc1Re-4',
    appId: '1:331154362575:android:eed2fe861dbded399fa7ba',
    messagingSenderId: '331154362575',
    projectId: 'onder-lift',
    storageBucket: 'onder-lift.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0IbUlYsOBWDpERED3J5F6D73YgUVyFgU',
    appId: '1:331154362575:ios:afc39a228a3f73b49fa7ba',
    messagingSenderId: '331154362575',
    projectId: 'onder-lift',
    storageBucket: 'onder-lift.appspot.com',
    iosBundleId: 'com.example.onderliftmobil',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0IbUlYsOBWDpERED3J5F6D73YgUVyFgU',
    appId: '1:331154362575:ios:afc39a228a3f73b49fa7ba',
    messagingSenderId: '331154362575',
    projectId: 'onder-lift',
    storageBucket: 'onder-lift.appspot.com',
    iosBundleId: 'com.example.onderliftmobil',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCW9W1pr5FcoJZrx4Q0G4OHiFPG9JpVVEo',
    appId: '1:331154362575:web:521561ddf29a21609fa7ba',
    messagingSenderId: '331154362575',
    projectId: 'onder-lift',
    authDomain: 'onder-lift.firebaseapp.com',
    storageBucket: 'onder-lift.appspot.com',
    measurementId: 'G-9ENYXCLFBH',
  );
}