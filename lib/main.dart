// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'views/drawer_page/languages/components/app_languages.dart';
import 'views/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'Travel Agency',
          translations: AppLanguages(),
          locale: Locale('en', 'US'),
          fallbackLocale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              elevation: 0,
              color: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black,fontSize: 20.sp)
            )
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
