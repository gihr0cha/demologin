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
    apiKey: 'AIzaSyBOBDUvJtwFn42_Uy6dMFjZaSLvKbntA3Q',
    appId: '1:295314135611:web:fb188dc2e6f60ea37e9a1e',
    messagingSenderId: '295314135611',
    projectId: 'fir-6a5e9',
    authDomain: 'fir-6a5e9.firebaseapp.com',
    databaseURL: 'https://fir-6a5e9-default-rtdb.firebaseio.com',
    storageBucket: 'fir-6a5e9.appspot.com',
    measurementId: 'G-3G3ZLWSQYX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmh_v1FezXoIivWeRuM3_btgWDio3MgYQ',
    appId: '1:295314135611:android:b90cfd17042c78317e9a1e',
    messagingSenderId: '295314135611',
    projectId: 'fir-6a5e9',
    databaseURL: 'https://fir-6a5e9-default-rtdb.firebaseio.com',
    storageBucket: 'fir-6a5e9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdKXFfRhpos84rK3XiKEWxquQlXDkXQsQ',
    appId: '1:295314135611:ios:c19af67b7f3190f77e9a1e',
    messagingSenderId: '295314135611',
    projectId: 'fir-6a5e9',
    databaseURL: 'https://fir-6a5e9-default-rtdb.firebaseio.com',
    storageBucket: 'fir-6a5e9.appspot.com',
    iosBundleId: 'com.example.demologin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdKXFfRhpos84rK3XiKEWxquQlXDkXQsQ',
    appId: '1:295314135611:ios:a1b62c71d155a1267e9a1e',
    messagingSenderId: '295314135611',
    projectId: 'fir-6a5e9',
    databaseURL: 'https://fir-6a5e9-default-rtdb.firebaseio.com',
    storageBucket: 'fir-6a5e9.appspot.com',
    iosBundleId: 'com.example.demologin.RunnerTests',
  );
}
