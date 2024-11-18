import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/Tweets.dart';
import 'package:hercycle/component/posts.dart';
import 'package:hercycle/controller/Vlogs.controller.dart';
import 'package:intl/intl.dart';

class Vlogscreen extends StatelessWidget {
  Vlogscreen({super.key});

  VlogsController vlogsController = Get.put(VlogsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 40.h,
        title: Text(
          "HerCycle",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Image.asset(
                  "./assets/Icons/expert.png",
                  height: 24.h,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "Expert Thoughts",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              height: 20.h,
              margin: EdgeInsets.symmetric(
                vertical: 5.h,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 189, 195, 203),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return index % 2 == 0 ? Posts() : Tweets();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
