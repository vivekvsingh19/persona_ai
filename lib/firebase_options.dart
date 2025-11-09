import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```
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
          'DefaultFirebaseOptions has not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions has not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions has not been configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCTYijMotkeuUY8I8LitV54qRVgNb22YcI',
    appId: '1:158986913917:web:placeholder',
    messagingSenderId: '158986913917',
    projectId: 'persona-ai-b0d88',
    authDomain: 'persona-ai-b0d88.firebaseapp.com',
    storageBucket: 'persona-ai-b0d88.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTYijMotkeuUY8I8LitV54qRVgNb22YcI',
    appId: '1:158986913917:android:4767920fdb143679070914',
    messagingSenderId: '158986913917',
    projectId: 'persona-ai-b0d88',
    storageBucket: 'persona-ai-b0d88.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTYijMotkeuUY8I8LitV54qRVgNb22YcI',
    appId: '1:158986913917:ios:placeholder',
    messagingSenderId: '158986913917',
    projectId: 'persona-ai-b0d88',
    storageBucket: 'persona-ai-b0d88.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTYijMotkeuUY8I8LitV54qRVgNb22YcI',
    appId: '1:158986913917:ios:placeholder',
    messagingSenderId: '158986913917',
    projectId: 'persona-ai-b0d88',
    storageBucket: 'persona-ai-b0d88.firebasestorage.app',
  );
}
