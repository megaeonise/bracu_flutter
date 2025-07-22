import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_application_2/widgets/custom_drawer.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _player.setAsset('assets/audios/sample_audio.mp3'); // Load from assets
  }

  @override
  void dispose() {
    _player.dispose(); // Stop and release audio
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Player"),
        backgroundColor: Colors.green,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _player.play(),
              child: const Text("Play"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _player.pause(),
              child: const Text("Pause"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _player.stop(),
              child: const Text("Stop"),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
