import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loginbutton extends StatelessWidget {
  Function clicked;
  String name;
  Loginbutton({required this.clicked, required this.name, super.key});

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
          child: Text(
            name,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
