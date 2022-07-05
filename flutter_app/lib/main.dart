import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/src/pages/login_page.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
//import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(LoginPage());
}
