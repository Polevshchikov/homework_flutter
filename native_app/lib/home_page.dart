import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChange = true;
  static const methodChannel = MethodChannel("examples.dev/location");
  static const streamChannel = EventChannel("examples.dev/location_events");
  var startLocation;

  Future<void> _locationService(bool isChange) async {
    try {
      startLocation = await methodChannel.invokeMethod(
          isChange ? 'stopLocationService' : 'startLocationService');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  _startReading() {
    streamChannel.receiveBroadcastStream().listen((data) {
      print("data= $data");
    });
  }

  void toggleChange() => setState(() => isChange = !isChange);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Текущее местоположение'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Нет данных',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 260,
              child: TextField(
                decoration:
                    InputDecoration(labelText: 'Наименьшее смещение в метрах'),
              ),
            ),
            ElevatedButton(
                onPressed: () => _startReading(), child: Text('Начать читать')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleChange();
          _locationService(isChange);
        },
        tooltip: isChange ? 'Play' : 'Stop',
        child: Icon(isChange ? Icons.play_arrow : Icons.pause),
      ),
    );
  }
}
