// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_tour_app/controllers/package_controller.dart';
import 'package:flutter_tour_app/widgets/custom_text_field.dart';

import '../../../widgets/violet_button.dart';

class PackageEdit extends StatefulWidget {
  final dynamic data;
  final String docId;
  const PackageEdit({Key? key, required this.data, required this.docId})
      : super(key: key);

  @override
  State<PackageEdit> createState() => _PackageEditState();
}

class _PackageEditState extends State<PackageEdit> {
  PackageController controller = Get.put(PackageController());

  @override
  void initState() {
    super.initState();

    controller.nameController.text = widget.data['owner_name'];
    controller.costController.text = widget.data['cost'].toString();
    controller.descController.text = widget.data['description'];
    controller.destinationController.text = widget.data['destination'];
    controller.facilitiesController.text = widget.data['facilities'];
    controller.phoneController.text = widget.data['phone'];

    log(widget.docId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "${widget.data['destination']}",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customTextField(
                "Owner name:",
                controller.nameController,
                TextInputType.text,
              ),
              customTextField(
                "Cost:",
                controller.costController,
                TextInputType.number,
              ),
              customTextField(
                "Description:",
                controller.descController,
                TextInputType.text,
              ),
              customTextField(
                "Destination:",
                controller.destinationController,
                TextInputType.text,
              ),
              customTextField(
                "Facilities:",
                controller.facilitiesController,
                TextInputType.text,
              ),
              customTextField(
                "Phone:",
                controller.phoneController,
                TextInputType.number,
              ),
              SizedBox(height: 15.h),
              VioletButton(
                isLoading: false,
                title: "Update",
                onAction: () {
                  controller.updateData(docId: widget.docId);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
