import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PortfolioYoutubePlayer extends StatefulWidget {
  final String youtubeVideoId;

  const PortfolioYoutubePlayer({
    super.key,
    required this.youtubeVideoId,
  });

  @override
  State<PortfolioYoutubePlayer> createState() => _PortfolioYoutubePlayerState();
}

class _PortfolioYoutubePlayerState extends State<PortfolioYoutubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.youtubeVideoId,
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
    );
  }
}
