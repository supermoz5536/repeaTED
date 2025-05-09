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
    apiKey: 'AIzaSyAm43UtmRZNh5lfcaDPTsx1OqAUqnmoCBA',
    appId: '1:158157854816:web:ad9e6981ca6a6d8abe4b05',
    messagingSenderId: '158157854816',
    projectId: 'repeated-c1cef',
    authDomain: 'repeated-c1cef.firebaseapp.com',
    storageBucket: 'repeated-c1cef.appspot.com',
    measurementId: 'G-V2H331J5KB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDy7VUYF5fRnd4zkVB9lLOwWVUWHFWK874',
    appId: '1:158157854816:android:7e715df7bb75d2a8be4b05',
    messagingSenderId: '158157854816',
    projectId: 'repeated-c1cef',
    storageBucket: 'repeated-c1cef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwqd00mRbSpBfa54FgQsV9DIJbpj1vIT4',
    appId: '1:158157854816:ios:00925e521a046b54be4b05',
    messagingSenderId: '158157854816',
    projectId: 'repeated-c1cef',
    storageBucket: 'repeated-c1cef.appspot.com',
    iosBundleId: 'com.example.repeaTed',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwqd00mRbSpBfa54FgQsV9DIJbpj1vIT4',
    appId: '1:158157854816:ios:c3f94116f8af1546be4b05',
    messagingSenderId: '158157854816',
    projectId: 'repeated-c1cef',
    storageBucket: 'repeated-c1cef.appspot.com',
    iosBundleId: 'com.example.repeaTed.RunnerTests',
  );
}
