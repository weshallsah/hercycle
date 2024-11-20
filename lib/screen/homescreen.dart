import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/fullcalendar.dart';
import 'package:hercycle/component/linercalendar.dart';
import 'package:hercycle/component/menus.dart';
import 'package:hercycle/controller/home.controller.dart';
import 'package:hercycle/services/notification.services.dart';
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
                child: Obx(
                  () => Text(
                    homecontroller.name.value,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
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
              GetBuilder<Homecontroller>(initState: (state) {
                homecontroller.getname(context);
              }, builder: (controller) {
                return Obx(() => controller.iscalendar.value
                    ? Obx(
                        () => controller.iscyclegets.value
                            ? Fullcalendar(
                                homecontroller: controller,
                              )
                            : Fullcalendar(
                                homecontroller: controller,
                              ),
                      )
                    : Obx(
                        () => controller.iscyclegets.value
                            ? LinerCalendar(
                                homecontroller: homecontroller,
                              )
                            : LinerCalendar(
                                homecontroller: homecontroller,
                              ),
                      ));
              }),
              Obx(
                () => homecontroller.iscalendar.value
                    ? SizedBox(
                        height: 15.h,
                      )
                    : Container(),
              ),
              Obx(
                () => homecontroller.iscalendar.value
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 10.w,
                            width: 10.w,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Normal days",
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            height: 10.w,
                            width: 10.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(217, 30, 128, 209),
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Menstruation days",
                          ),
                        ],
                      )
                    : Container(),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
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
                    InkWell(
                        onTap: () {
                          homecontroller.iscalendar.value =
                              !homecontroller.iscalendar.value;
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Text("Show calendar"))
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Container(
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
                    Obx(
                      () => Text(
                        homecontroller.cycleinfo.value,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
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
              Obx(
                () => Menus(
                  "clock",
                  title: "Started ${homecontroller.cycleinfo.value}",
                  subtitle: homecontroller.cyclecnt.value,
                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 16.w,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Notes of day",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      height: 130.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        expands: true,
                        maxLines: null,
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        controller: homecontroller.note,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Creating At",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${DateFormat('d MMM y').format(homecontroller.dateTime.value)} ${DateFormat.jm().format(homecontroller.dateTime.value)}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          print(homecontroller.uid);
                          homecontroller.uploadnote(context);
                          Navigator.pop(context);
                        },
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
                            "Upload",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          width: 30.w,
          child: Image.asset("./assets/Icons/notes.png"),
        ),
      ),
    );
  }
}
