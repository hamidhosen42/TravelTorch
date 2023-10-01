// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/app_colors.dart';
import '../../main.dart';

class AppStyle {
  TextStyle myTextStyle = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
    color:
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white,
  );

  TextStyle signUpTextStyle = TextStyle(
      fontSize: 40.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.violetColor);

  InputDecoration textFieldDecoration(String hint, IconData icon) =>
      InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black45,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFFABB3BB),
          height: 1.0,
        ),
      );
  progressDialog(context) => showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("Processing"),
              ],
            ),
          ),
        ),
      );
}
