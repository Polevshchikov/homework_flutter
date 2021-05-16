import 'dart:convert';

import 'package:di/model/cat.dart';
import 'package:http/http.dart' as http;

Future<Cat> fetchCatFactory() async {
  final response =
      await http.get(Uri.parse('https://cat-fact.herokuapp.com/facts/random'));

  if (response.statusCode == 200) {
    Cat catFactory = Cat.fromJson(jsonDecode(response.body));
    return catFactory;
  } else {
    print('Нет связи с сервером');
    throw Exception('Нет связи с сервером');
  }
}
