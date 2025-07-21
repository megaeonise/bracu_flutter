import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/src/features/audio_playback.dart';
import 'package:flutter_application_2/src/features/image_scale.dart';
import 'package:flutter_application_2/src/features/video_player.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 100),
          ListTile(
            title: const Text("Broadcast Reciever"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainApp()),
              );
            },
          ),
          SizedBox(height: 20),
          ListTile(
            title: const Text("Image Scale"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ImageScale()),
              );
            },
          ),
          SizedBox(height: 20),
          ListTile(
            title: const Text("Video"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const VideoPlayerApp()),
              );
            },
          ),
          SizedBox(height: 20),
          ListTile(
            title: const Text("Audio"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AudioPlayback()),
              );
            },
          ),
        ],
      ),
    );
  }
}
