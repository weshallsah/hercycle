import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
  String? pathh;

  @override
  _VideoPlayState createState() => _VideoPlayState();

  VideoPlay({
    Key? key,
    this.pathh, // Video from assets folder
  }) : super(key: key);
}

class _VideoPlayState extends State<VideoPlay> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;

  initVideo() {
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.pathh!));
    futureController = controller!.initialize();
  }

  @override
  void initState() {
    initVideo();
    controller!.addListener(() {
      if (controller!.value.isInitialized) {
        setState(() {});
        currentPosition.value = controller!.value;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 340.h,
            child: Center(
              child: const CircularProgressIndicator.adaptive(),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: Stack(children: [
                  Positioned.fill(
                    child: Container(
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(.7),
                              Colors.transparent
                            ],
                            stops: [
                              0,
                              .3
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      child: VideoPlayer(controller!),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (controller!.value.isPlaying) {
                                  controller!.pause();
                                } else {
                                  controller!.play();
                                }
                              });
                            },
                            child: Container(),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ValueListenableBuilder(
                              valueListenable: currentPosition,
                              builder: (context,
                                  VideoPlayerValue? videoPlayerValue, w) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        videoPlayerValue!.position
                                            .toString()
                                            .substring(
                                                videoPlayerValue.position
                                                        .toString()
                                                        .indexOf(':') +
                                                    1,
                                                videoPlayerValue.position
                                                    .toString()
                                                    .indexOf('.')),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        videoPlayerValue.duration
                                            .toString()
                                            .substring(
                                                videoPlayerValue.duration
                                                        .toString()
                                                        .indexOf(':') +
                                                    1,
                                                videoPlayerValue.duration
                                                    .toString()
                                                    .indexOf('.')),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ValueListenableBuilder(
                              valueListenable: currentPosition,
                              builder: (context,
                                  VideoPlayerValue? videoPlayerValue, w) {
                                return Container(
                                  child: Slider(
                                    value: videoPlayerValue!.position.inSeconds
                                        .toDouble(),
                                    max: videoPlayerValue.duration.inSeconds
                                        .toDouble(),
                                    min: 0,
                                    thumbColor: Colors.red,
                                    activeColor: Colors.red,
                                    onChanged: (value) {
                                      setState(() {
                                        controller!.seekTo(
                                          Duration(seconds: value.toInt()),
                                        );
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ])),
          );
        }
      },
    );
  }
}
