import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/musicplayer.dart';
import 'package:hercycle/controller/workout.controller.dart';
import 'package:intl/intl.dart';

class WorkoutScreen extends StatelessWidget {
  WorkoutScreen({super.key});
  final Workoutcontroller workoutcontroller = Get.put(Workoutcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.h,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          children: [
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
                    "${DateFormat.yMMMM().format(workoutcontroller.dateTime.value)}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Workout",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Workout tha you can do in your periods.",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 150,
        alignment: Alignment.center,
        child: Musicplayer(
          workoutcontroller: workoutcontroller,
        ),
      ),
    );
  }
}
