// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constant/app_colors.dart';
import 'constant/app_strings.dart';
import 'theme/theme_manager.dart';
import 'route/route.dart';
import 'views/screens/splash_screen.dart';

void main() async {
  // ! ------------Firbase initialzation-----------------

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(App());
}

ThemeManager themeManager = ThemeManager(ThemeMode.light);

class App extends StatelessWidget {
  //! Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    name: "TravelTorch",
    options: FirebaseOptions(
        apiKey: "AIzaSyAbVWkmu-BkoFX-XOUMrlG2XpCt3gh8t4c",
        appId: "1:749853884352:android:0ab9aa6b49a10ea6a25225",
        messagingSenderId: "749853884352",
        projectId: "flutter-tour-app-dae95"),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //! Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme.apply()),
              scaffoldBackgroundColor: AppColors.scaffoldColor,
              appBarTheme: AppBarTheme(
                  elevation: 0,
                  color: Colors.transparent,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle:
                      TextStyle(color: Colors.black, fontSize: 20.sp))),
          initialRoute: splash,
          getPages: getPages,

          // !-----------splash screen-----------------

          home: SplashScreen(),
          // home: Home(),
        );
      },
    );
  }
}