import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class Workoutcontroller extends GetxController {
  RxBool isplaying = false.obs;
  final player = AudioPlayer();
  Rx<Duration> pos = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<DateTime> dateTime = DateTime.now().obs;
  RxBool isgym = false.obs;
  int cnt = 0;
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
