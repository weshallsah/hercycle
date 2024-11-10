import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/fullcalendar.dart';
import 'package:hercycle/component/linercalendar.dart';
import 'package:hercycle/component/menus.dart';
import 'package:hercycle/controller/home.controller.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Homecontroller homecontroller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HerCycle",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(0),
                child: Text(
                  "Good morning,",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(0),
                alignment: Alignment.topLeft,
                child: Text(
                  "Cyra Dawn",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Image.asset(
                    "./assets/Icons/calendar.png",
                    height: 24.h,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Obx(
                    () => Text(
                      "${DateFormat.yMMMM().format(homecontroller.dateTime.value)}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              GetBuilder<Homecontroller>(builder: (controller) {
                return Obx(
                  () => controller.iscalendar.value
                      ? Fullcalendar(
                          homecontroller: Homecontroller(),
                        )
                      : LinerCalendar(
                          homecontroller: homecontroller,
                        ),
                );
              }),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  homecontroller.iscalendar.value =
                      !homecontroller.iscalendar.value;
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Image.asset(
                          "./assets/Icons/${homecontroller.iscalendar.value ? "up-arrows.png" : "down-arrow.png"}",
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text("Show calendar")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                height: 80.h,
                width: 361.w,
                padding: EdgeInsets.all(16.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 216, 223),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your period is likely to start on or around",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "July 29",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // July 29
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Last Menstrual Period",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Menus(
                "clock",
                title: "Started June 27",
                subtitle: "18 days ago",
              ),
              SizedBox(
                height: 8.h,
              ),
              Menus(
                "opacity",
                title: "Period Length: 4 days",
                subtitle: "Normal",
              ),
              SizedBox(
                height: 8.h,
              ),
              Menus(
                "Group",
                title: "Cycle Length: 28 days",
                subtitle: "Normal",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
