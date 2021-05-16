import 'package:di/home_page.dart';
import 'package:di/service/connect_cat.dart';

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  final injector = Injector.appInstance;

  injector.registerDependency<Connectivity>(() {
    return Connectivity();
  });

  injector.registerDependency<GetCat>(() {
    final connectivity = injector.get<Connectivity>();

    return GetCat(connectivity: connectivity);
  });

  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}
