// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/services/firestore_services.dart';
import 'package:travel_agency/views/widgets/nav_home_categories.dart';

import 'details_screen.dart';
import 'see_all_screen.dart';
import 'see_all_screen_2.dart';
import 'see_all_screen_3.dart';

class NavHomeScreen extends StatefulWidget {
  const NavHomeScreen({super.key});

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  final List _carouselImages = [
    'assets/images/cover-one.jpeg',
    'assets/images/cover-two.jpeg',
    'assets/images/cover-three.jpeg'
  ];

  final RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 229, 229),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            AspectRatio(
              aspectRatio: 3.5,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 200.h,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.9,
                    onPageChanged: (val, carouselPageChangedReason) {
                      setState(() {
                        _currentIndex.value = val;
                      });
                    }),
                items: _carouselImages.map((image) {
                  return Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 5.h),
            Obx(
              () => DotsIndicator(
                dotsCount: _carouselImages.length,
                position: _currentIndex.value.toDouble(),
              ),
            ),
            navHomeCategories(
              categoryName: "allPackage".tr,
              onClick: () => Get.to(
                () => SeeAllScreen(
                  compare: "phone",
                ),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 180.h,
              child: FutureBuilder<QuerySnapshot>(
                future: FirestoreServices.getForYouPackage(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    List<Map> items = parseData(snapshot.data);
                    return forYou(items);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Text("");
                },
              ),
            ),

            SizedBox(height: 15.h),
            navHomeCategories(
              categoryName: "topPlace".tr,
              onClick: () => Get.to(
                () => SeeAllScreen(
                  compare: "cost",
                ),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 80.h,
              child: FutureBuilder<QuerySnapshot>(
                future: FirestoreServices.getTopPlacePackage(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    List<Map> items = parseData(snapshot.data);
                    return topPlaces(items);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            SizedBox(height: 25.h),
            //Economy package
            navHomeCategories(
              categoryName: "economy".tr,
              onClick: () => Get.to(
                () => SeeAllScreen3(),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 180.h,
              child: FutureBuilder<QuerySnapshot>(
                future: FirestoreServices.getEconomyPackage(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    List<Map> items = parseData(snapshot.data);
                    return economyPackage(items);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Text("");
                },
              ),
            ),
            //Luxury package
            SizedBox(height: 25),
            navHomeCategories(
              categoryName: "luxury".tr,
              onClick: () => Get.to(
                () => SeeAllScreen2(),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 180.h,
              child: FutureBuilder<QuerySnapshot>(
                future: FirestoreServices.getLuxuryPackage(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    List<Map> items = parseData(snapshot.data);
                    return luxuryPackage(items);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Text("");
                },
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

List<Map> parseData(QuerySnapshot querySnapshot) {
  List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
  List<Map> listItems = listDocs
      .map((e) => {
            'list_images': e['gallery_img'],
            'list_destination': e['destination'],
            'list_cost': e['cost'],
            'list_description': e['description'],
            'list_facilities': e['facilities'],
            'list_owner_name': e['owner_name'],
            'list_phone': e['phone'],
            'list_date': e['date_time'],
          })
      .toList();
  return listItems;
}

ListView forYou(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 100.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
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
                    height: 115.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  thisItem['list_destination'],
                  style: TextStyle(fontSize: 15.sp),
                ),
                Text(
                  "${thisItem['list_cost']} BDT",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

ListView topPlaces(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 5.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(thisItem['list_images'][0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    },
  );
}

ListView economyPackage(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 100.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
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
                    height: 115.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  thisItem['list_destination'],
                  style: TextStyle(fontSize: 15.sp),
                ),
                Text(
                  "${thisItem['list_cost']} BDT",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

ListView luxuryPackage(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 100.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
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
                    height: 115.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  thisItem['list_destination'],
                  style: TextStyle(fontSize: 15.sp),
                ),
                Text(
                  "${thisItem['list_cost']} BDT",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
