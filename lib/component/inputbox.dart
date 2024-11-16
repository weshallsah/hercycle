import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/auth.controller.dart';

class inputBox extends StatelessWidget {
  String inputname;
  TextEditingController inputcontroller;
  bool ispassword;
  Authcontroller authcontroller;
  bool isnumber;
  inputBox(this.inputname, this.inputcontroller, this.ispassword,
      {required this.authcontroller, this.isnumber = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputname,
            style: TextStyle(fontSize: 16.sp),
          ),
          Obx(
            () => Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(6.r),
                ),
              ),
              child: TextFormField(
                obscureText: authcontroller.isshow.value & ispassword,
                controller: inputcontroller,
                keyboardType:
                    isnumber ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: inputname,
                  suffixIcon: ispassword
                      ? IconButton(
                          onPressed: () {
                            authcontroller.isshow.value =
                                !authcontroller.isshow.value;
                          },
                          icon: Icon(
                            !authcontroller.isshow.value
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
