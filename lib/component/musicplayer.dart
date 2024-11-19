import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/workout.controller.dart';
import 'package:intl/intl.dart';

class Musicplayer extends StatelessWidget {
  Workoutcontroller workoutcontroller;
  Musicplayer({required this.workoutcontroller, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Workoutcontroller>(dispose: (state) {
      workoutcontroller.player.pause();
    }, builder: (controller) {
      return Container(
        height: 86.h,
        width: 358.w,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 224, 232, 242)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            InkWell(
              onTap: () {
                workoutcontroller.play();
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: 30.w,
                child: Obx(
                  () => Image.asset(
                    workoutcontroller.isplaying.value
                        ? "./assets/Icons/pause.png"
                        : "./assets/Icons/play.png",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Relaxation Song",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            "${workoutcontroller.pos.value.inHours}:${workoutcontroller.pos.value.inMinutes}:${workoutcontroller.pos.value.inSeconds % 60}",
                          ),
                        ),
                        Obx(
                          () => Text(
                            "${workoutcontroller.duration.value.inHours}:${workoutcontroller.duration.value.inMinutes}:${workoutcontroller.duration.value.inSeconds % 60}",
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => Container(
                        height: 20.h,
                        child: Slider(
                          activeColor: Colors.redAccent,
                          value:
                              workoutcontroller.pos.value.inSeconds.toDouble(),
                          max: workoutcontroller.duration.value.inSeconds
                              .toDouble(),
                          onChanged: (value) {
                            final position = Duration(seconds: value.toInt());
                            workoutcontroller.player.seek(position);
                            if (workoutcontroller.isplaying.value) {
                              workoutcontroller.player.resume();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 30.w,
            ),
          ],
        ),
      );
    });
  }
}
