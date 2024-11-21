import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  String url;
  YoutubePlayerScreen({required this.url, super.key});
  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;
  Duration? _duration;

  // Example YouTube URL - replace with your video URL

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.url);
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
        forceHD: false,
        loop: true,
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

  // @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
      progressColors: ProgressBarColors(
        playedColor: Colors.red,
        handleColor: Colors.redAccent,
      ),
      onReady: () {
        setState(() {
          _duration = _controller.metadata.duration;
        });
      },
    );
  }

  @override
  void dispose() async {
    // _controller.dispose();
    super.dispose();
  }
}
