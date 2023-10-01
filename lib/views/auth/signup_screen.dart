// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_final_fields, override_on_non_overriding_member, unused_element, prefer_const_constructors

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tour_app/views/styles/style.dart';
import 'package:get/get.dart';
import 'package:flutter_tour_app/constant/app_colors.dart';
import 'package:flutter_tour_app/controllers/auth_controller.dart';
import 'package:flutter_tour_app/views/auth/login_screen.dart';
import 'package:flutter_tour_app/views/widgets/violetButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../controllers/text_field_controller.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  // ! ------------- authController---------------
  final authController = Get.put(AuthController());

  final _controller = Get.put(TextFieldController());

  late StreamSubscription subscription;

  bool isDeviceConnected = false;

  bool isAlertSet = false;

  // !------------------validation----------------
  bool _validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  bool _validatePhoneNumber(String phoneNumber) {
    return phoneNumber.isNotEmpty && phoneNumber.length >= 11;
  }

  // bool _validateAddress(String address) {
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
            showDialogBox("", "");
            setState(() => isAlertSet = true);
          }
        },
      );

  final List<String> items = [
    'Barishal',
    'Chattogram',
    'Dhaka',
    'Khulna',
    'Rajshahi',
    'Rangpur',
    'Mymensingh',
    'Sylhet',
  ];

  String? selectedValue;

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
                height: 50.h,
              ),
              Center(
                child: Image.asset(
                  "assets/logo/logo.png",
                  height: 250.h,
                  width: 250.w,
                ),
              ),
              Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              // !----------------------Name Field------------------------
              TextFormField(
                style: GoogleFonts.inter(
                  fontSize: 18.0,
                  color: const Color(0xFF151624),
                ),
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration:
                    AppStyle().textFieldDecoration("Full Name", Icons.person),
              ),
              SizedBox(
                height: 10.h,
              ),

              // !----------------------Email Field------------------------
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
                height: 10.h,
              ),
              // !----------------------Password Field------------------------
              Obx(() {
                return TextFormField(
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
                height: 10.h,
              ),
              // !----------------------Phone Field------------------------
              TextFormField(
                style: GoogleFonts.inter(
                  fontSize: 18.0,
                  color: const Color(0xFF151624),
                ),
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration:
                    AppStyle().textFieldDecoration("Phone Number", Icons.call),
              ),

              SizedBox(
                height: 10.h,
              ),
              // !----------------------address Field------------------------
              Container(
                height: 70.h,
                decoration: BoxDecoration(
                  // Background color of the container
                  border: Border.all(
                    // Border properties
                    color: Colors.black, // Border color
                    width: 1, // Border width
                  ),
                  borderRadius: BorderRadius.circular(
                      10), // Border radius to make it rounded
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Bangladesh District',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      height: 40,
                      width: double.infinity,
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: 40.h,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(() {
                return VioletButton(
                  isLoading: authController.isLoading.value,
                  title: 'Create Account',
                  onAction: () async {
                    authController.isLoading(true);

                    await authController.userRegistration(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      number: _phoneController.text.toString(),
                      address: selectedValue.toString(),
                    );
                    authController.isLoading(false);
                  },
                );
              }),
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  text: "Already an user?  ",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Log In",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.violetColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignInScreen()),
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

  showDialogBox(String title, String message) => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}