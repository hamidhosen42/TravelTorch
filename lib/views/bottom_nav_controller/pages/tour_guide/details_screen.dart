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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data['destination']
                        .toString()
                        .text
                        .size(22.sp)
                        .fontWeight(FontWeight.w700)
                        .make(),
                    "${data['cost']} টাকা"
                        .text
                        .color(Colors.green)
                        .fontWeight(FontWeight.w500)
                        .size(18)
                        .make(),
                    17.h.heightBox,
                    "বিবরনঃ".text.bold.size(20.sp).make(),
                    5.h.heightBox,
                    data['description'].toString().text.make(),
                    22.h.heightBox,
                    "কিভাবে যাবেনঃ".text.bold.size(20.sp).make(),
                    5.h.heightBox,
                    data['how_to_go'].toString().text.make(),
                    22.h.heightBox,
                    "কোথায় থাকবেনঃ".text.bold.size(20.sp).make(),
                    5.h.heightBox,
                    data['live'].toString().text.make(),
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
