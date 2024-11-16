import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/Loginbutton.dart';
import 'package:hercycle/component/inputbox.dart';
import 'package:hercycle/controller/auth.controller.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final Authcontroller authcontroller = Get.put(Authcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => authcontroller.isLogin.value
                    ? Container(
                        height: 250.h,
                        alignment: Alignment.center,
                        child: Image.asset(
                          "./assets/png/authimg.png",
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Obx(
                            () => Container(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  authcontroller.pickimage();
                                },
                                borderRadius: BorderRadius.circular(100.r),
                                child: Container(
                                  height: 100.w,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    // color: Colors.amber,
                                    border: Border.all(),
                                    image: DecorationImage(
                                      image: authcontroller.isimage.value
                                          ? FileImage(
                                              File(authcontroller.image.value),
                                            )
                                          : AssetImage(
                                              "./assets/png/profileavatar.png",
                                            ),
                                      // : NetworkImage(
                                      //     "https://i.pinimg.com/564x/cb/36/ef/cb36efd404e5ddebb69ac5e21743ddd7.jpg",
                                      //   ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => authcontroller.isLogin.value
                    ? Container()
                    : inputBox(
                        "Name",
                        authcontroller.name,
                        false,
                        authcontroller: authcontroller,
                      ),
              ),
              SizedBox(
                height: 10.h,
              ),
              inputBox(
                "Email",
                authcontroller.email,
                false,
                authcontroller: authcontroller,
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => authcontroller.isLogin.value
                    ? Container()
                    : inputBox(
                        "What's your mid cycle date",
                        authcontroller.date,
                        isnumber: true,
                        false,
                        authcontroller: authcontroller,
                      ),
              ),
              SizedBox(
                height: 10.h,
              ),
              inputBox(
                "password",
                authcontroller.password,
                true,
                authcontroller: authcontroller,
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => authcontroller.isLogin.value
                    ? Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 50.w,
                        ),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(
                            12.r,
                          ),
                          child: Text(
                            "Forget password",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
              Obx(
                () => SizedBox(
                  height: authcontroller.isLogin.value ? 170.h : 120.h,
                ),
              ),
              Obx(
                () => Loginbutton(
                  clicked: () {
                    authcontroller.isLogin.value
                        ? authcontroller.Login()
                        : authcontroller.signup();
                  },
                  name: authcontroller.isLogin.value ? "Login" : "Signup",
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Obx(
                () => Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        authcontroller.isLogin.value
                            ? "Don't have an account? "
                            : "Alredy have an account?",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          authcontroller.isLogin.value =
                              !authcontroller.isLogin.value;
                        },
                        child: Text(
                          authcontroller.isLogin.value ? " Signup" : " Login",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
