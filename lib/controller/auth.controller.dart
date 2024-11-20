import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hercycle/component/toast.dart';
import 'package:hercycle/controller/splash.controller.dart';
import 'package:hercycle/main.dart';
import 'package:hercycle/services/notification.services.dart';
import 'package:image_picker/image_picker.dart';

class Authcontroller extends GetxController {
  RxBool isshow = true.obs;
  RxBool isLogin = true.obs;
  RxBool isimage = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  RxString image = "".obs;
  RxBool isverifyclicked = false.obs;
  RxBool isloading = false.obs;
  NotificationServices notificationServices = NotificationServices();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    notificationServices.requestNotificationPermission();
  }

  void pickimage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        image.value = file.path;
        isimage.value = true;
      }
    } catch (e) {
      print("Error ${e}");
    }
  }

  void forgetpassword(BuildContext context) async {
    bool ismy = false;
    try {
      isloading.value = true;
      if (email.text.isEmpty) {
        ismy = true;
        throw "please enter email";
      }
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      isloading.value = false;
    } catch (e) {
      print(e);
      if (ismy) {
        showToast(context, e.toString());
      } else {
        showToast(
          context,
          "please check your credential",
        );
      }
      isloading.value = false;
    }
  }

  void Login(BuildContext context) async {
    bool ismy = false;
    try {
      isloading.value = true;
      if (email.text.isEmpty) {
        ismy = true;
        throw "plese enter email id";
      }
      if (password.text.isEmpty) {
        ismy = true;
        throw "please enter password";
      }
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then(
        (value) async {
          try {
            final apnsToken = await notificationServices.gettoken();
            await FirebaseFirestore.instance
                .collection("user")
                .doc(value.user!.uid)
                .update({
              "usertoke": apnsToken,
            });
          } catch (e) {
            print(e);
          }
        },
      );

      email.clear();
      password.clear();
      isloading.value = false;
      Splashcontroller().onInit();
    } catch (e) {
      print("Error := ${e}");
      if (ismy) {
        showToast(context, e.toString());
      } else {
        showToast(
          context,
          "please check your credential",
        );
      }
      isloading.value = false;
    }
  }

  void signup(BuildContext context) async {
    bool ismy = false;
    try {
      isloading.value = true;
      if (name.text.isEmpty) {
        ismy = true;
        throw "please enter name";
      }
      if (!email.text.isEmail) {
        ismy = true;
        throw "please enter valid email";
      }
      if (!date.text.isNum) {
        ismy = true;
        throw "Date is not a vaild type";
      }
      if (int.parse(date.text) >= 32 || int.parse(date.text) <= 0) {
        ismy = true;
        throw "Date is not valid";
      }
      if (password.text.isEmpty) {
        ismy = true;
        throw "please enter password";
        // ismy=true;
      }
      if (password.text.length < 6) {
        ismy = true;
        throw "password is week";
        // ismy=true;
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then(
        (value) async {
          try {
            String url = "";
            if (image != "") {
              print("inside then ${value.user?.uid}");
              final storageRef = await FirebaseStorage.instance.ref();
              final filename = "${value.user!.uid}.png";
              final spaceRef = await storageRef.child("avatar/${filename}");
              File avatar = File(image.value);
              await spaceRef.putFile(avatar);
              print("spaceRef := ${spaceRef}");
              url = await spaceRef.getDownloadURL();
              print("url ${url}");
            }
            final apnsToken = await notificationServices.gettoken();
            await FirebaseFirestore.instance
                .collection("user")
                .doc(value.user!.uid)
                .set({
              "email": email.text,
              "name": name.text,
              "cycledate": int.parse(date.text),
              "avatar": url,
              "createdat": Timestamp.now(),
              "usertoke": apnsToken,
            });
            email.clear();
            password.clear();
            name.clear();
            date.clear();
            isloading.value = false;
            Splashcontroller().onInit();
          } catch (e) {
            print("Error := ${e}");
          }
        },
      );
      isloading.value = false;
      // print(user);
    } catch (e) {
      print("Error ${e}");
      if (ismy) {
        showToast(context, e.toString());
      } else {
        showToast(
          context,
          "please check your credential",
        );
      }
      isloading.value = false;
    }
  }
}
