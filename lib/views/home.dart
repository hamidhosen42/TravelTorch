// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_tour_app/controllers/home_controller.dart';
import 'package:flutter_tour_app/views/bottom_navigation/package/packages.dart';
import 'package:flutter_tour_app/views/home/home_screen.dart';
import 'package:flutter_tour_app/views/bottom_navigation/tour_guide_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final navScreen = [
    HomeScreen(),
    PackagesScreen(),
    TourGuidePackageAddScreen(),
  ];

  final _controllre = Get.put(HomeControllre());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            currentIndex: _controllre.navIndex.value,
            onTap: (index) {
              _controllre.navIndex.value = index;
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30.h),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add, size: 30.h),
                label: "Package",
              ),
              BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('assets/icons/direction.png'),
                  height: 30.h,
                ),
                label: "Tour Guide",
              ),
            ],
          );
        },
      ),
      body: Obx(
        () {
          return Column(
            children: [
              Expanded(child: navScreen.elementAt(_controllre.navIndex.value)),
            ],
          );
        },
      ),
    );
  }
}
