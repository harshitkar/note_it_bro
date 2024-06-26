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
    apiKey: 'AIzaSyCs-bASLvHae3u_6ljQWEk_tyepqKmGgWo',
    appId: '1:335447718566:web:f420d88414e0dda3571267',
    messagingSenderId: '335447718566',
    projectId: 'notes-098',
    authDomain: 'notes-098.firebaseapp.com',
    storageBucket: 'notes-098.appspot.com',
    measurementId: 'G-5G86KE851Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCW7jTUkYRwq5ggZVZEuKPQ6zGisSyONkQ',
    appId: '1:335447718566:android:910867028ffa4793571267',
    messagingSenderId: '335447718566',
    projectId: 'notes-098',
    storageBucket: 'notes-098.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdDBMiF6ziDeYVRMYQc878WD3I76RJ_rM',
    appId: '1:335447718566:ios:4e1edbb0a00ce0ac571267',
    messagingSenderId: '335447718566',
    projectId: 'notes-098',
    storageBucket: 'notes-098.appspot.com',
    iosClientId: '335447718566-jjs7isv88b3d8scgmg8hnd5g3jg12ihc.apps.googleusercontent.com',
    iosBundleId: 'com.gdsc.noteItBro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdDBMiF6ziDeYVRMYQc878WD3I76RJ_rM',
    appId: '1:335447718566:ios:4258e11e1d410282571267',
    messagingSenderId: '335447718566',
    projectId: 'notes-098',
    storageBucket: 'notes-098.appspot.com',
    iosClientId: '335447718566-lophe37viheqta0dlaooclqmhu3l466g.apps.googleusercontent.com',
    iosBundleId: 'com.gdsc.noteItBro.RunnerTests',
  );
}
