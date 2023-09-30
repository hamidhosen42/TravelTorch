// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_tour_app/controllers/package_controller.dart';
import 'package:flutter_tour_app/services/firestore_services.dart';
import 'package:flutter_tour_app/views/bottom_navigation/package/add_tour_screen.dart';
import 'package:flutter_tour_app/views/bottom_navigation/package/package_edit.dart';
import 'package:flutter_tour_app/views/bottom_navigation/package/packages_details.dart';

class PackagesScreen extends StatelessWidget {
  PackagesScreen({Key? key}) : super(key: key);

  PackageController controller = Get.put(PackageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Packages",
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(46, 41, 78, 1),
        onPressed: () => Get.to(() => const AddTourScreen()),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllApprovedPackage(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                  snapshot.data.docs.length,
                  (index) {
                    var data = snapshot.data.docs[index];
                    return Card(
                      child: ListTile(
                        onTap: () =>
                            Get.to(() => PackageDetailsScreen(data: data)),
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
                                  Get.to(() => PackageEdit(
                                        data: data,
                                        docId: data.id,
                                      ));
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 10.w),
                                    Text("Edit"),
                                  ],
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              child: InkWell(
                                onTap: () {
                                  controller.deletePackage(docId: data.id);
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
    );
  }
}
