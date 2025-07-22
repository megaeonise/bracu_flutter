import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/menu/audio_buttons.dart';
import 'package:flutter_application_2/src/menu/drawer_menu.dart';
import 'package:flutter_application_2/src/utils/spinner_list.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mime/mime.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/src/menu/audio_slider.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayback extends StatefulWidget {
  const AudioPlayback({super.key});

  @override
  State<AudioPlayback> createState() => _AudioPlaybackState();
}

class _AudioPlaybackState extends State<AudioPlayback> with WidgetsBindingObserver{
  final player = AudioPlayer();
  final audioUrlController = TextEditingController();
  String filePath = '';
  bool pickerActive = false;
  var url = '';
  String menuValue = 'Internet';

  @override
  void initState() {
    super.initState();
        ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }

  @override
  void dispose() {
        ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    player.dispose();
//     super.dispose();
    super.dispose();
  }
    
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.stop();
    }
  }

  void setAudioURL() async{
    if (mounted && url!='') {
      setState(()  {
        url = audioUrlController.text;
      });
      await initUrl();
    }
  }

    Future<void> initUrl() async {    
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(
          url)));
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }}

  void setAudioPath() async {
    pickerActive = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && mounted && isAudio(result.files.single.path!)) {
      setState(()  {
        filePath = result.files.single.path!;
      });
      await initPath();
    } else {}
    pickerActive = false;
  }

      Future<void> initPath() async {        final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    try {
      await player.setAudioSource(AudioSource.file(filePath));
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
    }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

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
              if (url == '')
              Text("Load audio below by inputting an URL"),
              TextField(controller: audioUrlController),
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
              if (url != '') ...[Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              ControlButtons(player),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: player.seek,
                  );
                },
              ),
              ],))],
            ],
            if (menuValue == 'Local') ...[
              if (filePath == '')
                Text("Select an audio file from your device below"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: !pickerActive ? setAudioPath : null,
                    child: Text("Select audio"),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: clearAudioPath,
                    child: Text("Clear audio"),
                  ),
                ],
              ),
              if (filePath != '') ...[Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              ControlButtons(player),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: player.seek,
                  );
                },
              ),
              ],))],
            ],
          ],
        ),
      ),
    );
  }
} //https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3
