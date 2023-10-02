import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget detailsHeadingDescription({required title, required description}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22.sp,
        ),
      ),
      SizedBox(height: 5.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 2.h),
        child: Text(
          description,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 17.sp,
          ),
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
    ],
  );
}
