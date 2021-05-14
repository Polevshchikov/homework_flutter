import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  static const routeName = '/error';
  ErrorView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Контент временно не доступен'),
    );
  }
}
