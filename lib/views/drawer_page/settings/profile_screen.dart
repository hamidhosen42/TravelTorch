// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_tour_app/constant/constant.dart';
import 'package:flutter_tour_app/controllers/profile_controller.dart';
import 'package:flutter_tour_app/views/widgets/violetButton.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var controller = Get.put(ProfileController());

  showUserData({required data}) {
    controller.nameController.text = data['name'];
    controller.emailController.text = data['email'];
    controller.phoneController.text = data['phone_number'];
    controller.addressController.text = data['address'];

    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Image.asset(
                "assets/logo/logo.png",
                height: 250.h,
                width: 250.h,
              ),
            ),
          formField(
            controller: controller.nameController,
            inputType: TextInputType.name,
            hint: "name",
          ),
          SizedBox(height: 10),
          formField(
              controller: controller.emailController,
              inputType: TextInputType.emailAddress,
              hint: "email",
              readOnly: true),
          SizedBox(height: 10),
          formField(
            controller: controller.phoneController,
            inputType: TextInputType.phone,
            hint: "phone",
          ),
          SizedBox(height: 10),
          formField(
            controller: controller.addressController,
            inputType: TextInputType.text,
            hint: "address",
          ),
          SizedBox(height: 15),
          VioletButton(
            isLoading: false,
            title: "Update".tr,
            onAction: () {
              controller.updateData(uid: firebaseAuth.currentUser!.uid);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile".tr,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: firestore
              .collection('users')
              .doc(firebaseAuth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data;
              return showUserData(data: data);
            }
          },
        ),
      ),
    );
  }
}

Widget formField({controller, inputType, hint, readOnly = false}) {
  return TextField(
    controller: controller,
    textAlign: TextAlign.justify,
    readOnly: readOnly,
    keyboardType: inputType,
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
    ),
  );
}
