import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/splash.controller.dart';
import 'package:hercycle/main.dart';
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

  void Login() async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Splashcontroller().onInit();
    } catch (e) {
      print("Error := ${e}");
    }
  }

  void signup() async {
    bool ismy = true;
    try {
      if (name.text.isEmpty) {
        throw "please enter name";
      }
      if (!date.text.isNum) {
        throw "Date is not a vaild type";
      }
      if (int.parse(date.text) >= 32) {
        throw "Date is not valid";
      }
      if (!email.text.isEmail) {
        throw "please enter valid email";
      }
      if (password.text.isEmpty) {
        throw "please enter password";
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then(
        (value) async {
          try {
            print("inside then ${value.user?.uid}");
            final storageRef = await FirebaseStorage.instance.ref();
            final filename = "${value.user!.uid}.png";
            final spaceRef = await storageRef.child("avatar/${filename}");
            File avatar = File(image.value);
            await spaceRef.putFile(avatar);
            print("spaceRef := ${spaceRef}");
            final url = await spaceRef.getDownloadURL();
            print("url ${url}");
            await FirebaseFirestore.instance
                .collection("user")
                .doc(value.user!.uid)
                .set({
              "email": email.text,
              "name": name.text,
              "cycledate": int.parse(date.text),
              "avatar": url
            });
            print("user is created");
            Splashcontroller().onInit();
          } catch (e) {
            print("Error := ${e}");
          }
        },
      );
      // print(user);
    } catch (e) {
      print("Error ${e}");
    }
  }
}
