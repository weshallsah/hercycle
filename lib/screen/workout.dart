import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/Diets.dart';
import 'package:hercycle/component/gym.dart';
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
        toolbarHeight: 40.h,
        title: Text(
          "HerCycle",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Row(
                  children: [
                    Image.asset(
                      "./assets/Icons/gym.png",
                      height: 24.h,
                      fit: BoxFit.fill,
                    ),
                    Obx(
                      () => Switch(
                        inactiveTrackColor: Colors.redAccent,
                        activeTrackColor: Colors.redAccent,
                        value: workoutcontroller.isgym.value,
                        inactiveThumbColor: Colors.white,
                        onChanged: (Value) {
                          workoutcontroller.isgym.value = Value;
                        },
                      ),
                    ),
                    Image.asset(
                      "./assets/Icons/food.png",
                      height: 24.h,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ],
            ),
            Obx(
              () => Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  workoutcontroller.isgym.value ? "Diets" : "Workout",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Obx(
              () => Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  workoutcontroller.isgym.value
                      ? "Diet that you can have in your periods."
                      : "Workout tha you can do in your periods.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              height: 10.h,
              margin: EdgeInsets.symmetric(
                vertical: 2.h,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      // color: Color.fromARGB(255, 189, 195, 203),
                      ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<Workoutcontroller>(
                builder: (controller) {
                  return Obx(
                    () {
                      if (controller.isgym.value) {
                        return DietsScreen(
                          workoutcontroller: controller,
                        );
                      }
                      return GymScreen(
                        workoutcontroller: controller,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 126,
        alignment: Alignment.topCenter,
        child: Musicplayer(
          workoutcontroller: workoutcontroller,
        ),
      ),
    );
  }
}
