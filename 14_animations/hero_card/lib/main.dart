import 'package:flutter/material.dart';
import 'package:hero_card/space.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(title: 'Animations'),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(widget.title),
      ),
      body: ListView(
        children: spaces
            .map(
              (space) => GestureDetector(
                child: Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 8.0,
                  ),
                  elevation: 6.0,
                  clipBehavior: Clip.antiAlias,
                  color: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Hero(
                            tag: space.id,
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              child: Image.asset(
                                space.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Hero(
                            tag: '${space.id}-title',
                            child: Container(
                              height: 70,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 40.0,
                                  top: 30.0,
                                ),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    space.description,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 50.0,
                        right: 15.0,
                        child: Hero(
                          tag: '${space.id}-button',
                          child: Material(
                            child: Container(
                              height: 40,
                              width: 40,
                              color: Colors.yellow,
                              child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailView(data: space),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({Key key, this.data}) : super(key: key);
  final Space data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Hero(
                  tag: data.id,
                  child: Container(
                    width: double.infinity,
                    child: Image.asset(
                      data.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: -20.0,
                  child: Hero(
                    tag: '${data.id}-button',
                    child: Material(
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: '${data.id}-title',
              child: Material(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(data.description),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
