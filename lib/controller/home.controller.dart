import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Homecontroller extends GetxController {
  Rx<DateTime> dateTime = DateTime.now().obs;
  RxList weekdays = ["S", "M", "T", "W", "T", "F", "S"].obs;
  RxBool iscalendar = false.obs;
  RxList days = [].obs;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  RxMap prides = {}.obs;
  RxBool iscyclegets = false.obs;
  RxInt cyclest = 0.obs;
  RxInt cycleen = 0.obs;
  RxString name = "".obs;
  RxString cycleinfo = "".obs;
  RxString cyclecnt = "".obs;
  TextEditingController note = TextEditingController();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // uid =
    dateTime.value = DateTime.now();
    int len = DateTime.now().weekday % 7;
    for (int i = 1; i < 7 - len; i++) {
      days.add(DateTime.now().day + i);
    }
    for (int i = 0; i <= len; i++) {
      days.add(DateTime.now().day - i);
    }
    days.sort();
    final userdata =
        await FirebaseFirestore.instance.collection("user").doc(uid).get();
    // print("user := ${userdata.data()}");
    int curmonth = daysInMonth(dateTime.value, dateTime.value.month) + 1;
    int prevmonth = daysInMonth(dateTime.value, dateTime.value.month - 1);
    int mid = userdata.data()?['cycledate'];
    // int mid = 1;
    prides.value[mid] = true;
    for (int i = 1; i <= 3; i++) {
      prides.value[(mid + i) % curmonth] = true;
      cycleen.value = (mid + i) % curmonth;
      if (mid - i <= 0) {
        prides.value[prevmonth + (mid - i)] = true;
        cyclest.value = prevmonth + (mid - i);
      } else {
        prides.value[(mid - i)] = true;
        cyclest.value = mid - i;
      }
    }
    iscyclegets.value = true;
    cycleinfo.value = "${DateFormat("MMMM").format(dateTime.value)} ${cyclest}";
    if (dateTime.value.day >= cyclest.value &&
        dateTime.value.day <= cycleen.value) {
      cyclecnt.value = "You are in your cycle phase.";
    } else if (dateTime.value.day > cycleen.value) {
      int cnt = curmonth - dateTime.value.day - 1;
      cnt += cyclest.value - 1;
      cyclecnt.value = "${cnt} days ago";
    } else {
      int cnt = cyclest.value - dateTime.value.day;
      cyclecnt.value = "${cnt} days ago";
    }
  }

  void getname() async {
    final userdata =
        await FirebaseFirestore.instance.collection("user").doc(uid).get();
    name.value = userdata.data()?['name'];
  }

  int daysInMonth(DateTime date, int month) {
    var firstDayThisMonth = new DateTime(date.year, month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  void uploadnote() async {
    if (note.text.isEmpty) {
      return;
    }
    print(note.text);
    FirebaseFirestore.instance
        .collection("notes")
        .doc(uid)
        .collection("quotes")
        .doc()
        .set({
      "notes": note.text,
      "date": "${DateFormat('d MMM y').format(dateTime.value)}",
      "time": "${DateFormat.jm().format(dateTime.value)}",
      "createdat": Timestamp.now(),
    });
    note.clear();
  }
}
