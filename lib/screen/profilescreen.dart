import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/Notes.dart';
import 'package:hercycle/component/saveButton.dart';
import 'package:hercycle/controller/profile.controller.dart';
import 'package:intl/intl.dart';

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
                  ),
                  child: InkWell(
                    onTap: () {
                      profilecontroller.isedit.value = true;
                      profilecontroller.pickimage();
                    },
                    borderRadius: BorderRadius.circular(100.r),
                    child: CircleAvatar(
                      foregroundImage: profilecontroller.image.value.isEmpty
                          ? NetworkImage(
                              profilecontroller.Imageurl.value,
                            )
                          : FileImage(
                              File(profilecontroller.image.value),
                            ),
                      backgroundImage: AssetImage(
                        "./assets/png/profileavatar.png",
                      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Savebutton(
                  profilecontroller: profilecontroller,
                  text: "save",
                ),
                Obx(
                  () => profilecontroller.isedit.value
                      ? Row(
                          children: [
                            SizedBox(
                              width: 15.w,
                            ),
                            Savebutton(
                              profilecontroller: profilecontroller,
                              text: "cancel",
                            ),
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Previous Month Notes",
            ),
            SizedBox(
              height: 12.h,
            ),
            Expanded(
              child: GetBuilder<Profilecontroller>(initState: (state) {
                profilecontroller.getnotes();
              }, builder: (controller) {
                return Obx(
                  () => SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: profilecontroller.notes.length,
                          itemBuilder: (context, index) {
                            return Note(
                              index,
                              date: profilecontroller.notes[index]['date'],
                              time: profilecontroller.notes[index]['time'],
                              quotes: profilecontroller.notes[index]['notes'],
                              profilecontroller: profilecontroller,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
