import 'dart:convert';

import 'package:bloc_network_example/models/dog.dart';
import 'package:http/http.dart' as http;

class DogProvider {
  Future<List<Dogs>> getDogs() async {
    final responce =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));

    if (responce.statusCode == 200) {
      final ResponceDogs responceDogs =
          ResponceDogs.fromJson(json.decode(responce.body));

      return responceDogs.message
          .map((key, value) => MapEntry(
                key,
                Dogs(breed: key, subBreeds: value),
              ))
          .values
          .toList();
    } else {
      throw Exception('Error loading dogs');
    }
  }
}
