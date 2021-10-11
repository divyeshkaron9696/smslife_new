import 'package:flutter/material.dart';
import 'package:get_served/resources/color_resources.dart';
import 'package:get_served/resources/image_resources.dart';
import 'package:video_player/video_player.dart';

class VideoDesignScreen extends StatefulWidget {
  final String? url;
  const VideoDesignScreen({Key? key, this.url}) : super(key: key);

  @override
  _VideoDesignScreenState createState() => _VideoDesignScreenState();
}

class _VideoDesignScreenState extends State<VideoDesignScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url!)
      ..initialize().then((_) {
        setState(() {});  //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller!.value.isInitialized
        ? AspectRatio(
          aspectRatio: 16/9,
          child: Stack(
            children: [
              VideoPlayer(_controller!),
              Container(
                color: ColorRes.black.withOpacity(0.5),
                  child: Center(child: Image.asset(ImageRes.playbutton,width: 80,color: Colors.white,)))
            ],
          )
        ): AspectRatio(
          aspectRatio: 16/9,
          child: Stack(
          children: [
            Container(
              color: ColorRes.black.withOpacity(0.5),
              child: Center(child: Image.asset(ImageRes.playbutton,width: 80,color: Colors.white,))),
              Center(child: CircularProgressIndicator(backgroundColor: ColorRes.orange,valueColor:AlwaysStoppedAnimation<Color>(ColorRes.red))),
      ],
    ),
        );
  }
}