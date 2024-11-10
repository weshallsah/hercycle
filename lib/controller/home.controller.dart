import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Homecontroller extends GetxController {
  Rx<DateTime> dateTime = DateTime.now().obs;
  RxList weekdays = ["S", "M", "T", "W", "T", "F", "S"].obs;
  RxBool iscalendar = true.obs;
  RxList days = [].obs;
  RxMap prides = {
    13: true,
    14: true,
    15: true,
    16: true,
    17: true,
  }.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dateTime.value = DateTime.now();
    int len = DateTime.now().weekday % 7;
    print(7 - len);
    for (int i = 1; i < 7 - len; i++) {
      days.add(DateTime.now().day + i);
    }
    for (int i = 0; i <= len; i++) {
      days.add(DateTime.now().day - i);
    }
    days.sort();
    print(days);
  }
}
