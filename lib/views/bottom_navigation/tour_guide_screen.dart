// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/constant.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/violet_button.dart';
import '../home/home_screen.dart';

class TourGuidePackageAddScreen extends StatefulWidget {
  const TourGuidePackageAddScreen({Key? key}) : super(key: key);

  @override
  State<TourGuidePackageAddScreen> createState() =>
      _TourGuidePackageAddScreenState();
}

class _TourGuidePackageAddScreenState extends State<TourGuidePackageAddScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _howToGOController = TextEditingController();
  final TextEditingController _liveController = TextEditingController();
  
  final ImagePicker _picker = ImagePicker();

  var authCredential = firebaseAuth.currentUser;

  RxBool isLoading = false.obs;

  List<XFile>? multipleImages;
  List<String> imageUrlList = [];

  Future multipleImagePicker() async {
    multipleImages = await _picker.pickMultiImage();
    setState(() {});
  }

  Future uploadImages() async {
    try {
      if (multipleImages != null) {
        for (int i = 0; i < multipleImages!.length; i += 1) {
          // upload to storage
          File imageFile = File(multipleImages![i].path);
          UploadTask uploadTask =
          firebaseStorage.ref("tour_guide").child(multipleImages![i].name).putFile(imageFile);

          TaskSnapshot snapshot = await uploadTask;
          String imageUrl = await snapshot.ref.getDownloadURL();
          imageUrlList.add(imageUrl);
        }

        // upload to database
        uploadToDB();
      } else {
        Fluttertoast.showToast(msg: "Something is wrong.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed");
      Get.back();
    }
  }

  uploadToDB() {
    if (imageUrlList.isNotEmpty) {
      CollectionReference data = firestore.collection("tour-guide");
      data.doc().set(
        {
          "description": _descriptionController.text,
          "cost": _costController.text,
          "destination": _destinationController.text,
          "how_to_go": _howToGOController.text,
          "live": _liveController.text,
          "gallery_img":
              FieldValue.arrayUnion(imageUrlList), //we create image list
        },
      ).whenComplete(() {
        Fluttertoast.showToast(msg: "Uploaded Successful.");
      });
      Get.to(
        () => HomeScreen(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "If you have any problems, please contact us. We are at your service all the time.",
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                customTextField(
                  "Destination",
                  _destinationController,
                  TextInputType.text,
                ),
                customTextField(
                  "Cost",
                  _costController,
                  TextInputType.number,
                ),
                customTextField(
                  "Description",
                  _descriptionController,
                  TextInputType.text,
                ),
                customTextField(
                  "How To Go",
                  _howToGOController,
                  maxline: 4,
                  TextInputType.text,
                ),
                customTextField(
                  "Live",
                  _liveController,
                  maxline: 4,
                  TextInputType.text,
                ),
                Text(
                  "Choose Images",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFE9EBED),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.r),
                    ),
                  ),
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: () => multipleImagePicker(),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: multipleImages?.length ?? 0,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SizedBox(
                          width: 100,
                          child: multipleImages?.length == null
                              ? const Center(
                                  child: Text("Images are empty"),
                                )
                              : Image.file(
                                  File(multipleImages![index].path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 50.h),
                Obx(() {
                  return VioletButton(
                    isLoading: isLoading.value,
                    title: "Upload",
                    onAction: () async {
                      if (_destinationController.text.isEmpty ||
                          _destinationController.text.length < 3) {
                        Fluttertoast.showToast(
                            msg: "Name must be at least 3 character");
                      } else if (_costController.text.isEmpty ||
                          _costController.text.length < 3) {
                        Fluttertoast.showToast(
                            msg: "cost must be at least 3 character");
                      } else if (_descriptionController.text.isEmpty ||
                          _descriptionController.text.length < 3) {
                        Fluttertoast.showToast(
                            msg: "description must be at least 3 character");
                      } else if (_howToGOController.text.isEmpty ||
                          _howToGOController.text.length < 3) {
                        Fluttertoast.showToast(
                            msg: "facility must be at least 3 character");
                      } else if (_liveController.text.isEmpty ||
                          _liveController.text.length < 3) {
                        Fluttertoast.showToast(
                            msg: "destination must be at least 3 character");
                      } else {
                        isLoading(true);
                        await uploadImages();
                        isLoading(false);
                        Get.back();
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
