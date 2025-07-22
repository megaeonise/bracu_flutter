import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/custom_broadcast_page.dart';
import 'package:flutter_application_2/pages/battery_broadcast_page.dart';
import 'package:flutter_application_2/widgets/custom_drawer.dart';

class BroadcastReceiverPage extends StatefulWidget {
  const BroadcastReceiverPage({super.key});

  @override
  State<BroadcastReceiverPage> createState() => _BroadcastReceiverPageState();
}

class _BroadcastReceiverPageState extends State<BroadcastReceiverPage> {
  String selectedType = 'Custom';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Broadcast Receiver'),
        backgroundColor: Colors.green,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () {
        //     Scaffold.of(context).openDrawer();
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Select a broadcast type',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: DropdownButton<String>(
                value: selectedType,
                items: const [
                  DropdownMenuItem(
                    value: 'Custom',
                    child: Text('Custom'),
                  ),
                  DropdownMenuItem(
                    value: 'Battery',
                    child: Text('Battery'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedType = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (selectedType == 'Custom') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomBroadcastPage()),
                  );
                } else if (selectedType == 'Battery') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BatteryBroadcastPage()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.purple.shade100,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Text(
                  'Proceed',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
