import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Note extends StatelessWidget {
  int idx;
  Note(this.idx, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 86.h,
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Color.fromARGB(255, 224, 232, 242),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 52.w,
            width: 52.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 216, 223),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 3.h,
                horizontal: 8.w,
              ),
              color: Colors.white.withOpacity(
                0.4,
              ),
              child: Text(
                "${idx}",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: 10.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "17 Sep 2023",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "11:21 AM",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 10.w,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Note:",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 10.w,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "If any note the it will appear here.",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
