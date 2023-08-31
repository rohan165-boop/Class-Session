import 'package:flutter/material.dart';
import 'package:p_1/video_player/screen/video_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VideoPayerScreen()));
                },
                child: Text("Video Palyer",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Audio Palyer",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
