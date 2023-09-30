// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextField(title, TextEditingController nameController, {maxline,onlyRead}) {
  return Column(
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
          readOnly: onlyRead,
          maxLines: maxline,
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
  );
}
