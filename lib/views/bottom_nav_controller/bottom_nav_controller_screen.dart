// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:travel_agency/constant/app_strings.dart';
import 'package:travel_agency/constant/constant.dart';

class BottomNavControllerScreen extends StatelessWidget {
  BottomNavControllerScreen({super.key});
  RxInt _currentIndex = 0.obs;
  RxBool _drawer = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: 400),
        top: _drawer.value == false ? 0 : 100.h,
        bottom: _drawer.value == false ? 0 : 100.h,
        left: _drawer.value == false ? 0 : 200.w,
        right: _drawer.value == false ? 0 : -100.w,
        child: Container(
          decoration: BoxDecoration(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "appName".tr,
                style: TextStyle(color: Colors.black),
              ),
              leading: _drawer.value == false
                  ? IconButton(
                      onPressed: () {
                        _drawer.value = true;
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        _drawer.value = false;
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 0,
              onTap: (value) => _currentIndex.value = value,
              currentIndex: _currentIndex.value,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 30,
                  ),
                  label: "home".tr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "add".tr,
                ),
                BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage('assets/images/direction.png'),
                    height: 30,
                  ),
                  label: "tourGuide".tr,
                ),
              ],
            ),
            body: pages[_currentIndex.value],
          ),
        ),
      ),
    );
  }
}
