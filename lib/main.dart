import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/screens/landing/landing.dart';
import 'package:whc_admin/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "Your-api-key-here",
      appId: "Your-app-id-here",
      messagingSenderId: "Your-messaging-sender-id-here",
      storageBucket: "Your-storage-bucket-here",
      projectId: "Your-project-id-here"));
  runApp(GetMaterialApp(
    home: const landing(),
    theme: ThemeData(
      primarySwatch: kPrimarySwatch,
      primaryColor: kPrimaryColor,
      canvasColor: kCanvasColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kPrimaryColor)
        )
      )
    ),
  ));
}