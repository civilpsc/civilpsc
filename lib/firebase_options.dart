// lib/firebase_options.dart

// ignore_for_file: constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
    // iOS / web later add cheyyam
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // 👉 ഇവിടത്തെ values നിന്റെ google-services.json-ൽ നിന്നുള്ളതാണു
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAu2s7vPF_Dj8T7eVfeNqzpxyF2DRJ7su0',
    appId: '1:536054975472:android:bf63aac6c29979a0d16b35',
    messagingSenderId: '536054975472',
    projectId: 'civilpsc-9b1ad',
    storageBucket: 'civilpsc-9b1ad.firebasestorage.app',
  );
}
