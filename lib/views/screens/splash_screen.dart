// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/views/auth/login_screen.dart';
import 'package:travel_agency/views/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
        (){
        firebaseAuth.authStateChanges().listen((event) {
          if(event == null && mounted){
            Get.offAll(()=> SignInScreen());
          }else{
            Get.offAll(()=> HomeScreen());
          }
        });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/logo/logo2.png',
                height: 230.h,
                width: 230.w,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10.h),
              const CircularProgressIndicator(),
              Column(
                children: [
                  Text(
                    "Travello",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "A dew drops on a grain of rice",
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
