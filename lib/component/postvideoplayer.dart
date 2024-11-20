import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// or import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerScreen extends StatefulWidget {
  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;
  Duration? _duration;

  // Example YouTube URL - replace with your video URL
  final String videoUrl =
      "https://www.youtube.com/embed/1hhHhLP3_To?si=2CjrnngHta9LqbOV";

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      _initYoutubePlayer(videoId);
    }
  }

  void _initYoutubePlayer(String videoId) async {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: false,
        forceHD: false,
        controlsVisibleAtStart: true,
      ),
    );

    _controller.addListener(() {
      if (_controller.metadata.duration != Duration.zero &&
          _duration != _controller.metadata.duration) {
        setState(() {
          _duration = _controller.metadata.duration;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('YouTube Player')),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onReady: () {
          print('Player is ready.');
          // You can also get duration here
          setState(() {
            _duration = _controller.metadata.duration;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
