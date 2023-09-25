// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoControlers extends StatefulWidget {
  const CustomVideoControlers(
      {Key? key,
      required this.videoPlayerController1,
      required this.videoPlayerController2,
      this.currPlayIndex = 0})
      : super(key: key);

  final VideoPlayerController videoPlayerController1;
  final VideoPlayerController videoPlayerController2;
  final int currPlayIndex;

  @override
  State<CustomVideoControlers> createState() => _CustomVideoControlersState();
}

class _CustomVideoControlersState extends State<CustomVideoControlers> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [],
      ),
    );
  }
}
