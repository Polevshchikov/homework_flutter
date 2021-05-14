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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> tabBarNav = [
    {'title': 'Home', 'icon': Icon(Icons.home)},
    {'title': 'Chat', 'icon': Icon(Icons.chat)},
    {'title': 'Albums', 'icon': Icon(Icons.album)},
  ];

  TabController _tabController;
  int _currentTabIndex = 0;
  bool _isPaid = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabBarNav.length,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(_tabListenner);
  }

  _tabListenner() {
    setState(() {
      _currentTabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              ),
              ListTile(
                leading: Icon(Icons.home),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Home'),
                onTap: () {
                  print('ON TAP HOME');
                },
                onLongPress: () {
                  print('ON LONG PRESS HOME');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_box),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Profile'),
                onTap: () {
                  print('ON TAP PROFILE');
                },
                onLongPress: () {
                  print('ON LONG PRESS PROFILE');
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Images'),
                onTap: () {
                  print('ON TAP IMAGES');
                },
                onLongPress: () {
                  print('ON LONG PRESS IMAGES');
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          print('ВЫХОД');
                        },
                        child: Text('Выход'),
                      ),
                      RaisedButton(
                        onPressed: () {
                          print('РЕГИСТРАЦИЯ');
                        },
                        child: Text('Регистрация'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage('https://picsum.photos/300/500'),
              ),
              Text('Иванов И.И.'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Center(
              child: _isPaid ? Text('Заказ оплачен') : null,
            ),
          ),
          Container(
            color: Colors.amberAccent,
          ),
          Container(
            color: Colors.greenAccent,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _tabController.index = index;
            _currentTabIndex = index;
          });
        },
        currentIndex: _currentTabIndex,
        items: tabBarNav
            .map(
              (item) => BottomNavigationBarItem(
                icon: item['icon'],
                label: item['title'],
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.payment),
                      title: Text('Сумма'),
                      trailing: Text('200 руб'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          _isPaid = true;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Оплатить'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
