import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> data = List.generate(20, (index) {
    return Card(
      color: Colors.amber,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(''),
          )
        ],
      ),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double _width = constraints.constrainWidth();
          return _width > 500
              ? Column(
                  children: <Widget>[
                    Expanded(
                      child: SafeArea(
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            double _width = constraints.constrainWidth();
                            return _width > 500
                                ? ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) =>
                                        data[index],
                                  )
                                : GridView.count(
                                    scrollDirection: Axis.horizontal,
                                    crossAxisCount: 1,
                                    children: data.map((e) => e).toList(),
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    // SafeArea(
                    //   child: TextField(
                    //       decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Search',
                    //   )),
                    // ),
                    Expanded(
                      flex: 1,
                      child: SafeArea(
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            double _width = constraints.constrainWidth();
                            return _width > 500
                                ? ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) =>
                                        data[index],
                                  )
                                : GridView.count(
                                    scrollDirection: Axis.horizontal,
                                    crossAxisCount: 1,
                                    children: data.map((e) => e).toList(),
                                  );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
