import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Container(
              // color: Colors.amber,
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        // color: Colors.blue,
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        child: Image.asset(
                          "./assets/png/workoutimage.png",
                          fit: BoxFit.fitWidth,
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
                                "Water",
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
                                "Drinking a lot of water is always important, and this is especially true during your period. Staying hydrated can reduce your chances of getting dehydration headaches, a common symptom of menstruation.",
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
          ],
        ),
      ),
    );
  }
}
