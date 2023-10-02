// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tour_app/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constant/app_strings.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Faq"
                  .tr
                  .text
                  .size(28.sp)
                  .fontWeight(FontWeight.w500)
                  .makeCentered(),
              40.h.heightBox,
              customExpansionTile(
                  title: faqTitle1.tr, description: faqDescription1.tr),
              5.h.heightBox,
              Divider(),
              5.h.heightBox,
              customExpansionTile(
                  title: faqTitle2.tr, description: faqDescription2.tr),
              5.h.heightBox,
              Divider(),
              5.h.heightBox,
              customExpansionTile(
                  title: faqTitle3.tr, description: faqDescription3.tr),
              5.h.heightBox,
              Divider(),
              5.h.heightBox,
              customExpansionTile(
                  title: faqTitle4.tr, description: faqDescription4.tr),
              5.h.heightBox,
              Divider(),
              5.h.heightBox,
              customExpansionTile(
                  title: faqTitle5.tr, description: faqDescription5.tr),
            ],
          ),
        ),
      ),
    );
  }

  ExpansionTile customExpansionTile(
      {required String title, required String description}) {
    return ExpansionTile(
      backgroundColor: AppColors.scaffoldColor,
      collapsedTextColor: AppColors.textColor,
      iconColor: AppColors.textColor,
      textColor: AppColors.textColor,
      childrenPadding: EdgeInsets.all(10.h),
      title: Text(title),
      children: [description.text.black.make()],
    );
  }
}