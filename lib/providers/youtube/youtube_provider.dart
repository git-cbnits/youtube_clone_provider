import 'package:flutter/cupertino.dart';

import '../../models/youtube/channel_info_model.dart';
import '../../models/youtube/video_list_model.dart';
import '../../services/youtube/services.dart';

class YouTubeProvider extends ChangeNotifier{

  YouTubeProvider(){
    getChannelInfo();
  }

  late ChannelInfo _channelInfo;
  late VideosList _videosList;
  late Item _item;
  bool _isLoading = true;
  late String _playListId;
  String _nextPageToken = '';

  ChannelInfo get channelInfo  => _channelInfo;
  VideosList get videosList => _videosList;
  Item get item => _item;
  bool get isLoading => _isLoading;
  String get playListId => _playListId;
  String get nextPageToken => _nextPageToken;


  getChannelInfo() async {
    _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo.items[0];
    _playListId = _item.contentDetails.relatedPlaylists.uploads;
    await loadVideos();
    _isLoading = false;
    notifyListeners();
  }

  loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList(
      playListId: _playListId,
      pageToken: _nextPageToken,
    );
    _videosList = tempVideosList;
    _nextPageToken = tempVideosList.nextPageToken;
  }

}