import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hercycle/controller/home.controller.dart';
import 'package:hercycle/screen/calendarscreen.dart';
import 'package:table_calendar/table_calendar.dart';

class Fullcalendar extends StatelessWidget {
  Homecontroller homecontroller;
  Fullcalendar({required this.homecontroller, super.key});
  final date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        headerVisible: false,
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2000),
        lastDay: DateTime.utc(2080),
        calendarFormat: CalendarFormat.month,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(
              100.r,
            ),
          ),
          todayTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        holidayPredicate: (day) {
          if (homecontroller.prides[day.day] != null) {
            return true;
          }
          return false;
        },
      ),
    );
  }
}
