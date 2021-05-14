import 'package:flutter/material.dart';
import 'main.dart';

class AboutPage extends StatefulWidget {
  static const routeName = '/about';
  final ArtistList artistList;
  AboutPage({Key key, this.artistList}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.artistList.name}'),
      ),
      body: Center(
        child: SafeArea(
          child: ListView(
            children: [
              Text('${widget.artistList.about}'),
            ],
          ),
        ),
      ),
    );
  }
}
