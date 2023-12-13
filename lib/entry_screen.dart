import 'package:flutter/material.dart';
import 'package:p_1/animation/view.dart';
import 'package:p_1/audio_player/screen/audio_player.dart';
import 'package:p_1/camera_detcator/camera_screen.dart';
import 'package:p_1/eSewa/e_sewa_screen.dart';
import 'package:p_1/khalti/khalti_screen.dart';
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CustomAudioPlayer()));
                },
                child: Text("Audio Palyer",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const CameraScreen()));
                },
                child: Text("Camera",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ESewaScreen()));
                },
                child: Text("E-Sewa",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KhaltiScreen()));
                },
                child: Text("Khalti",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AnimatedPathDemo()));
                },
                child: Text("Animation",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AnimatedPathDemo()));
                },
                child: Text("Pdf View",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
