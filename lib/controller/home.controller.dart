import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/toast.dart';
import 'package:hercycle/services/notification.services.dart';
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
  NotificationServices notificationServices = NotificationServices();
  TextEditingController date = TextEditingController(text: "");
  RxBool isedit = false.obs;
  int mid = 0;

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
    await getdates();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseinit();
  }

  Future<void> getdates() async {
    prides.value = {};
    iscyclegets.value = false;
    final userdata =
        await FirebaseFirestore.instance.collection("user").doc(uid).get();
    int curmonth = daysInMonth(dateTime.value, dateTime.value.month) + 1;
    int prevmonth = daysInMonth(dateTime.value, dateTime.value.month - 1);
    int st = 0;
    mid = userdata.data()?['cycledate'];
    int lastnotification = userdata.data()?['lastnotification'];
    date.text = mid.toString();
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
    for (int i = 1; i <= 3; i++) {
      if (cyclest.value - i <= 0) {
        st = prevmonth + (cyclest.value - i);
      } else {
        st = cyclest.value - i;
      }
    }
    if (dateTime.value.day >= cyclest.value &&
        dateTime.value.day <= cycleen.value) {
      cyclecnt.value =
          "${dateTime.value.day - cyclest.value + 1}st day of your cycle phase.";
    } else if (dateTime.value.day > cycleen.value) {
      int cnt = curmonth - dateTime.value.day - 1;
      cnt += cyclest.value - 1;
      cyclecnt.value = "${cnt} days ago";
    } else {
      int cnt = cyclest.value - dateTime.value.day;
      cyclecnt.value = "${cnt} days ago";
    }
    iscyclegets.value = true;
    cycleinfo.value = "${DateFormat("MMMM").format(dateTime.value)} ${cyclest}";
    if (lastnotification != dateTime.value.day &&
        dateTime.value.day >= st &&
        dateTime.value.day <= cycleen.value) {
      String str = "";
      if (dateTime.value.day >= st && dateTime.value.day <= cyclest.value) {
        str =
            "be prepared for your periods only ${cyclest.value - dateTime.value.day} days left";
      }
      if (dateTime.value.day >= cyclest.value &&
          dateTime.value.day <= cycleen.value) {
        str =
            "${dateTime.value.day - cyclest.value + 1}st day of your cycle phase.";
      }
      notificationServices.shownotification(
        RemoteMessage(
          notification: RemoteNotification(
            title: "hercycle",
            body: str,
          ),
        ),
      );
      await FirebaseFirestore.instance.collection("user").doc(uid).update({
        "lastnotification": dateTime.value.day,
      });
    }
  }

  void updatecycledate(BuildContext context) async {
    bool ismy = false;
    try {
      if (!date.text.isNum) {
        ismy = true;
        throw "Date is not a vaild type";
      }
      if (int.parse(date.text) >= 32 || int.parse(date.text) <= 0) {
        ismy = true;
        throw "Date is not valid";
      }
      await FirebaseFirestore.instance.collection("user").doc(uid).update({
        "cycledate": int.parse(date.text),
      });
      getdates();
    } catch (e) {
      date.text = mid.toString();
      print("Error ${e}");
      if (ismy) {
        showToast(context, e.toString());
      } else {
        showToast(
          context,
          "server error please try again",
        );
      }
    }
  }

  void getname(BuildContext context) async {
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

  void uploadnote(BuildContext context) async {
    bool ismy = false;
    try {
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
      showToast(context, "note is added");
    } catch (e) {
      print(e);
      showToast(context, "something went wrong please try again");
      note.clear();
    }
  }
}
