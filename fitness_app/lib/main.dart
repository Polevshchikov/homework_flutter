import 'package:fitness_app/introductionScreen.dart';
import 'package:fitness_app/res/myColors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: MyColor.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: IntroductionScreen(),
    );
  }
}
