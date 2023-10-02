// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_tour_app/services/firestore_services.dart';
import 'package:flutter_tour_app/views/bottom_nav_controller/pages/home/nav_home_screen.dart';

import 'details_screen.dart';

class EconomyAllScreen extends StatefulWidget {
  const EconomyAllScreen({Key? key}) : super(key: key);

  @override
  State<EconomyAllScreen> createState() => _EconomyAllScreenState();
}

class _EconomyAllScreenState extends State<EconomyAllScreen> {


  //queryName
  late Future<QuerySnapshot> _futureDataEconomyPackage;

  @override
  void initState() {
    _futureDataEconomyPackage = FirestoreServices.getEconomyPackage();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 231, 229),
      appBar: AppBar(
        title: Text(
         "All Economy".tr,
         style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: FutureBuilder<QuerySnapshot>(
          future: _futureDataEconomyPackage,
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
        childAspectRatio: 0.8
    ),
    itemCount: itemList.length,
    itemBuilder: (_, i) {
      Map thisItem = itemList[i];
      return InkWell(
        onTap: ()=> Get.to(()=> DetailsScreen(detailsData: thisItem),),
        child: Container(
          decoration: BoxDecoration(
         color: Colors.grey[500],
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
                child:CachedNetworkImage(
                  imageUrl: thisItem['list_images'][0],
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  thisItem['list_destination'],
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color.fromARGB(255, 59, 80, 27),
                    fontWeight: FontWeight.w500,
                  ),
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

