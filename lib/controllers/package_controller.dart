import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';

class PackageController extends GetxController {
  var costController = TextEditingController();
  var descController = TextEditingController();
  var destinationController = TextEditingController();
  var facilitiesController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  updateData({required docId}) {
    var ref = firestore.collection("all-data").doc(docId);
    int cost = int.parse(costController.text);
    try {
      ref
          .update({
            'cost': cost,
            "forYou": true,
            "topPlaces": cost >= 2000 && cost <= 5000 ? true : false,
            "economy": cost <= 3000 ? true : false,
            "luxury": cost >= 10000 ? true : false,
            'description': descController.text.toString(),
            'destination': destinationController.text.toString(),
            'facilities': facilitiesController.text.toString(),
            'owner_name': nameController.text.toString(),
            'phone': phoneController.text.toString(),
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
        msg: e.toString(),
        backgroundColor: Colors.black87,
      );
    }
  }

  //for delete package:
  deletePackage({required docId}) {
    firestore.collection('all-data').doc(docId).delete();
  }

  // for approved package
  approvedPackage({required docId}) {
    firestore.collection("all-data").doc(docId).set({
      "approved": true,
    }, SetOptions(merge: true));
  }
}
