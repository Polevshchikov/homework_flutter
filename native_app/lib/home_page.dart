import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_app/location_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChange = true;
  static const methodChannel = MethodChannel("examples.dev/location");
  static const streamChannel = EventChannel("examples.dev/location_events");
  TextEditingController _controller = TextEditingController();
  var servicLocation;
  double distanceValue = 0.0;
  LocationModel? locationModel = null;

  Future<void> _locationService(bool isChange, double distanceValue) async {
    try {
      servicLocation = isChange
          ? await methodChannel.invokeMethod('stopLocationService')
          : await methodChannel.invokeMethod(
              'startLocationService', distanceValue);
    } on PlatformException catch (e) {
      print("Error: '${e.message}'.");
    }
  }

  void getData(String dataEvent) async {
    LocationModel _locationModel =
        LocationModel.fromJson(await json.decode(dataEvent));
    setState(() {
      locationModel = _locationModel;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.text = distanceValue.toString();
    streamChannel.receiveBroadcastStream().listen((dynamic event) {
      getData(event);
    }, onError: (dynamic error) {
      print('Received error: ${error.message}');
    });
  }

  void toggleChange() => setState(() => isChange = !isChange);
  void setDistance() =>
      setState(() => distanceValue = double.parse(_controller.text));
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
            locationModel == null
                ? Text(
                    'Нет данных',
                    style: TextStyle(fontSize: 20),
                  )
                : Column(
                    children: [
                      Text(
                        '${locationModel!.street}, ${locationModel!.houseNum}, ${locationModel!.region}, ${locationModel!.country}, ${locationModel!.postalCode}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${locationModel!.latitude.toStringAsFixed(7)}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${locationModel!.longitude.toStringAsFixed(7)}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Обновлено в ${locationModel!.hourTime}:${locationModel!.minuteTime}:${locationModel!.secondTime}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
            isChange
                ? Container(
                    width: 200,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      decoration: InputDecoration(
                          labelText: 'Наименьшее смещение в метрах'),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setDistance();
          toggleChange();
          _locationService(isChange, distanceValue);
        },
        tooltip: isChange ? 'Play' : 'Stop',
        child: Icon(isChange ? Icons.play_arrow : Icons.pause),
      ),
    );
  }
}
