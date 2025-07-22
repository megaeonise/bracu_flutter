import 'package:flutter/material.dart';
import 'package:flutter_broadcasts/flutter_broadcasts.dart';

class CustomBroadcastPage extends StatefulWidget {
  const CustomBroadcastPage({super.key});

  @override
  State<CustomBroadcastPage> createState() => _CustomBroadcastPageState();
}

class _CustomBroadcastPageState extends State<CustomBroadcastPage> {
  final TextEditingController _controller = TextEditingController();
  late BroadcastReceiver receiver;

  static const String customAction = "com.example.flutter_broadcast.CUSTOM_ACTION";

  @override
  void initState() {
    super.initState();

    receiver = BroadcastReceiver(names: <String>[customAction]);
    receiver.start();

    receiver.messages.listen((BroadcastMessage message) {
      final String? content = message.data?['content'];
      if (content != null && mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Broadcast Received"),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              )
            ],
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    receiver.stop();
    _controller.dispose();
    super.dispose();
  }

  void _sendBroadcast() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      sendBroadcast(
        BroadcastMessage(
          name: customAction,
          data: {'content': message},
        ),
      );
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Broadcast")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter message to broadcast",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendBroadcast,
              child: const Text("Broadcast"),
            ),
          ],
        ),
      ),
    );
  }
}
