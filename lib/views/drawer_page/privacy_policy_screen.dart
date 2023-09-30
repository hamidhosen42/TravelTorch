// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("privacyPolicy".tr)),
      body: Padding(
        padding: EdgeInsets.all(18.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "intro".tr,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              10.h.heightBox,
              Text(
                "heading".tr,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ),
              15.h.heightBox,
              customDescriptionText(title: 'title1',desc: "desc1"),
              10.h.heightBox,
              customDescriptionText(title: 'title2',desc: "desc2"),
              10.h.heightBox,
              customDescriptionText(title: 'title3',desc: "desc3"),
              10.h.heightBox,
              customDescriptionText(title: 'title4',desc: "desc4"),
              10.h.heightBox,
              customDescriptionText(title: 'title5',desc: "desc5"),
              10.h.heightBox,
              customDescriptionText(title: 'title6',desc: "desc6"),
              10.h.heightBox,
              customDescriptionText(title: 'title6',desc: "desc6"),
              10.h.heightBox,
              customDescriptionText(title: 'title7',desc: "desc7"),
              10.h.heightBox,
              customDescriptionText(title: 'title8',desc: "desc8"),
              10.h.heightBox,
               Text(
                "conclusion".tr,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customDescriptionText({required String title, required String desc}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        5.h.heightBox,
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            desc.tr,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
