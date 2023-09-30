// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/views/widgets/support_feild.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("support".tr),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: Column(
          children: [
            Text(
              "supportMessage".tr,
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
            Divider(
              color: Colors.blue,
            ),
            supportField("phone".tr, "01316-255373"),
            supportField("email".tr, "abctourguide@gmail.com"),
            supportField("facebook".tr, "http://facebook.com/abctourguide"),
          ],
        ),
      ),
    );
  }
}
