// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/controllers/profile_controller.dart';
import 'package:travel_agency/views/styles.dart';
import 'package:travel_agency/views/widgets/violetButton.dart';

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
          formField(
            controller: controller.nameController,
            inputType: TextInputType.name,
            hint: "name",
          ),
          formField(
            controller: controller.emailController,
            inputType: TextInputType.emailAddress,
            hint: "email",
            readOnly: true
          ),
          formField(
            controller: controller.phoneController,
            inputType: TextInputType.phone,
            hint: "phone",
          ),
          formField(
            controller: controller.addressController,
            inputType: TextInputType.text,
            hint: "address",
          ),
          SizedBox(height: 15),
          VioletButton(
            isLoading: false,
            title: "update".tr,
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
        title: Text("profile".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    readOnly: readOnly,
    decoration: AppStyles().textFieldDecoration(hint),
  );
}
