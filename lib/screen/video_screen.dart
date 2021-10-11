import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  final String? url;
  final String? title;
  const VideoScreen({Key? key,this.url,this.title}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  BetterPlayerConfiguration? betterPlayerConfiguration;
  BetterPlayerListVideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = BetterPlayerListVideoPlayerController();
    betterPlayerConfiguration = BetterPlayerConfiguration(autoPlay: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayerListVideoPlayer(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.url!,
        notificationConfiguration: BetterPlayerNotificationConfiguration(
            showNotification: true,
            title: widget.title,
            author: "Test"),
        bufferingConfiguration: BetterPlayerBufferingConfiguration(
            minBufferMs: 2000,
            maxBufferMs: 10000,
            bufferForPlaybackMs: 1000,
            bufferForPlaybackAfterRebufferMs: 2000),
      ),
      configuration: BetterPlayerConfiguration(
        autoPlay: false,
        fullScreenByDefault: true,
      ),
      //key: Key(videoListData.hashCode.toString()),
      playFraction: 0.8,
      betterPlayerListVideoPlayerController: controller,
    );
  }
}
