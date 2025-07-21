import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VangtiChai',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 155, 108),
        ),
      ),
      home: const MyHomePage(title: 'VangtiChai'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int point = 0;
  String taka = "";
  int takaCounter = 0;
  List<int> changeArray = [0, 0, 0, 0, 0, 0, 0, 0];
  List<String> incrementArray = ["500", "100", "50", "20", "10", "5", "2", "1"];
  void addTaka(String digit) {
    setState(() {
      if (digit == "CLEAR") {
        taka = "";
        takaCounter = 0;
        changeArray = [0, 0, 0, 0, 0, 0, 0, 0];
      } else {
        taka += digit;
        takaCounter = int.parse(taka);
        for (int i = 0; i < incrementArray.length; i++) {
          changeArray[i] = takaCounter ~/ int.parse(incrementArray[i]);
          takaCounter -= changeArray[i] * int.parse(incrementArray[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<double> contextValues = [
      16,
      MediaQuery.sizeOf(context).width / 6,
      MediaQuery.sizeOf(context).height / 12,
    ];
    print(MediaQuery.sizeOf(context));
    print("this is the query");
    print(MediaQuery.of(context).orientation);
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      contextValues = [
        14,
        MediaQuery.sizeOf(context).width / 10,
        MediaQuery.sizeOf(context).height / 20,
      ];
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  style: TextStyle(fontSize: contextValues[0]),
                  'Taka: $taka',
                ),
              ),
              SizedBox(height: contextValues[2] / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  changeLandscape(contextValues),
                  keypadLandscape(contextValues),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                style: TextStyle(fontSize: contextValues[0]),
                'Taka: $taka',
              ),
            ),
            SizedBox(height: contextValues[2] / 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [change(contextValues), keypad(contextValues)],
            ),
          ],
        ),
      ),
    );
  }

  Column change(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (var i = 0; i < incrementArray.length; i++) ...[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              style: TextStyle(fontSize: context[0]),
              '${incrementArray[i]}: ${changeArray[i]}',
            ),
          ),
          SizedBox(height: context[2] / 70),
        ],
      ],
    );
  }

  Row changeLandscape(context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var i = 0; i < incrementArray.length / 2; i++) ...[
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  style: TextStyle(fontSize: context[0]),
                  '${incrementArray[i]}: ${changeArray[i]}',
                ),
              ),
              SizedBox(height: context[2] / 40),
            ],
          ],
        ),
        SizedBox(width: context[1]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (
              var i = incrementArray.length ~/ 2;
              i < incrementArray.length;
              i++
            ) ...[
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  style: TextStyle(fontSize: context[0]),
                  '${incrementArray[i]}: ${changeArray[i]}',
                ),
              ),
              SizedBox(height: context[2] / 35),
            ],
          ],
        ),
      ],
    );
  }

  Column keypad(context) => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      keypadRow(["1", "2", "3"], context),
      SizedBox(height: 5),
      keypadRow(["4", "5", "6"], context),
      SizedBox(height: 5),
      keypadRow(["7", "8", "9"], context),
      SizedBox(height: 5),
      keypadRow(["0", "CLEAR"], context),
    ],
  );

  Column keypadLandscape(context) => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      keypadRowLandscape(["1", "2", "3", "4"], context),
      SizedBox(height: 5),
      keypadRowLandscape(["5", "6", "7", "8"], context),
      SizedBox(height: 5),
      keypadRowLandscape(["9", "0", "CLEAR"], context),
    ],
  );

  Row keypadRow(digits, context) {
    if (digits.length == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 5),
          keypadButton(digits[0], context),
          SizedBox(width: 5),
          keypadButton(digits[1], context),
          SizedBox(width: 5),
          keypadButton(digits[2], context),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 10),
          keypadButton(digits[0], context),
          SizedBox(width: 5),
          keypadButton(digits[1], context),
        ],
      );
    }
  }

  Row keypadRowLandscape(digits, context) {
    print("in keypad row landscape");
    print(digits);
    print(context);
    if (digits.length == 4) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 5),
          keypadButton(digits[0], context),
          SizedBox(width: 5),
          keypadButton(digits[1], context),
          SizedBox(width: 5),
          keypadButton(digits[2], context),
          SizedBox(width: 5),
          keypadButton(digits[3], context),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 5),
          keypadButton(digits[0], context),
          SizedBox(width: 5),
          keypadButton(digits[1], context),
          SizedBox(width: 5),
          keypadButton(digits[2], context),
        ],
      );
    }
  }

  ElevatedButton keypadButton(digit, context) {
    if (digit == "CLEAR") {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: ContinuousRectangleBorder(),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: Size(context[1] * 2 + 5, context[2]),
        ),
        onPressed: () {
          addTaka(digit);
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            style: TextStyle(fontSize: context[0], color: Colors.black),
            digit,
          ),
        ),
      );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: ContinuousRectangleBorder(),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size(context[1], context[2]),
      ),
      onPressed: () {
        addTaka(digit);
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          style: TextStyle(fontSize: context[0], color: Colors.black),
          digit,
        ),
      ),
    );
  }
}
