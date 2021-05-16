import 'package:flutter/material.dart';
import 'package:pogoda_project/api/weather_api.dart';
import 'package:pogoda_project/models/weather_forecast_deily.dart';
import 'package:pogoda_project/screens/city_screen.dart';
import 'package:pogoda_project/widgets/bottom_list_view.dart';
import 'package:pogoda_project/widgets/city_view.dart';
import 'package:pogoda_project/widgets/detail_view.dart';
import 'package:pogoda_project/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  WeatherForecastScreen({Key key, this.locatiomWeather});
  final locatiomWeather;
  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  Future<WeatherForecast> forecastObject;
  String _cityName = 'Omsk';

  @override
  void initState() {
    super.initState();

    if (widget.locatiomWeather != null) {
      forecastObject = Future.value(widget.locatiomWeather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Weather Forecast'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              setState(() {
                forecastObject = WeatherApi().fetchWeatherForecast();
              });
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.location_city),
              onPressed: () async {
                var tappedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return CityScreen();
                }));
                if (tappedName != null) {
                  setState(() {
                    _cityName = tappedName;
                    forecastObject = WeatherApi().fetchWeatherForecast(
                        cityName: _cityName, isCity: true);
                  });
                }
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              child: FutureBuilder<WeatherForecast>(
                future: forecastObject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(height: 50.0),
                        CityView(snapshot: snapshot),
                        SizedBox(height: 50.0),
                        TempView(snapshot: snapshot),
                        SizedBox(height: 50.0),
                        DetailView(snapshot: snapshot),
                        SizedBox(height: 50.0),
                        BottomListView(snapshot: snapshot),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        'City not found\nPlease, enter correct city',
                        style: TextStyle(fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
