
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
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
    apiKey: 'AIzaSyDMEX8dPh72PqkVo30D2aqSmx6aLwIJJ_I',
    appId: '1:1084270898310:web:18f42a0024df19984bb507',
    messagingSenderId: '1084270898310',
    projectId: 'hotel-app-648dd',
    authDomain: 'hotel-app-648dd.firebaseapp.com',
    storageBucket: 'hotel-app-648dd.firebasestorage.app',
    measurementId: 'G-98SDW3L6GF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3_v9A7qfhZ3kcBT0LJAoGIvQ8IdtMgf0',
    appId: '1:1084270898310:android:17c4d253d55b03ea4bb507',
    messagingSenderId: '1084270898310',
    projectId: 'hotel-app-648dd',
    storageBucket: 'hotel-app-648dd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuDIwz3ZIHvZbFHZdCBOdtC8sVEv4o_Y0',
    appId: '1:1084270898310:ios:8936e31734bde0434bb507',
    messagingSenderId: '1084270898310',
    projectId: 'hotel-app-648dd',
    storageBucket: 'hotel-app-648dd.firebasestorage.app',
    iosBundleId: 'com.example.hotelApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDMEX8dPh72PqkVo30D2aqSmx6aLwIJJ_I',
    appId: '1:1084270898310:web:5619c9416f395cf94bb507',
    messagingSenderId: '1084270898310',
    projectId: 'hotel-app-648dd',
    authDomain: 'hotel-app-648dd.firebaseapp.com',
    storageBucket: 'hotel-app-648dd.firebasestorage.app',
    measurementId: 'G-XF3T5NBQCL',
  );
}
