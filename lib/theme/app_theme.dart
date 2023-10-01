import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/app_colors.dart';


class AppTheme {
  ThemeData lightTheme(context) => ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.black),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        colorScheme: const ColorScheme.light(),
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(),
        ),
        scaffoldBackgroundColor: AppColors.scaffoldColor,
      );

  ThemeData darkTheme(context) => ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        colorScheme: const ColorScheme.dark(),
        primarySwatch: Colors.amber,
        textTheme: GoogleFonts.actorTextTheme(
          Theme.of(context).textTheme.apply(),
        ),
        scaffoldBackgroundColor: Colors.black38,
      );
}
