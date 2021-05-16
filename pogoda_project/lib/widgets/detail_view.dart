import 'package:flutter/material.dart';
import 'package:pogoda_project/models/weather_forecast_deily.dart';
import 'package:pogoda_project/utilities/forecast_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const DetailView({Key key, this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data.list;
    var pressure = forecastList[0].pressure * 0.750062;
    var humidity = forecastList[0].humidity;
    var wind = forecastList[0].speed;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Util.getItem(
            FontAwesomeIcons.thermometerThreeQuarters,
            pressure.round(),
            'mm Hg',
          ),
          Util.getItem(
            FontAwesomeIcons.cloudRain,
            humidity,
            '%',
          ),
          Util.getItem(
            FontAwesomeIcons.wind,
            wind.toInt(),
            'm/s',
          ),
        ],
      ),
    );
  }
}
