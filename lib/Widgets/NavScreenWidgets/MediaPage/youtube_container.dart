// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/Widgets/NavScreenWidgets/MediaPage/video_player.dart';
import 'package:cetasol_app/YoutubeServices/api_service.dart';
import 'package:cetasol_app/Models/channel_model.dart';
import 'package:cetasol_app/Models/video_model.dart';
import 'package:flutter/material.dart';

class YouTubeContainer extends StatefulWidget {
  @override
  State<YouTubeContainer> createState() => _YouTubeContainerState();
}

class _YouTubeContainerState extends State<YouTubeContainer> {
  Channel? _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    // Checking if user has visited media page before
    if (APIService.savedChannelData == null) {
      Channel channel = await APIService.instance
          .fetchChannel(channelId: 'UCmDBX5roe-eTuz7cNS9RNbQ');

      setState(() {
        _channel = channel;
      });
    } else {
      setState(() {
        _channel = APIService.savedChannelData;
      });
    }
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(left: 15),
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            radius: 35,
            backgroundImage: NetworkImage(_channel!.profilePictureUrl),
          ),
          Padding(padding: EdgeInsets.only(right: 15)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel!.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(
                  thickness: 1,
                  endIndent: 10,
                  height: 15,
                ),
                Text(
                  _channel!.videoCount.length == 1
                      ? '1 Total upload'
                      : '${_channel!.videoCount} Total uploads',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPlayer(id: video.id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId);
    List<Video> allVideos = _channel!.videos..addAll(moreVideos);
    setState(() {
      _channel!.videos = allVideos;
    });
    _isLoading = false;
    APIService.savedChannelData = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: _channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel!.videos.length !=
                        int.parse(_channel!.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 1 + _channel!.videos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildProfileInfo();
                  }
                  Video video = _channel!.videos[index - 1];
                  return _buildVideo(video);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
    );
  }
}
