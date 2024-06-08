import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/screens/login.dart';
import 'package:whc_admin/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyA4cUpI_1Ffu_Gll9g-TKUpBqWuF7gujDA",
      appId: "1:917340158873:web:69873976727017c113b108",
      messagingSenderId: "917340158873",
      storageBucket: "wah-health-and-care.appspot.com",
      projectId: "wah-health-and-care"));
  runApp(GetMaterialApp(
    title: 'Admin - Wah Health & Care',
    home: const Login(),
    theme: ThemeData(
      colorSchemeSeed: kPrimaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
          foregroundColor: MaterialStateProperty.all(kWhite),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))
        )
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              foregroundColor: MaterialStateProperty.all(kPrimaryColor),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))
          )
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              foregroundColor: MaterialStateProperty.all(kPrimaryColor),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))
          )
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        ),
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhite
      )
    ),
  ));
}