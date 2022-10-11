// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/Screens/media_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String id;

  VideoPlayer({required this.id});
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: widget.id,
          flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
            loop: false,
          ),
        ),
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
          playedColor: Theme.of(context).colorScheme.onPrimary,
        ),
        onEnded: ((metaData) {
          Navigator.pop(context);
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        }),
      ),
    );
  }
}
