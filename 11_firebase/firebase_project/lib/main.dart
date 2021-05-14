import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/views/login_view.dart';
import 'package:firebase_project/views/profile_view.dart';
import 'package:firebase_project/views/todo_view.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case LoginView.routName:
            return MaterialPageRoute(builder: (BuildContext context) {
              return LoginView();
            });
          case ProfileView.routName:
            return MaterialPageRoute(builder: (BuildContext context) {
              return ProfileView();
            });
          case TodoList.routName:
            return MaterialPageRoute(builder: (BuildContext context) {
              return TodoList();
            });

          default:
            return MaterialPageRoute(builder: (BuildContext context) {
              return LoginView();
            });
        }
      },
    );
  }
}
