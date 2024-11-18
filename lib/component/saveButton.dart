import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/profile.controller.dart';

class Savebutton extends StatelessWidget {
  Profilecontroller profilecontroller;
  String text;
  Savebutton({required this.profilecontroller, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (profilecontroller.isedit.value && text != "cancel") {
            profilecontroller.profileupdate();
          }
          if (text == "cancel") {
            profilecontroller.image.value = "";
          }
          profilecontroller.isedit.value = !profilecontroller.isedit.value;
          profilecontroller.reactive;
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 5.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Color.fromARGB(255, 255, 216, 223),
            border: Border.all(),
          ),
          child: Obx(
            () => Text(
              profilecontroller.isedit.value ? text : "Edit",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
