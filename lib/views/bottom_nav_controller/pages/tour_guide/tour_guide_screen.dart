// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';

import 'details_screen.dart';

class SelfTourScreen extends StatelessWidget {
  const SelfTourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: StreamBuilder(
          stream: firestore.collection("tour-guide").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }else{
              var data = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: ()=> Get.to(()=>SelfTourDetailsScreen(data: data[index])),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 212, 196, 196),
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
                            child: Image.network(
                              data[index]['gallery_img'][0],
                              height: 145.h,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            data[index]['destination'],
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Color.fromARGB(255, 59, 80, 27),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${data[index]['cost'].toString()} টাকা",
                            style:
                            TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
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
