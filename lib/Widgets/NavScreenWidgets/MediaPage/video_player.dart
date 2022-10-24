// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String id;

  VideoPlayer({super.key, required this.id});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController? _videoController;

  @override
  void initState() {
    _videoController = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(mute: false, autoPlay: true, loop: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Video',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Center(
          child: YoutubePlayer(
            controller: _videoController!,
            showVideoProgressIndicator: true,
            progressColors: ProgressBarColors(
              playedColor: Theme.of(context).colorScheme.onPrimary,
            ),
            onEnded: ((metaData) {
              Navigator.pop(context);
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _videoController!.dispose();
  }
}
