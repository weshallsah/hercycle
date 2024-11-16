import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/Notes.dart';
import 'package:hercycle/controller/profile.controller.dart';

class Profilescreen extends StatelessWidget {
  Profilescreen({super.key});
  final Profilecontroller profilecontroller = Get.put(Profilecontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            // fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              profilecontroller.singout();
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Obx(
              () => Container(
                alignment: Alignment.center,
                child: Container(
                  height: 100.w,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(),
                    image: DecorationImage(
                      image: profilecontroller.Imageurl.value.isEmpty
                          ? AssetImage(
                              "./assets/png/profileavatar.png",
                            )
                          : NetworkImage(
                              profilecontroller.Imageurl.value,
                            ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Obx(
              () => profilecontroller.isedit.value
                  ? TextField(
                      textAlign: TextAlign.center,
                      controller: profilecontroller.username,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Obx(
                      () => Container(
                        alignment: Alignment.center,
                        child: Text(
                          profilecontroller.name.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
            // SizedBox(
            //   height: 8.h,
            // ),
            Obx(
              () => Container(
                alignment: Alignment.center,
                child: Text(
                  profilecontroller.email.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  if (profilecontroller.isedit.value) {}
                  profilecontroller.isedit.value =
                      !profilecontroller.isedit.value;
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
                      profilecontroller.isedit.value ? "Save" : "Edit",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Previous Month",
            ),
            SizedBox(
              height: 12.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Note(index + 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
