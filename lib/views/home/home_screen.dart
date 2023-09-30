// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_tour_app/controllers/package_controller.dart';
import 'package:flutter_tour_app/services/firestore_services.dart';

import '../../widgets/dashboard_button.dart';
import '../bottom_navigation/package/packages_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final PackageController controller = Get.put(PackageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Center(
            child: Text(
              intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder(
                  stream: FirestoreServices.getAllApprovedPackage(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return dashboardButton(
                        context: context,
                        title: "Packages",
                        quantity: snapshot.data!.docs.length.toString(),
                        icon: "assets/icons/products.png",
                      );
                    }
                  },
                ),
                StreamBuilder(
                  stream: FirestoreServices.getTotalSelfPackage(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return dashboardButton(
                        context: context,
                        title: "Tour Guide",
                        quantity: snapshot.data!.docs.length.toString(),
                        icon: "assets/icons/direction.png",
                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder(
                  stream: FirestoreServices.getTotalPendingPackage(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return dashboardButton(
                        context: context,
                        title: "Pending",
                        quantity: snapshot.data!.docs.length.toString(),
                        icon: "assets/icons/clock.png",
                      );
                    }
                  },
                ),
                StreamBuilder(
                  stream: FirestoreServices.getTotalUsers(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return dashboardButton(
                        context: context,
                        title: "Total Users",
                        quantity: snapshot.data!.docs.length.toString(),
                        icon: "assets/icons/users.png",
                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Divider(color: Colors.grey),
            SizedBox(height: 15.h),
            Text(
              "Pending Package:",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10.h),
            StreamBuilder(
              stream: FirestoreServices.getPendingPackages(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                    child: ListView(
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          var data = snapshot.data!.docs[index];
                          return Card(
                            child: ListTile(
                              onTap: () => Get.to(
                                  () => PackageDetailsScreen(data: data)),
                              leading: Image.network(
                                data['gallery_img'][0],
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                              title: Text(data['destination']),
                              subtitle: Text("${data['cost']} BDT"),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: InkWell(
                                      onTap: () {
                                        controller.approvedPackage(
                                            docId: data.id);
                                        Fluttertoast.showToast(msg: "Approved");
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/box.png',
                                            height: 30.h,
                                            width: 30.w,
                                          ),
                                          SizedBox(width: 10.w),
                                          Text("Approved"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: InkWell(
                                      onTap: () {
                                        controller.deletePackage(
                                            docId: data.id);
                                        Fluttertoast.showToast(msg: "delete");
                                        Get.back();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete),
                                          SizedBox(width: 10.w),
                                          Text("Delete"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
