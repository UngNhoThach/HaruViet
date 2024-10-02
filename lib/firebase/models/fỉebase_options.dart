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
    apiKey: 'AIzaSyADFnUzm7BNjeDqmvMC6FhGOp2ZyvsLEho',
    appId: '1:441828524688:web:7221ac70c84a4bf9ae4e15',
    messagingSenderId: '143931690737',
    projectId: 'office-one-ac86f',
    authDomain: 'office-one-ac86f.firebaseapp.com',
    storageBucket: 'office-one-ac86f.appspot.com',
    measurementId: 'G-ZG3MTGNMKS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKDHZIZLUDm7gVove8m1hcbKBd6rIRx8I',
    appId: '1:441828524688:android:bff5d7e904875a21ae4e15',
    messagingSenderId: '143931690737',
    projectId: 'office-one-ac86f',
    storageBucket: 'office-one-ac86f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQebz7fINLate_X7gunllEbHSCMMEJYiU',
    appId: '1:441828524688:ios:9e9b0a2d32138c2eae4e15',
    messagingSenderId: '143931690737',
    projectId: 'office-one-ac86f',
    storageBucket: 'office-one-ac86f.appspot.com',
    iosClientId:
        '143931690737-uod4t3kmjlitbu0p1dvnrngq1ke4ij2l.apps.googleusercontent.com',
    iosBundleId: 'com.example.officeOnePro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBQebz7fINLate_X7gunllEbHSCMMEJYiU',
    appId: '1:441828524688:ios:9e9b0a2d32138c2eae4e15',
    messagingSenderId: '143931690737',
    projectId: 'office-one-ac86f',
    storageBucket: 'office-one-ac86f.appspot.com',
    iosClientId:
        '143931690737-uod4t3kmjlitbu0p1dvnrngq1ke4ij2l.apps.googleusercontent.com',
    iosBundleId: 'com.example.officeOnePro',
  );
}
