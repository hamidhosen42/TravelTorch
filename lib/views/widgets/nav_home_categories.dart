// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget navHomeCategories({required String categoryName, required onClick}) {
  return Padding(
    padding: EdgeInsets.only(left: 25.w, right: 25.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          categoryName,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        InkWell(
          onTap: onClick,
          child: Text(
            "seeMore".tr,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2BA018)),
          ),
        ),
      ],
    ),
  );
}
