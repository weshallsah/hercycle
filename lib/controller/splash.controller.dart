import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/emailvirfy.dart';
import 'package:hercycle/component/nav.dart';
import 'package:hercycle/screen/Auth.dart';

class Splashcontroller extends GetxController {
  bool isintialized = false;
  int cnt = 0;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await Future.delayed(Duration(milliseconds: 200));
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("user email virfication := ${user.emailVerified}");
      if (user.emailVerified) {
        Get.offAll(() => NavScreen());
      } else {
        Get.offAll(() => Emailvirfy());
      }
    } else {
      Get.offAll(() => AuthScreen());
    }
  }

  void checkverfication() async {
    if (!isintialized) {
      isintialized = true;
    }
    if (cnt > 100) {
      return;
    }
    print("before refresh ${FirebaseAuth.instance.currentUser!.emailVerified}");
    await Future.delayed(Duration(milliseconds: 100));
    await FirebaseAuth.instance.currentUser?.reload();
    print("after refresh ${FirebaseAuth.instance.currentUser!.emailVerified}");
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      Get.offAll(
        () => NavScreen(),
      );
      return;
    }
    checkverfication();
    cnt++;
  }
}
