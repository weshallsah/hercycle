import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VlogsController extends GetxController {
  Rx<DateTime> dateTime = DateTime.now().obs;
  RxList posts = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getposts() async {
    final data = await FirebaseFirestore.instance.collection("vlogs").get();
    print(data.docs.length);
    if (posts.length != data.docs.length) {
      posts.value = [];
    } else {
      return;
    }
    for (var element in data.docs) {
      posts.value.add(element.data());
    }
    print(posts);
  }
}
