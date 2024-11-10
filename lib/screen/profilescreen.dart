import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            // fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Container(
              alignment: Alignment.center,
              child: Container(
                height: 100.w,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: Colors.amber,
                  border: Border.all(),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/564x/cb/36/ef/cb36efd404e5ddebb69ac5e21743ddd7.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Siddhi Sah",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(
            //   height: 8.h,
            // ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "SiddhiSah@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Color.fromARGB(255, 255, 216, 223),
                    border: Border.all(),
                  ),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Previous Month",
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              height: 86.h,
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Color.fromARGB(255, 224, 232, 242),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 52.w,
                    width: 52.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 216, 223),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.h,
                        horizontal: 8.w,
                      ),
                      color: Colors.white.withOpacity(
                        0.4,
                      ),
                      child: Text(
                        "1",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            right: 10.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Day 1",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "17 Sep 2023 11:21 AM",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
