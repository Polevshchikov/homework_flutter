import 'dart:convert';
import 'dart:math';

import 'package:di/model/cat.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<String> listCatFactors = [];
const String keyListPref = 'keyCatFact';

void initializerList() {
  _generateList();
}

Future<String> _fetchFactory() async {
  final response =
      await http.get(Uri.parse('https://cat-fact.herokuapp.com/facts/random'));

  if (response.statusCode == 200) {
    return Cat.fromJson(jsonDecode(response.body)).text;
  } else {
    throw Exception('Нет связи с сервером');
  }
}

// Функция для генерации списка
Future<Null> _generateList() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var list = _getStringListPref(keyListPref, _prefs);
  if (list == null) {
    for (var i = 0; i < 5; i++) {
      listCatFactors
          .add(await _fetchFactory().then((textFactor) => textFactor));
    }

    await _setStringListPref(listCatFactors, _prefs);
  }
}

//запись фактов о кошках в хранилище
Future<Null> _setStringListPref(
    List<String> listCatFactors, SharedPreferences _prefs) async {
  await _prefs.setStringList(keyListPref, listCatFactors);
}

//чтение фактов о кошках из хранилища
List<String> _getStringListPref(String key, SharedPreferences _prefs) =>
    _prefs.getStringList(key);

Future<Cat> mockClientCat() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var listFactors = _getStringListPref(keyListPref, _prefs);
  return Cat(
    text: listFactors[Random().nextInt(5)],
    repository: 'local repository',
  );
}
