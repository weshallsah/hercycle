import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/NavButton.dart';
import 'package:hercycle/controller/Nav.controller.dart';
import 'package:hercycle/main.dart';
import 'package:hercycle/screen/homescreen.dart';

class NavScreen extends StatelessWidget {
  NavScreen({super.key});

  final Navcontroller navcontroller = Get.put(Navcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Navcontroller>(
        builder: (controller) {
          return Obx(
            () {
              return controller.navscreen.value[controller.idx.value];
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color.fromARGB(255, 224, 232, 242)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Navbutton(0, navcontroller),
            Navbutton(1, navcontroller),
            Navbutton(2, navcontroller),
            Navbutton(3, navcontroller),
          ],
        ),
      ),
    );
  }
}
