import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class SelfTourDetailsScreen extends StatelessWidget {
  final dynamic data;
  const SelfTourDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //!---------------show slider------------
              VxSwiper.builder(
                autoPlay: true,
                enlargeCenterPage: true,
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemCount: data["gallery_img"].length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: data['gallery_img'][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  );
                },
              ),
              20.h.heightBox,
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Destination:".text.bold.size(22.sp).make(),
                    5.h.heightBox,
                    data['destination'].toString().text.make(),
                    22.h.heightBox,
                    "Cost:".text.bold.size(22.sp).make(),
                    5.h.heightBox,
                    data['cost'].toString().text.make(),
                    22.h.heightBox,
                    data['destination']
                        .toString()
                        .text
                        .size(22.sp)
                        .fontWeight(FontWeight.w700)
                        .make(),
                    17.h.heightBox,
                    "Description:".text.bold.size(20.sp).make(),
                    5.h.heightBox,
                    data['description']
                        .toString()
                        .text
                        .align(TextAlign.justify)
                        .make(),
                    20.h.heightBox,
                    "live:".text.bold.size(20.sp).make(),
                    5.h.heightBox,
                    data['live']
                        .toString()
                        .text
                        .align(TextAlign.justify)
                        .make(),
                    20.h.heightBox,
                    "How to go:".text.bold.size(22.sp).make(),
                    5.h.heightBox,
                    data['how_to_go']
                        .toString()
                        .text
                        .align(TextAlign.justify)
                        .make(),
                    22.h.heightBox,
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
