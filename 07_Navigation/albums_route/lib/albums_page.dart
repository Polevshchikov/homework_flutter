import 'package:flutter/material.dart';
import 'main.dart';

class AlbumsPage extends StatefulWidget {
  static const routeName = '/albums';
  var artist;

  AlbumsPage({Key key, this.artist}) : super(key: key);

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: List.generate(
            7,
            (i) {
              return FlatButton(
                onPressed: () {
                  ArtistList artistList = ArtistList(
                    name: widget.artist[i]["name"],
                    link: widget.artist[i]["link"],
                    about: widget.artist[i]["about"],
                  );
                  Navigator.of(context).pushNamed(
                    '/about',
                    arguments: artistList,
                  );
                },
                child: Text(widget.artist[i]["name"]),
              );
            },
          ),
        ),
      ),
    );
  }
}
