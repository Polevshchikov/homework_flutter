import 'package:flutter/material.dart';
import 'package:test_task/Screens/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SF-Pro',
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
