import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone_provider/providers/youtube/youtube_provider.dart';
import 'package:youtube_clone_provider/screens/youtube/video_player_page.dart';

import '../../models/youtube/video_list_model.dart';


class ListingPage extends StatelessWidget {
  const ListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<YouTubeProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My YouTube Channel'),
          ),
          body: value.isLoading?
          const Center(
            child: CircularProgressIndicator(),
          ):
          ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.network(value.item.snippet.thumbnails.medium.url,height: 40,width: 40,),
                      const SizedBox(width: 20,),
                      Text(
                        value.item.snippet.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              value.videosList.videos.isEmpty?
              Container(
                height: MediaQuery.of(context).size.height/1.5,
                alignment: Alignment.center,
                child: const Text('No Video Found',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ):
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: value.videosList.videos.length,
                itemBuilder: (context, index) {
                  VideoItem videoItem = value.videosList.videos[index];
                  return InkWell(
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return VideoPlayerScreen(
                              videoItem: videoItem,
                            );
                          }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(videoItem.video.thumbnails.thumbnailsDefault.url),
                          const SizedBox(width: 20),
                          Flexible(
                            child: Text(
                              videoItem.video.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

