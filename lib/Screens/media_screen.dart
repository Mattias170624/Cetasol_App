// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/Widgets/NavScreenWidgets/MediaPage/youtube_container.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YouTubeContainer(),
    );
  }
}
