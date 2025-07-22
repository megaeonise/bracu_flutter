import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class BatteryBroadcastPage extends StatefulWidget {
  const BatteryBroadcastPage({super.key});

  @override
  State<BatteryBroadcastPage> createState() => _BatteryBroadcastPageState();
}

class _BatteryBroadcastPageState extends State<BatteryBroadcastPage> {
  final Battery _battery = Battery();
  late StreamSubscription<BatteryState> _batteryStateSubscription;

  int _batteryLevel = 100; // Default to 100%
  BatteryState? _batteryState;

  @override
  void initState() {
    super.initState();

    // Initial battery level fetch
    _fetchBatteryLevel();

    // Subscribe to battery state changes
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
      });

      // Re-fetch battery level when state changes
      _fetchBatteryLevel();
    });
  }

  Future<void> _fetchBatteryLevel() async {
    final level = await _battery.batteryLevel;
    if (mounted) {
      setState(() {
        _batteryLevel = level;
      });
    }
  }

  @override
  void dispose() {
    _batteryStateSubscription.cancel(); // Stop listening
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Broadcast'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Real-time Battery Status',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Battery Level: $_batteryLevel%',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Charging Status: ${_batteryState?.name ?? "Unknown"}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
