import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/splash.controller.dart';
import 'package:intl/intl.dart';

class Profilecontroller extends GetxController {
  RxBool isedit = false.obs;
  TextEditingController username = TextEditingController(text: "Siddhi Sah");
  RxString email = "vishalk74064@gmail.com".obs;
  RxString name = "siddhi sah".obs;
  RxString Imageurl = "".obs;
  RxString avatar = "".obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    final user = await FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .get();
    email.value = userdata.data()?['email'];
    name.value = userdata.data()?['name'];
    Imageurl.value = userdata.data()?['avatar'];
    username.text = name.value;
  }

  void singout() async {
    await FirebaseAuth.instance.signOut();
    Splashcontroller().onInit();
  }
}
