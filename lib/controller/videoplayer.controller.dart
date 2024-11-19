import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  RxInt cnt = 0.obs;
  RxString url = "".obs;
  RxBool isplaying = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (url == "") {
      return;
    }
    videoPlayerController =
        new VideoPlayerController.networkUrl(Uri.parse(url.value))
          ..setLooping(false)
          ..initialize();
    videoPlayerController.pause();
    isplaying.value = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }
}
