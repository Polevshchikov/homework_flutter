import 'package:flutter/material.dart';
import 'package:hotels/views/about_view.dart';
import 'package:hotels/views/error_view.dart';
import 'package:hotels/views/home_view.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return ErrorView();
          },
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomeView.routeName:
            return MaterialPageRoute(builder: (BuildContext context) {
              return HomeView();
            });
          case AboutView.routeName:
            return MaterialPageRoute(builder: (BuildContext context) {
              String uuidData = settings.arguments;

              return AboutView(uuidData: uuidData);
            });

          default:
            return MaterialPageRoute(builder: (BuildContext context) {
              return ErrorView();
            });
        }
      },
    );
  }
}
