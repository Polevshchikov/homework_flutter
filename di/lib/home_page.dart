import 'package:di/model/cat.dart';
import 'package:di/service/connect_cat.dart';
import 'package:di/service/mock_repository.dart';

import 'package:flutter/material.dart';

import 'package:injector/injector.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Cat catFactory;

  Future<Cat> loadCatFactory() async {
    Cat _catFactory;

    final injector = Injector.appInstance;
    final getCat = injector.get<GetCat>();

    _catFactory = await getCat.getData();

    setState(() {
      catFactory = _catFactory;
    });
    return catFactory;
  }

  @override
  void initState() {
    initializerList();
    loadCatFactory();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Facts'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              catFactory != null
                  ? Column(
                      children: [
                        Text('Данные получены из ${catFactory.repository}'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(catFactory.text),
                      ],
                    )
                  : CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  loadCatFactory();
                },
                child: Text(
                  'Show a new one',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
