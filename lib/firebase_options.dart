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
    apiKey: 'AIzaSyAUnTWY4nUG-IDrVNwph8xYUX1G9S_qX3s',
    appId: '1:44127061472:web:e926980fc849388c459785',
    messagingSenderId: '44127061472',
    projectId: 'gi-todo',
    authDomain: 'gi-todo.firebaseapp.com',
    storageBucket: 'gi-todo.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwFJNJgXC8gW322vgu9uNl8UUs8xAFCMQ',
    appId: '1:44127061472:android:4ebf8b4142119d8a459785',
    messagingSenderId: '44127061472',
    projectId: 'gi-todo',
    storageBucket: 'gi-todo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAJUSoy4meLY-plxnyxAE5unmJnaCJktE',
    appId: '1:44127061472:ios:94205eda40762793459785',
    messagingSenderId: '44127061472',
    projectId: 'gi-todo',
    storageBucket: 'gi-todo.appspot.com',
    iosBundleId: 'com.example.gitodo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCAJUSoy4meLY-plxnyxAE5unmJnaCJktE',
    appId: '1:44127061472:ios:6e6a4768e7698397459785',
    messagingSenderId: '44127061472',
    projectId: 'gi-todo',
    storageBucket: 'gi-todo.appspot.com',
    iosBundleId: 'com.example.gitodo.RunnerTests',
  );
}
