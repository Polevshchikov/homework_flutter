import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/hotel.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/';
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<HotelPreview> hotelPreview;
  bool selectedButton = true;
  bool isLoading = false;
  bool hasError = false;
  Dio _dio = Dio();
  @override
  void initState() {
    super.initState();
    getDataDio();
  }

  getDataDio() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _dio.get('https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301');

      hotelPreview = response.data.map<HotelPreview>((hotel) => HotelPreview.fromJson(hotel)).toList();
    } on DioError catch (e) {
      print(e);
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.format_list_bulleted),
            onPressed: () {
              setState(() {
                selectedButton = true;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.apps),
            onPressed: () {
              setState(() {
                selectedButton = false;
              });
            },
          ),
        ],
      ),
      body: selectedButton
          ? Column(
              children: <Widget>[
                if (hasError)
                  Center(
                    child: Text('Контент временно не доступен'),
                  ),
                if (!isLoading && hasError == false)
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        ...hotelPreview.map((hotel) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Card(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/${hotel.poster}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(hotel.name),
                                        TextButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                          ),
                                          child: Text(
                                            'Подробнее',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed('/about', arguments: hotel.uuid);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
              ],
            )
          : Column(
              children: <Widget>[
                if (hasError)
                  Center(
                    child: Text('Контент временно не доступен'),
                  ),
                if (!isLoading && hasError == false)
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0),
                      children: <Widget>[
                        ...hotelPreview.map((hotel) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/${hotel.poster}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        hotel.name,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight: Radius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(Size.infinite),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed('/about', arguments: hotel.uuid);
                                      },
                                      child: Text(
                                        'Подробно',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
