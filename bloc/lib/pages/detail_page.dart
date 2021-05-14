import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatelessWidget {
  final String breed;
  const DetailPage({Key key, this.breed}) : super(key: key);

  Future<List<String>> getDogsImg(String breed) async {
    final responceImg = await http
        .get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random/10'));

    if (responceImg.statusCode == 200) {
      var dogsImgJson = json.decode(responceImg.body)['message'];

      List<String> dogImg = dogsImgJson != null ? List.from(dogsImgJson) : null;

      return dogImg;
    } else {
      throw Exception('Error loading dog image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(breed),
        ),
        body: FutureBuilder(
            future: getDogsImg(breed),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Не удалось получить данные',
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.all(10.0),
                            child: Image.network(
                              '${snapshot.data[index]}',
                              fit: BoxFit.cover,
                            ),
                          ));
                default:
                  return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
