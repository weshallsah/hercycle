import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/postvideoplayer.dart';
import 'package:hercycle/component/videoplayer.dart';
import 'package:hercycle/controller/Vlogs.controller.dart';

class Posts extends StatelessWidget {
  int idx;
  VlogsController controller;
  Posts({required this.idx, required this.controller, super.key});

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
            () => controller.posts[idx]["isphoto"]
                ? Container(
                    height: 340.h,
                    // color: Colors.amber,
                    child: Image.network(
                      controller.posts[idx]["url"],
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 350.h,
                          child: Center(
                            child: Icon(
                              Icons.photo,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : YoutubePlayerScreen(
                    url: controller.posts[idx]["url"],
                  ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text: "${controller.posts[idx]["username"]} ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: controller.posts[idx]["caption"],
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
