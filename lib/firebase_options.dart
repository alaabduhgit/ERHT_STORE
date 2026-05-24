import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBRsOafnXdhncA-mXo76Z3k6LaPxvwGxoQ',
    authDomain: 'erth-store.firebaseapp.com',
    projectId: 'erth-store',
    storageBucket: 'erth-store.firebasestorage.app',
    messagingSenderId: '61097485795',
    appId: '1:61097485795:web:502cdab08593411b02a756',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRsOafnXdhncA-mXo76Z3k6LaPxvwGxoQ',
    appId:
        '1:61097485795:android:502cdab08593411b02a756', 
    messagingSenderId: '61097485795',
    projectId: 'erth-store',
    storageBucket: 'erth-store.firebasestorage.app',
  );
}
