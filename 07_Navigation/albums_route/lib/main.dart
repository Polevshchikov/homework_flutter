import 'package:flutter/material.dart';

import 'about_page.dart';
import 'albums_page.dart';
import 'home_page.dart';
import 'not_foud.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return NotFound();
          },
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomePage.routeName:
            return MaterialPageRoute(builder: (BuildContext context) {
              return HomePage();
            });
          case AboutPage.routeName:
            return MaterialPageRoute(builder: (BuildContext context) {
              ArtistList artistList = settings.arguments;
              return AboutPage(artistList: artistList);
            });
          case AlbumsPage.routeName:
            return MaterialPageRoute(builder: (BuildContext context) {
              var artist = settings.arguments;
              return AlbumsPage(artist: artist);
            });

          default:
            return MaterialPageRoute(builder: (BuildContext context) {
              return NotFound();
            });
        }
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class ArtistList {
  String name;
  String link;
  String about;
  ArtistList({this.name, this.link, this.about});
}
