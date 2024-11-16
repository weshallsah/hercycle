import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/Loginbutton.dart';
import 'package:hercycle/controller/auth.controller.dart';
import 'package:hercycle/controller/splash.controller.dart';
import 'package:hercycle/main.dart';
import 'package:hercycle/screen/Auth.dart';

class Emailvirfy extends StatelessWidget {
  Emailvirfy({super.key});
  final Authcontroller authcontroller = Get.put(Authcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 250.h,
                  child: Image.asset(
                    "./assets/png/verification.png",
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Verify Email!",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () => Text(
                      authcontroller.isverifyclicked.value
                          ? "check your Mail Box and spam to verify your email by clicking the link atteched on email!"
                          : "click verify button to get email verification link to you provided email!",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // Obx(
                //   () => authcontroller.isverifyclicked.value
                //       ? Container(
                //           margin: EdgeInsets.symmetric(
                //             horizontal: 25.w,
                //           ),
                //           alignment: Alignment.centerLeft,
                //           child: Row(
                //             children: [
                //               Text(
                //                 "If you verified by mail link please ",
                //                 style: TextStyle(
                //                   fontSize: 16.sp,
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //               ),
                //               InkWell(
                //                 onTap: () {},
                //                 child: Text(
                //                   "click here!",
                //                 ),
                //               ),
                //             ],
                //           ),
                //         )
                //       : Container(),
                // ),
              ],
            ),
            Column(
              children: [
                Obx(
                  () => Loginbutton(
                    clicked: () async {
                      await FirebaseAuth.instance.currentUser
                          ?.sendEmailVerification();
                      authcontroller.isverifyclicked.value = true;
                      Splashcontroller().checkverfication();
                    },
                    name: authcontroller.isverifyclicked.value
                        ? "Resend"
                        : "Verify",
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}