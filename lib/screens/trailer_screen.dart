import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrailerScreen extends StatefulWidget {
  const TrailerScreen({super.key});

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller!.pause();
          Navigator.pop(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
