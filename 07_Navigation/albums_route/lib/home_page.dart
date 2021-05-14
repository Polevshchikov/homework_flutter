import 'dart:convert';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _selectedHome = false;
  bool _selectedAlbums = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString("assets/artists.json"),
          builder: (context, snapshot) {
            var artist = json.decode(snapshot.data.toString());

            return SafeArea(
              child: Column(
                children: <Widget>[
                  ListTile(
                    hoverColor: Colors.blue,
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    selected: _selectedHome,
                    onTap: () {
                      setState(() {
                        _selectedAlbums = false;
                        _selectedHome = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('Albums'),
                    selected: _selectedAlbums,
                    onTap: () {
                      setState(() {
                        _selectedHome = false;
                        _selectedAlbums = true;
                      });
                      Navigator.of(context).pushNamed(
                        '/albums',
                        arguments: artist,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Text(
          "Home Page",
        ),
      ),
    );
  }
}
