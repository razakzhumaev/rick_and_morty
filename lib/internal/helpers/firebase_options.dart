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
    apiKey: 'AIzaSyCxKzHXcPQDGh1qc5KpUqOlc_wXOoPi60w',
    appId: '1:863941112388:web:903c6ee8ca0c0c51c00211',
    messagingSenderId: '863941112388',
    projectId: 'rickandmorty-39428',
    authDomain: 'rickandmorty-39428.firebaseapp.com',
    storageBucket: 'rickandmorty-39428.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVn98hK1R17EYMvWbX8SEN_j1s19_4XXY',
    appId: '1:863941112388:android:01b52c64a60bf233c00211',
    messagingSenderId: '863941112388',
    projectId: 'rickandmorty-39428',
    storageBucket: 'rickandmorty-39428.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-B1rgwpGj2EUK_NO64JIwYwz11MyNods',
    appId: '1:863941112388:ios:91861849a0d3472ac00211',
    messagingSenderId: '863941112388',
    projectId: 'rickandmorty-39428',
    storageBucket: 'rickandmorty-39428.appspot.com',
    iosBundleId: 'com.example.rickMortyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-B1rgwpGj2EUK_NO64JIwYwz11MyNods',
    appId: '1:863941112388:ios:fbc99ea86d43f75cc00211',
    messagingSenderId: '863941112388',
    projectId: 'rickandmorty-39428',
    storageBucket: 'rickandmorty-39428.appspot.com',
    iosBundleId: 'com.example.rickMortyApp.RunnerTests',
  );
}
