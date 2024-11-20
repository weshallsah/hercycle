import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/workout.controller.dart';

class DietsScreen extends StatelessWidget {
  Workoutcontroller workoutcontroller;
  DietsScreen({required this.workoutcontroller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<Workoutcontroller>(initState: (state) {
              workoutcontroller.getdiets();
            }, builder: (controller) {
              return Obx(
                () => Container(
                  // color: Colors.amber,
                  child: ListView.builder(
                    itemCount: controller.diets.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 300.h,
                            // color: Colors.blue,
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            child: Image.network(
                              controller.diets[index]['url'],
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 350.h,
                                  child: Center(
                                    child: Icon(
                                      Icons.photo,
                                    ),
                                  ),
                                );
                              },
                            ),
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
                                    controller.diets[index]['title'] ?? "",
                                    style: TextStyle(
                                      fontSize: 18.sp,
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
                                    controller.diets[index]['description'] ??
                                        "",
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
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
