import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/Vlogs.controller.dart';

class Tweets extends StatelessWidget {
  int idx;
  VlogsController controller;
  Tweets({required this.idx, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30.h),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                foregroundImage: AssetImage(
                  "./assets/png/profileavatar.png",
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Obx(
                () => Text(
                  controller.posts[idx]["username"],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: controller.posts[idx]["caption"],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
