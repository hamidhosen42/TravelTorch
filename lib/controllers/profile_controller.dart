import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  getUserData({required uid})async{
    //for user data
    DocumentSnapshot userDoc =
    await firestore.collection('users').doc(uid).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String email = userData['email'];
    String phone = userData['phone_number'];

    _user.value = {
      "name": name,
      "email": email,
      "phone_number": phone,
    };
    update();
  }

  updateData({required uid}) {
    var ref = firestore.collection(usersCollection).doc(uid);
    try {
      ref
          .update({
            'name': nameController.text,
            'email': emailController.text,
            'phone_number': phoneController.text,
            'address': addressController.text,
          })
          .then(
            (value) => Fluttertoast.showToast(
                msg: "Updated Successfully", backgroundColor: Colors.black87),
          )
          .then(
            (value) => Get.back(),
          );
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something is wrong", backgroundColor: Colors.black87);
    }
  }
}
