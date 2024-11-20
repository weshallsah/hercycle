import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/Loginbutton.dart';
import 'package:hercycle/component/inputbox.dart';
import 'package:hercycle/controller/auth.controller.dart';

class Forgetscreen extends StatelessWidget {
  Forgetscreen({super.key});
  final Authcontroller authcontroller = Get.put(Authcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  "Forget Email!",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 25.w,
                ),
                alignment: Alignment.centerLeft,
                child: Obx(
                  () => Text(
                    authcontroller.isverifyclicked.value
                        ? "Check your Mail Box and spam to reset your password by clicking the link atteched on email!"
                        : "Enter email to get rest password link on email!",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              inputBox("Email", authcontroller.email, false,
                  authcontroller: authcontroller),
              Obx(
                () => SizedBox(
                  height: authcontroller.isverifyclicked.value ? 200.h : 250.h,
                ),
              ),
              Obx(
                () => Loginbutton(
                  clicked: () async {
                    authcontroller.forgetpassword(context);
                    authcontroller.isverifyclicked.value = true;
                  },
                  name:
                      authcontroller.isverifyclicked.value ? "Resend" : "Send",
                      authcontroller: authcontroller,
                ),
              ),
              SizedBox(
                height: 30.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
