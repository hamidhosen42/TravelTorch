import 'package:flutter/material.dart';

class AppTheme {
  //light theme
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
  );

  //dark theme
  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}
