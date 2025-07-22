import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/broadcast_receiver_page.dart';
import 'package:flutter_application_2/pages/image_scale_page.dart';
import 'package:flutter_application_2/pages/video_page.dart';
import 'package:flutter_application_2/pages/audio_page.dart';
import 'package:flutter_application_2/main.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Tools Drawer',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(' Home '),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.broadcast_on_personal),
            title: const Text(' Broadcast Receiver '),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BroadcastReceiverPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.image_aspect_ratio),
            title: const Text(' Image Scale '),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ImageScalePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.ondemand_video),
            title: const Text(' Video '),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const VideoPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.audiotrack),
            title: const Text(' Audio '),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AudioPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
