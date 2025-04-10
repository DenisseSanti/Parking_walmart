import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Opciones por plataforma para inicializar Firebase
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions no está configurado para Android.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions no está configurado para iOS.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions no está configurado para macOS.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions no está configurado para Windows.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions no está configurado para Linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions no está soportado en esta plataforma.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC7Pmwol0N9og97BSVuBOPj8FY8Fo-TtK4',
    authDomain: 'proyectoapp-50f5c.firebaseapp.com',
    databaseURL: 'https://proyectoapp-50f5c-default-rtdb.firebaseio.com',
    projectId: 'proyectoapp-50f5c',
    storageBucket: 'proyectoapp-50f5c.appspot.com',
    messagingSenderId: '605045039941',
    appId: '1:605045039941:web:68b697dba6061e0f4c942c',
    measurementId: 'G-B34M9BESEE',
  );
}
