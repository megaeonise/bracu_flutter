import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/menu/drawer_menu.dart';
import 'package:flutter_application_2/src/utils/spinner_list.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mime/mime.dart';

class AudioPlayback extends StatefulWidget {
  const AudioPlayback({super.key});

  @override
  State<AudioPlayback> createState() => _AudioPlaybackState();
}

class _AudioPlaybackState extends State<AudioPlayback> {
  late AudioPlayer player;
  final audioUrlController = TextEditingController();
  String filePath = '';

  var url = '';
  String menuValue = 'Internet';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setAudioURL() {
    if (mounted) {
      setState(() async {
        url = audioUrlController.text;
        AudioSource source = AudioSource.uri(Uri.parse(url));
        await player.setAudioSource(source);
      });
    }
  }

  void setAudioPath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && mounted && isAudio(result.files.single.path!)) {
      setState(() async {
        filePath = result.files.single.path!;
        AudioSource source = AudioSource.file(filePath);
        await player.setAudioSource(source);
      });
    } else {}
  }

  void clearAudioURL() {
    if (mounted) {
      setState(() {
        url = '';
      });
    }
  }

  void clearAudioPath() {
    if (mounted) {
      setState(() {
        filePath = '';
      });
    }
  }

  bool isAudio(path) {
    List<int> header = File(path).readAsBytesSync().toList().sublist(0, 4);
    return lookupMimeType(path, headerBytes: header)!.contains('audio');
  }

  void changeSelection(String value) {
    if (mounted) {
      setState(() {
        menuValue = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App")),
      drawer: DrawerMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            spinnerList(['Internet', 'Local'], changeSelection, 'Internet'),
            if (menuValue == 'Internet') ...[
              Text("Load audio below by inputting an URL"),
              TextField(controller: audioUrlController),
              if (url == '')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: setAudioURL,
                      child: Text("Load audio"),
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: clearAudioURL,
                      child: Text("Clear audio"),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              if (url != '') ...[Expanded(child: Text("test"))],
            ],
            if (menuValue == 'Local') ...[
              if (filePath == '')
                Text("Select an audio file from your device below"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: setAudioPath,
                    child: Text("Select audio"),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: clearAudioPath,
                    child: Text("Clear audio"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (filePath != '') ...[Expanded(child: Text("test"))],
            ],
          ],
        ),
      ),
    );
  }
}
