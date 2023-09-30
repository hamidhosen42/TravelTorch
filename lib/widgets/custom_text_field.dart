// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextField(String title, TextEditingController nameController,
    TextInputType textInputType,
    {maxline}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFE9EBED),
            borderRadius: BorderRadius.all(
              Radius.circular(7.r),
            ),
          ),
          child: TextField(
            controller: nameController,
            maxLines: maxline,
            keyboardType: textInputType,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.w),
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    ),
  );
}
