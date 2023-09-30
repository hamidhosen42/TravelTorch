// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class PackageDetailsScreen extends StatelessWidget {
  final dynamic data;
  const PackageDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //show slider
              VxSwiper.builder(
                autoPlay: true,
                enlargeCenterPage: true,
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemCount: data["gallery_img"].length,
                itemBuilder: (context, index) {
                  return Image.network(
                    "${data['gallery_img'][index]}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
              20.h.heightBox,
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data['destination']
                        .toString()
                        .text
                        .size(22.sp)
                        .fontWeight(FontWeight.w700)
                        .make(),
                    17.h.heightBox,
                    "Description:".text.bold.size(20.sp).make(),
                    5.h.heightBox,
                    data['description'].toString().text.make(),
                    22.h.heightBox,
                    "Facilities:".text.bold.size(22.sp).make(),
                    5.h.heightBox,
                    data['facilities'].toString().text.make(),
                    22.h.heightBox,
                    "Destination:".text.bold.size(22.sp).make(),
                    5.h.heightBox,
                    data['destination'].toString().text.make(),
                    22.h.heightBox,
                    "Cost:".text.bold.size(22.sp).make(),
                    5.h.heightBox,
                    data['cost'].toString().text.make(),
                    22.h.heightBox,
                    "Phone:".text.bold.size(22.sp).make(),
                    5.h.heightBox,
                    data['phone'].toString().text.make(),
                    10.h.heightBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
