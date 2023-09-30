// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/services/firestore_services.dart';
import 'package:travel_agency/views/bottom_nav_controller/pages/home/nav_home_screen.dart';

import 'details_screen.dart';

class SeeAllScreen2 extends StatefulWidget {
  const SeeAllScreen2({
    super.key,
  });

  @override
  State<SeeAllScreen2> createState() => _SeeAllScreen2State();
}

class _SeeAllScreen2State extends State<SeeAllScreen2> {
  //collectionName
  final CollectionReference _refference = firestore.collection('all-data');

  //queryName
  late Future<QuerySnapshot> _futureDataLuxuryPackage;

  @override
  void initState() {
    _futureDataLuxuryPackage = FirestoreServices.getLuxuryPackage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 231, 229),
      appBar: AppBar(
        title: Text(
          "seeAll".tr,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: FutureBuilder<QuerySnapshot>(
          future: _futureDataLuxuryPackage,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            if (snapshot.hasData) {
              List<Map> items = parseData(snapshot.data);
              return forYouBuildGridview(items);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

GridView forYouBuildGridview(List<Map<dynamic, dynamic>> itemList) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    ),
    itemCount: itemList.length,
    itemBuilder: (_, i) {
      Map thisItem = itemList[i];
      return InkWell(
        onTap: () => Get.to(
          () => DetailsScreen(detailsData: thisItem),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 212, 196, 196),
            borderRadius: BorderRadius.all(
              Radius.circular(7.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.r),
                  topRight: Radius.circular(7.r),
                ),
                child: Image.network(
                  thisItem['list_images'][0],
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                thisItem['list_destination'],
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Color.fromARGB(255, 59, 80, 27),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${thisItem['list_cost']} BDT",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}
