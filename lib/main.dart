import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone_provider/providers/youtube/youtube_provider.dart';
import 'package:youtube_clone_provider/screens/youtube/listing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Clone Provider',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ChangeNotifierProvider<YouTubeProvider>(
        create: (context)=> YouTubeProvider(),
        child: const ListingPage(),
      ),
    );
  }
}

