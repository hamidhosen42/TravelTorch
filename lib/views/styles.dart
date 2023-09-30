// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  TextStyle myTextStyle =
  TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp);

  InputDecoration textFieldDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 18.sp,
    ),
  );

  progressDialog(context) => showDialog(
    context: context,
    builder: (_) => Dialog(
      child: SizedBox(
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
