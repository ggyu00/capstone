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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCRO-I0pZshNYMHpJNjQRWr5IiVrE9Ws-Y',
    appId: '1:992703577360:web:e4b42b0daeb735538ff995',
    messagingSenderId: '992703577360',
    projectId: 'capstone-f517b',
    authDomain: 'capstone-f517b.firebaseapp.com',
    storageBucket: 'capstone-f517b.appspot.com',
    measurementId: 'G-7Y12GWZ61N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBR6XxvhOJzjnfnKdsC2MhLL3YWQM3LUok',
    appId: '1:992703577360:android:93deaf95765cffb28ff995',
    messagingSenderId: '992703577360',
    projectId: 'capstone-f517b',
    storageBucket: 'capstone-f517b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfd5X-0Mr5-V-zqiGcmqcX6jXj4TO6aCQ',
    appId: '1:992703577360:ios:291a0e225c5cea348ff995',
    messagingSenderId: '992703577360',
    projectId: 'capstone-f517b',
    storageBucket: 'capstone-f517b.appspot.com',
    iosBundleId: 'com.example.capstone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCRO-I0pZshNYMHpJNjQRWr5IiVrE9Ws-Y',
    appId: '1:992703577360:web:3da234e76e13de938ff995',
    messagingSenderId: '992703577360',
    projectId: 'capstone-f517b',
    authDomain: 'capstone-f517b.firebaseapp.com',
    storageBucket: 'capstone-f517b.appspot.com',
    measurementId: 'G-15Y0F2SSMK',
  );
}