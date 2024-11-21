import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/postvideoplayer.dart';
import 'package:hercycle/component/videoplayer.dart';
import 'package:hercycle/controller/workout.controller.dart';
import 'package:video_player/video_player.dart';

class GymScreen extends StatelessWidget {
  Workoutcontroller workoutcontroller;
  GymScreen({required this.workoutcontroller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      // color: Colors.amber,
      child: GetBuilder<Workoutcontroller>(initState: (state) {
        workoutcontroller.getworkout();
      }, builder: (controller) {
        return Obx(
          () => ListView.builder(
            itemCount: controller.workout.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              print(controller.workout[index]['url']);
              return Column( 
                children: [
                  new Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: YoutubePlayerScreen(
                        url: controller.workout[index]['url'],
                      )
                      // : Container(),
                      ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.workout[index]['title'],
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            controller.workout[index]['description'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
