import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:working_calendar/models/data_entity.dart';

//сайт запроса http://xmlcalendar.ru/
//http://xmlcalendar.ru/data/ru/2013/calendar.json

class DataProvider {
  Future<List<Months>> getData(int queryYear) async {
    print('object');
    final responce = await http.get(
        Uri.parse('http://xmlcalendar.ru/data/ru/$queryYear/calendar.json'));
    print(responce.body);
    if (responce.statusCode == 200) {
      final DataEntity dataEntity =
          DataEntity.fromJson(json.decode(responce.body));

      return dataEntity.months;
    } else {
      throw Exception('Error loading data');
    }
  }
}
