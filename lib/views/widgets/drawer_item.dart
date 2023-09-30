import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

Widget drawerItem({required String itemName, required onClick}) {
  return InkWell(
    onTap: onClick,
    child: Text(
      itemName,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
    ),
  );
}

Widget drawer({required VoidCallback onPressed, required String title}) {
  return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.withOpacity(1.0)),
      ),
      onPressed: onPressed,
      child: title.text.black.make());
}
