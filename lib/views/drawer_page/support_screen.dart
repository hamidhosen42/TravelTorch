// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tour_app/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_tour_app/views/widgets/support_feild.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Support".tr,style: TextStyle(fontSize: 25.sp),),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: Column(
          children: [
            Text(
              "If you have any questions or concerns about this Privacy Policy, please contact us at [contact email]".tr,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
            Divider(
              color:AppColors.textColor,
            ),
            supportField("Phone".tr, "01752099119"),
            supportField("Email".tr, "traveltorch@gmail.com"),
            supportField("Facebook".tr, "http://facebook.com/traveltorch"),
          ],
        ),
      ),
    );
  }
}
