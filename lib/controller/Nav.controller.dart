import 'package:get/get.dart';
import 'package:hercycle/controller/profile.controller.dart';
import 'package:hercycle/screen/Vlogs.dart';
import 'package:hercycle/screen/workout.dart';
import 'package:hercycle/screen/homescreen.dart';
import 'package:hercycle/screen/profilescreen.dart';

class Navcontroller extends GetxController {
  List Iconname = ["home", "workout", "settings", "Avatar"];
  RxInt idx = 0.obs;
  RxList navscreen = [
    HomeScreen(),
    WorkoutScreen(),
    Vlogscreen(),
    Profilescreen(),
  ].obs;
}
