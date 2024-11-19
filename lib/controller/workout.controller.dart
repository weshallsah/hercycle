import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Workoutcontroller extends GetxController {
  RxBool isplaying = false.obs;
  final player = AudioPlayer();
  Rx<Duration> pos = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<DateTime> dateTime = DateTime.now().obs;

  RxBool isgym = false.obs;
  int cnt = 0;
  RxList diets = [].obs;
  RxList workout = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dateTime.value = DateTime.now();
    // print(duration.value);
    if (cnt == 0) {
      player.setSourceAsset("audio/relaxmusic.mp3");
    }
    player.onPlayerStateChanged.listen(
      (event) {
        isplaying.value = event == PlayerState.playing;
      },
    );
    player.onDurationChanged.listen(
      (event) {
        duration.value = event;
      },
    );
    player.onPositionChanged.listen(
      (event) {
        pos.value = event;
      },
    );
  }

  void getdiets() async {
    final data = await FirebaseFirestore.instance.collection("Diets").get();
    // print(data.docs[0].data());
    if (diets.length != data.docs.length) {
      diets.value = [];
    } else {
      return;
    }
    for (var element in data.docs) {
      diets.value.add(element.data());
    }
    // print(diets);
  }

  void getworkout() async {
    final data = await FirebaseFirestore.instance.collection("workouts").get();
    // print(data.docs[0].data());
    if (workout.length != data.docs.length) {
      workout.value = [];
    } else {
      return;
    }
    for (var element in data.docs) {
      workout.value.add(element.data());
    }
  }

  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //   super.onReady();
  //   // player.dispose();
  //   player.pause();
  // }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    player.pause();
    print("on closed method is called");
    // player.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("disposing the music player");
    player.pause();
    player.dispose();
  }

  void play() async {
    print(isplaying);
    if (isplaying.value) {
      player.pause();
      return;
    } else {
      await player.play(AssetSource("audio/relaxmusic.mp3"));
    }
    onInit();
  }
}
