import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/auth.controller.dart';

class Loginbutton extends StatelessWidget {
  Function clicked;
  String name;
  Authcontroller authcontroller;
  Loginbutton(
      {required this.clicked,
      required this.name,
      required this.authcontroller,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          clicked();
        },
        borderRadius: BorderRadius.circular(
          12.r,
        ),
        child: Container(
          width: 250.w,
          height: 55.h,
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 5.h,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Color.fromARGB(255, 255, 216, 223),
            border: Border.all(),
          ),
          child: Obx(
            () => authcontroller.isloading.value
                ? CircularProgressIndicator()
                : Text(
                    name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
