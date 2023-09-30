// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/views/widgets/details_heading_description.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsScreen extends StatefulWidget {
  final Map detailsData;
  const DetailsScreen({super.key, required this.detailsData});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //show slider
                    VxSwiper.builder(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      itemCount: widget.detailsData['list_images'].length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.detailsData['list_images'][0],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.detailsData['list_destination']
                              .toString()
                              .text
                              .size(22.sp)
                              .fontWeight(FontWeight.w700)
                              .make(),
                          "${widget.detailsData['list_cost']} BDT"
                              .text
                              .color(Colors.green)
                              .fontWeight(FontWeight.w500)
                              .size(18.sp)
                              .make(),
                          15.h.heightBox,
                          detailsHeadingDescription(
                            title: "description".tr,
                            description: widget.detailsData['list_description'],
                          ),
                          detailsHeadingDescription(
                            title: "facilites".tr,
                            description: widget.detailsData['list_facilities'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.detailsData['list_owner_name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            launchUrl(
                              Uri.parse(
                                  "tel: ${widget.detailsData['list_phone']}"),
                            );
                          },
                          icon: Icon(Icons.call_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrl(
                              Uri.parse(
                                  "sms:${widget.detailsData['list_phone']}"),
                            );
                          },
                          icon: Icon(Icons.message_outlined),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
