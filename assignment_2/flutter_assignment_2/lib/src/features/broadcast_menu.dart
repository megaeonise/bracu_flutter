import 'package:flutter/material.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';

import 'package:flutter_application_2/src/utils/spinner_list.dart';

class BroadcastMenu extends StatefulWidget {
  const BroadcastMenu({super.key});

  @override
  State<BroadcastMenu> createState() => _BroadcastMenuState();
}

class _BroadcastMenuState extends State<BroadcastMenu> {
  String menuValue = 'Custom';
  final Battery _battery = Battery();
  String batteryValue = 'Loading';
  String broadcastValue = "";
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  final broadcastController = TextEditingController();

  void changeSelection(String value) {
    if (mounted) {
      setState(() {
        menuValue = value;
      });
    }
  }

  onPressed() {
    FBroadcast.instance().broadcast(
      "custom_broadcast",
      value: broadcastController.text,
    );
    FBroadcast.instance().register("custom_broadcast", (value, callback) {
      getBroadcastValue(value);
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      getBatteryValue();
    });
  }

  void getBatteryValue() async {
    final percentage = await _battery.batteryLevel;
    if (mounted) {
      setState(() {
        batteryValue = percentage.toString();
      });
    }
  }

  void getBroadcastValue(value) {
    if (mounted) {
      setState(() {
        broadcastValue = value;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    broadcastController.dispose();
    FBroadcast.instance().unregister(this);
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spinnerList(['Custom', 'Battery'], changeSelection, 'Custom'),
        if (menuValue == 'Custom') ...[
          TextField(controller: broadcastController),
          ElevatedButton(onPressed: onPressed(), child: Text("Proceed")),
          Text('Broadcasted value: \n\f$broadcastValue'),
        ],
        if (menuValue == 'Battery') ...[
          if (batteryValue != 'Loading')
            Text('Battery value: \n\f$batteryValue%'),
          if (batteryValue == 'Loading')
            Text('Battery value: \n\f$batteryValue'),
        ],
      ],
    );
  }
}
