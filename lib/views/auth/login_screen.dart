// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_final_fields, prefer_const_constructors

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_tour_app/constant/app_colors.dart';
import 'package:flutter_tour_app/controllers/auth_controller.dart';
import 'package:flutter_tour_app/views/auth/signup_screen.dart';
import 'package:flutter_tour_app/views/widgets/violetButton.dart';

import '../../controllers/text_field_controller.dart';
import '../styles/style.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // ! ------------- authController---------------
  final authController = Get.put(AuthController());
  final _controller = Get.put(TextFieldController());

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // !------------validation--------------
  bool _validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Center(
                child: Image.asset(
                  "assets/logo/logo.png",
                  height: 250.h,
                  width: 250.w,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Login\nTo Your Account",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              // !------------Email Text Field--------------
              TextFormField(
                style: GoogleFonts.inter(
                  fontSize: 18.0,
                  color: const Color(0xFF151624),
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: AppStyle()
                    .textFieldDecoration("Enter your email", Icons.mail),
              ),
              SizedBox(
                height: 20.h,
              ),
              // !------------Password Text Field--------------
              Obx(() {
                return TextFormField(
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: const Color(0xFF151624),
                  ),
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_open,
                      color: Colors.black45,
                    ),
                    hintText: "Password",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: const Color(0xFFABB3BB),
                      height: 1.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _controller.isPasswordHiden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        _controller.isPasswordHiden.value =
                            !_controller.isPasswordHiden.value;
                      },
                    ),
                  ),
                  obscureText: _controller.isPasswordHiden.value,
                  validator: (value) {
                    if (!_validatePassword(value ?? '')) {
                      return 'Invalid password';
                    }
                    return null;
                  },
                );
              }),
              SizedBox(
                height: 40.h,
              ),

              // !----------------Sign In Buttom-------------
              Obx(() {
                return VioletButton(
                  isLoading: authController.isLoading.value,
                  title: "Log in",
                  onAction: () async {
                    authController.isLoading(true);
                    await authController.userLogin(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    authController.isLoading(false);
                  },
                );
              }),
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  text: "Don’t have registered yet?  ",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.violetColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignUpScreen()),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}