import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/features/broadcast_menu.dart';
import 'package:flutter_application_2/src/menu/drawer_menu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("App")),
        drawer: DrawerMenu(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Select a broadcast type"), BroadcastMenu()],
          ),
        ),
      ),
    );
  }
}
