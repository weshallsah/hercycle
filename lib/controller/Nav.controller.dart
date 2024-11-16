import 'package:get/get.dart';
import 'package:hercycle/controller/profile.controller.dart';
import 'package:hercycle/screen/Settingscreen.dart';
import 'package:hercycle/screen/calendarscreen.dart';
import 'package:hercycle/screen/homescreen.dart';
import 'package:hercycle/screen/profilescreen.dart';

class Navcontroller extends GetxController {
  List Iconname = ["home", "calendar", "settings", "Avatar"];
  RxInt idx = 0.obs;
  RxList navscreen = [
    HomeScreen(),
    Calendarscreen(),
    Settingscreen(),
    Profilescreen(),
  ].obs;
}
