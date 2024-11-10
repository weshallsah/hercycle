import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Menus extends StatelessWidget {
  String iconname;
  String title;
  String subtitle;
  Menus(this.iconname,
      {required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      width: 361.w,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            "./assets/Icons/${iconname}.png",
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              Text(
                subtitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
