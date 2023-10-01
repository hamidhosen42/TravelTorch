// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tour_app/constant/app_colors.dart';
import 'package:get/get.dart';

import '../../../../services/firestore_services.dart';
import 'details_screen.dart';

class SelfTourScreen extends StatelessWidget {
  const SelfTourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: StreamBuilder(
          stream: FirestoreServices.tourGuidePackage(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              var data = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () =>
                        Get.to(() => SelfTourDetailsScreen(data: data[index])),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.r),
                              topRight: Radius.circular(7.r),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: data[index]['gallery_img'][0],
                              fit: BoxFit.fill,
                              height: 145.h,
                              width: double.infinity,
                              filterQuality: FilterQuality.high,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Text(
                            data[index]['destination'],
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${data[index]['cost'].toString()} BD",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
