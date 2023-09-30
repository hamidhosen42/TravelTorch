// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/app_strings.dart';
import 'package:travel_agency/controllers/language_controller.dart';
import 'package:travel_agency/views/drawer_page/faq_screen.dart';
import 'package:travel_agency/views/drawer_page/privacy_policy_screen.dart';
import 'package:travel_agency/views/drawer_page/settings/settings_screen.dart';
import 'package:travel_agency/views/drawer_page/support_screen.dart';
import 'package:travel_agency/views/widgets/drawer_item.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({Key? key}) : super(key: key);

  final controller = Get.put(LanguageControler());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white.withOpacity(.10),
            Colors.orangeAccent.withOpacity(.10),
            Colors.white.withOpacity(.10),
            Colors.red.withOpacity(.10),
          ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 50.h, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "appName".tr,
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                "slogan".tr,
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 40.h),
              drawerItem(
                itemName: 'support'.tr,
                onClick: () => Get.to(() => SupportScreen()),
              ),
              SizedBox(height: 8.h),
              drawerItem(
                itemName: 'privacy'.tr,
                onClick: () => Get.to(() => PrivacyPolicyScreen()),
              ),
              SizedBox(height: 8.h),
              drawerItem(
                itemName: 'faq'.tr,
                onClick: () => Get.to(
                  () => FaqScreen(),
                ),
              ),
              SizedBox(
                width: 150.w,
                child: ExpansionTile(
                  title: Text("language".tr),
                  tilePadding: EdgeInsets.all(0.0),
                  childrenPadding: EdgeInsets.all(0.0),
                  children: [
                    Obx(() {
                      return Row(
                        children: [
                          Radio(
                            value: "Bangla",
                            groupValue: controller.selectedLanguage.value,
                            onChanged: (value) {
                              controller.changeLanguage(value);
                              Get.updateLocale(const Locale('bn', 'BD'));
                            },
                          ),
                          Text("bangla".tr),
                        ],
                      );
                    }),
                    Obx(() {
                      return Row(
                        children: [
                          Radio(
                            value: "English",
                            groupValue: controller.selectedLanguage.value,
                            onChanged: (value) {
                              controller.changeLanguage(value);
                              Get.updateLocale(const Locale('en', 'US'));
                            },
                          ),
                          Text("english".tr),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              InkWell(
                onTap: () => Get.to(() => SettingScreen()),
                child: Text(
                  "settings".tr,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
