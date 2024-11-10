import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/home.controller.dart';

class LinerCalendar extends StatelessWidget {
  Homecontroller homecontroller;
  LinerCalendar({required this.homecontroller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => ListView.builder(
                  itemCount: homecontroller.weekdays.length,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 40.h,
                      width: 40.w,
                      margin: EdgeInsets.only(
                        left: index == 0 ? 0 : 6.w,
                        right: index == 6 ? 0 : 6.w,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        homecontroller.weekdays[index],
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          height: 40.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => ListView.builder(
                  itemCount: homecontroller.weekdays.length,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 40.h,
                      width: 40.w,
                      margin: EdgeInsets.only(
                        left: index == 0 ? 0 : 6.w,
                        right: index == 6 ? 0 : 6.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        color:
                            homecontroller.prides[homecontroller.days[index]] ==
                                    true
                                ? Color.fromARGB(255, 231, 231, 255)
                                : null,
                        border: homecontroller.days[index] == DateTime.now().day
                            ? Border.all()
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${homecontroller.days[index]}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
