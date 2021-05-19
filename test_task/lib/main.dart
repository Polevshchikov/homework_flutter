import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_task/components/LoginScreen/LoginScreen.dart';
import 'package:test_task/theme/ColorPalette.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    //Вертикальная ориентация экрана
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        primarySwatch: colorCursorActiveForm,
        primaryColor: colorTextActiveForm,
      ),
      home: LoginScreen(),
    );
  }
}
