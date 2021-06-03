import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_test/redux/reducers.dart';
import 'models/note.dart';
import 'pages/home_page.dart';

void main() {
  final store = Store<List<Note>>(appReducers, initialState: <Note>[]);
  runApp(
    StoreProvider(
      store: store,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
