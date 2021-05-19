import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_task/services/user/models/user.dart';

class UserProvider {
  Future<List<User>> getUser() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (responce.statusCode == 200) {
      final List<dynamic> userJson = json.decode(responce.body);

      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}
