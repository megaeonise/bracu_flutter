import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/menu/drawer_menu.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_2/src/utils/spinner_list.dart';
import 'package:mime/mime.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: VideoPlayerScreen());
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController controller;
  late ChewieController chewieController;
  late Chewie playerWidget;
  final videoUrlController = TextEditingController();
  String filePath = '';
  bool pickerActive = false;

  var url = '';
  String menuValue = 'Internet';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  void setVideoURL() {
    if (mounted && url!='') {
      setState(() {
        url = videoUrlController.text;
        controller = VideoPlayerController.networkUrl(
          Uri.parse(
            url, //https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4
          ),
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: false,
          ),
        );
        chewieController = ChewieController(
          videoPlayerController: controller,
          autoPlay: true,
          looping: true,
          showControls: true,
        );
      });
    }
  }

  void setVideoPath() async {
    pickerActive = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    print(FilePicker.platform);
    if (result != null && mounted && isVideo(result.files.single.path!)) {
      setState(() {
        filePath = result.files.single.path!;
      });
      controller = VideoPlayerController.file(
        File(filePath),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
      );
      chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
        showControls: true,
      );
    } else {}
        pickerActive = false;

  }

  void clearVideoURL() {
    if (mounted) {
      setState(() {
        url = '';
      });
    }
  }

  void clearVideoPath() {
    if (mounted) {
      setState(() {
        filePath = '';
      });
    }
  }

  bool isVideo(path) {
    List<int> header = File(path).readAsBytesSync().toList().sublist(0, 4);
    return lookupMimeType(path, headerBytes: header)!.contains('video');
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
              if (url == '') Text("Load video below by inputting an URL"),
              TextField(controller: videoUrlController),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: setVideoURL,
                    child: Text("Load video"),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: clearVideoURL,
                    child: Text("Clear video"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (url != '') ...[
                Expanded(child: Chewie(controller: chewieController)),
              ],
            ],
            if (menuValue == 'Local') ...[
              if (filePath == '') Text("Select a video from your device below"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: !pickerActive ? setVideoPath : null,
                    child: Text("Select video"),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: clearVideoPath,
                    child: Text("Clear video"),
                  ),
                ],
              ),

              SizedBox(height: 20),
              if (filePath != '') ...[
                Expanded(child: Chewie(controller: chewieController)),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
