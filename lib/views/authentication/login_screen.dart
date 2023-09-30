// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_tour_app/views/home.dart';

import '../../constants/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/violet_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/logo/logo.png",
                  height: 180,
                  width: 180,
                ),
              ),
              SizedBox(height: 50.h),
              Text(
                "Login\nTo Your Account",
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.violetColor,
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              ),
              TextFormField(
                controller: controller.passwordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  hintStyle: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Obx(() {
                return VioletButton(
                  isLoading: controller.isLoading.value,
                  title: "Log in",
                  onAction: () {
                    controller.isLoading(true);
                    Future.delayed(Duration(seconds: 3), () {
                      if (controller.emailController.text ==
                              "admin@gmail.com" &&
                          controller.passwordController.text == "admin@123") {
                        Get.offAll(() => Home());
                        controller.isLoading(false);
                      } else {
                        Fluttertoast.showToast(
                          msg: "Email or password is incorrect",
                        );
                        controller.isLoading(false);
                      }
                    });
                  },
                );
              }),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
