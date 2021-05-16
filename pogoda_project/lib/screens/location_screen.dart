import 'package:flutter/material.dart';
import 'package:pogoda_project/api/weather_api.dart';
import 'package:pogoda_project/screens/weather_forecasr_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void getLocationData() async {
    try {
      var weatherInfo = await WeatherApi().fetchWeatherForecast();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return WeatherForecastScreen(locatiomWeather: weatherInfo);
      }));
    } catch (e) {
      print('$e');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return WeatherForecastScreen();
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
