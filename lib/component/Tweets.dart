import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tweets extends StatelessWidget {
  const Tweets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30.h),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Text(
                "Username",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text:
                    'Diet that you can have in your periods.Diet that you can have in your periods.Diet that you can have in your periods.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
