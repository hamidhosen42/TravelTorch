// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextField(title, TextEditingController nameController, TextInputType textInputType,{maxline,onlyRead}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        TextField(
          controller: nameController,
          textAlign: TextAlign.justify,
          readOnly: onlyRead,
          maxLines: maxline,
          keyboardType: textInputType,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),     
      ],
    ),
  );
}
