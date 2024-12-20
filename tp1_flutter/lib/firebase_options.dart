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
    apiKey: 'AIzaSyBx-18FOih-6J9k-PlFFrPZK8vGczJOoQk',
    appId: '1:574000022604:web:22f6eb304d8dcc3d5320e9',
    messagingSenderId: '574000022604',
    projectId: 'taskproject-tp3',
    authDomain: 'taskproject-tp3.firebaseapp.com',
    storageBucket: 'taskproject-tp3.firebasestorage.app',
    measurementId: 'G-HESW1T736G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAZkpj7lOZgrNx3gsAreIr0m9MfX9V-oQ',
    appId: '1:574000022604:android:c5e360da51fd78cb5320e9',
    messagingSenderId: '574000022604',
    projectId: 'taskproject-tp3',
    storageBucket: 'taskproject-tp3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBB1zgjnXbHxDNkhVWRGgAfci2xGpWDEX0',
    appId: '1:574000022604:ios:2f604328516cd25d5320e9',
    messagingSenderId: '574000022604',
    projectId: 'taskproject-tp3',
    storageBucket: 'taskproject-tp3.firebasestorage.app',
    androidClientId: '574000022604-5m9sida3sgf9ag88rhpqq6js5oqe66cj.apps.googleusercontent.com',
    iosClientId: '574000022604-oj9ak8374pjvobqp6iqso5fekuefg2da.apps.googleusercontent.com',
    iosBundleId: 'com.example.tp1Flutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBB1zgjnXbHxDNkhVWRGgAfci2xGpWDEX0',
    appId: '1:574000022604:ios:2f604328516cd25d5320e9',
    messagingSenderId: '574000022604',
    projectId: 'taskproject-tp3',
    storageBucket: 'taskproject-tp3.firebasestorage.app',
    androidClientId: '574000022604-5m9sida3sgf9ag88rhpqq6js5oqe66cj.apps.googleusercontent.com',
    iosClientId: '574000022604-oj9ak8374pjvobqp6iqso5fekuefg2da.apps.googleusercontent.com',
    iosBundleId: 'com.example.tp1Flutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBx-18FOih-6J9k-PlFFrPZK8vGczJOoQk',
    appId: '1:574000022604:web:22f6eb304d8dcc3d5320e9',
    messagingSenderId: '574000022604',
    projectId: 'taskproject-tp3',
    authDomain: 'taskproject-tp3.firebaseapp.com',
    storageBucket: 'taskproject-tp3.firebasestorage.app',
    measurementId: 'G-HESW1T736G',
  );

}