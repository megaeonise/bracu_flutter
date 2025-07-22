import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_application_2/widgets/custom_drawer.dart';

class ImageScalePage extends StatelessWidget {
  const ImageScalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Scale'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: const AssetImage('assets/images/sample_image.jpg'),
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.5,
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
