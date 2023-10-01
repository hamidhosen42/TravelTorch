// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// ignore: unnecessary_const, constant_identifier_names
const PRIMAY_COLOR = const Color.fromARGB(255, 56, 206, 243);

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: PRIMAY_COLOR,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: PRIMAY_COLOR,
      elevation: 10,
    ),
  ),
  hintColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.black),
    headline2: TextStyle(color: Colors.black),
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  hintColor: Colors.blueAccent,
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.white),
    headline2: TextStyle(color: Colors.white),
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
  ),
);
