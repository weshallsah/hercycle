import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hercycle/controller/splash.controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Profilecontroller extends GetxController {
  RxBool isedit = false.obs;
  TextEditingController username = TextEditingController(text: "");
  RxString email = "".obs;
  RxString name = "".obs;
  RxString Imageurl = "".obs;
  RxString avatar = "".obs;
  RxString image = "".obs;
  RxBool isimage = false.obs;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  RxList notes = [].obs;
  RxList notesid = [].obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    final user = await FirebaseAuth.instance.currentUser;
    // uid = user?.uid;
    final userdata = await FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .get();
    email.value = userdata.data()?['email'];
    name.value = userdata.data()?['name'];
    Imageurl.value = userdata.data()?['avatar'];
    username.text = name.value;
    getnotes();
  }

  void getnotes() async {
    // notes.value = [];
    final data = await FirebaseFirestore.instance
        .collection("notes")
        .doc(uid)
        .collection("quotes")
        .orderBy("createdat", descending: true)
        .get();
    if (notes.length != data.docs.length) {
      notes.value = [];
      notesid.value = [];
    } else {
      return;
    }
    for (var d in data.docs) {
      notes.add(d.data());
      notesid.add(d.id);
    }
    print(notes);
  }

  void deletenote(int idx) async {
    print(idx);
    await FirebaseFirestore.instance
        .collection("notes")
        .doc(uid)
        .collection("quotes")
        .doc(notesid[idx])
        .delete()
        .then(
      (value) {
        print("deleted");
        getnotes();
      },
    );
  }

  void singout() async {
    await FirebaseAuth.instance.signOut();
    Splashcontroller().onInit();
  }

  Future profileupdate() async {
    try {
      if (!image.value.isEmpty) {
        final reftoupdate =
            await FirebaseStorage.instance.refFromURL(Imageurl.value);
        File avatar = File(image.value);
        print(image.value);
        await reftoupdate.putFile(avatar);
        // onInit();
        Imageurl.value = "";
        Imageurl.value = await reftoupdate.getDownloadURL();
        image.value = "";
      }
      if (name == username.text) {
        return;
      }
      name.value = username.text;
      await FirebaseFirestore.instance.collection("user").doc(uid).update({
        "name": username.text,
      });
    } catch (e) {
      print("Error := ${e}");
    }
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
}
