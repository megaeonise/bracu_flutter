import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/menu/drawer_menu.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_2/src/utils/spinner_list.dart';
import 'package:mime/mime.dart';

class ImageScale extends StatelessWidget {
  const ImageScale({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("App")),
        drawer: DrawerMenu(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ImageViewer()],
          ),
        ),
      ),
    );
  }
}

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key});
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

String url = '';
String filePath = '';
final imageUrlController = TextEditingController();
String menuValue = 'Internet';
bool pickerActive = false;

class _ImageViewerState extends State<ImageViewer> {
  void setImageUrl() {
    print(imageUrlController.text);
    if (mounted && imageUrlController.text!='') {
      setState(() {
      url = imageUrlController.text;
    });
    }
  }

  void setImagePath() async {
    pickerActive = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && mounted && isImage(result.files.single.path!)) {
      isImage(result.files.single.path!);
      setState(() {
        filePath = result.files.single.path!;
      });
    } else {}
    pickerActive = false;
  }

  bool isImage(path) {
    List<int> header = File(path).readAsBytesSync().toList().sublist(0, 4);
    return lookupMimeType(path, headerBytes: header)!.contains('image');
  }

  void clearImageURL() {
    if (mounted) {
      setState(() {
        url = '';
      });
    }
  }

  void clearImagePath() {
    if (mounted) {
      setState(() {
        filePath = '';
      });
    }
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
    return Column(
      children: [
        spinnerList(['Internet', 'Local'], changeSelection, 'Internet'),
        if (menuValue == 'Internet') ...[
          if (url == '') Text("Load an image below by inputting an URL"),
          TextField(controller: imageUrlController),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: setImageUrl, child: Text("Load image")),
              SizedBox(width: 50),
              ElevatedButton(
                onPressed: clearImageURL,
                child: Text("Clear image"),
              ),
            ],
          ),
          if (url != '')
            InteractiveViewer(
              minScale: 0.2,
              maxScale: 4.0,
              child: Image.network(url, fit: BoxFit.cover),
            ),
        ],
        if (menuValue == 'Local') ...[
          if (filePath == '') Text("Select an image from your device below"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: !pickerActive ? setImagePath : null,
                child: Text("Select image"),
              ),
              SizedBox(width: 50),
              ElevatedButton(
                onPressed: clearImagePath,
                child: Text("Clear image"),
              ),
            ],
          ),
          if (filePath != '')
            InteractiveViewer(
              minScale: 0.2,
              maxScale: 4.0,
              child: Image.file(File(filePath), fit: BoxFit.cover),
            ),
        ],
      ],
    );
  }
}
