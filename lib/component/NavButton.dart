import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/nav.dart';
import 'package:hercycle/controller/Nav.controller.dart';

class Navbutton extends StatelessWidget {
  Navcontroller navcontroller;
  int idx;
  Navbutton(this.idx, this.navcontroller, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navcontroller.idx.value = idx;
      },
      borderRadius: BorderRadius.circular(50.r),
      child: Obx(
        () => Container(
          margin: EdgeInsets.all(5.r),
          child: Image.asset(
            "./assets/Icons/${navcontroller.Iconname[idx]}.png",
            color: navcontroller.idx.value == idx
                ? Colors.redAccent
                : Colors.black,
            height: 25.h,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
