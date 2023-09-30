import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget supportField(title, value) {
  TextEditingController supportDataController =
      TextEditingController(text: value);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
        ),
      ),
      TextField(
        controller: supportDataController,
        readOnly: true,
      ),
      SizedBox(
        height: 20.h,
      ),
    ],
  );
}
