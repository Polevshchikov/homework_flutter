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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://picsum.photos/800/400',
                fit: BoxFit.cover,
              ),
              title: Text('Page title'),
            ),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Text(
                  '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dictum varius duis at consectetur lorem donec massa. Imperdiet proin fermentum leo vel orci. Quis imperdiet massa tincidunt nunc pulvinar sapien et ligula. Turpis cursus in hac habitasse platea dictumst quisque. Tellus cras adipiscing enim eu turpis egestas pretium. Enim ut sem viverra aliquet eget sit amet. Varius quam quisque id diam vel quam elementum pulvinar etiam. Etiam non quam lacus suspendisse faucibus. Velit euismod in pellentesque massa placerat. Amet consectetur adipiscing elit duis tristique. Turpis tincidunt id aliquet risus feugiat in. Bibendum arcu vitae elementum curabitur vitae nunc. Massa ultricies mi quis hendrerit dolor magna eget est lorem. Tortor id aliquet lectus proin nibh nisl condimentum id. Morbi tristique senectus et netus et. Vitae congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque. Id ornare arcu odio ut sem nulla. Lorem donec massa sapien faucibus et. Lorem donec massa sapien faucibus.

Nullam eget felis eget nunc lobortis mattis. Ac tincidunt vitae semper quis lectus nulla at volutpat diam. Nec dui nunc mattis enim ut. Dapibus ultrices in iaculis nunc sed. Ridiculus mus mauris vitae ultricies. Neque convallis a cras semper auctor neque vitae tempus quam. Consectetur lorem donec massa sapien faucibus et molestie ac. Consectetur adipiscing elit ut aliquam purus sit amet luctus venenatis. Egestas dui id ornare arcu odio ut sem nulla. Et molestie ac feugiat sed lectus vestibulum mattis ullamcorper. Non diam phasellus vestibulum lorem sed risus. Faucibus turpis in eu mi bibendum neque egestas. Tellus orci ac auctor augue mauris augue neque gravida in. Semper quis lectus nulla at. Quis auctor elit sed vulputate mi sit amet. Amet mauris commodo quis imperdiet massa. Dis parturient montes nascetur ridiculus mus mauris vitae ultricies leo. Interdum varius sit amet mattis vulputate enim. A cras semper auctor neque vitae. Blandit turpis cursus in hac habitasse platea dictumst quisque sagittis.

Fringilla urna porttitor rhoncus dolor purus non. Aliquam sem fringilla ut morbi tincidunt augue. Non arcu risus quis varius quam quisque id diam. Vivamus at augue eget arcu dictum. Enim nulla aliquet porttitor lacus luctus accumsan. Porttitor eget dolor morbi non arcu risus quis varius quam. Iaculis urna id volutpat lacus laoreet non curabitur gravida arcu. Eget est lorem ipsum dolor sit amet consectetur adipiscing elit. Dui sapien eget mi proin sed libero enim sed. Elementum integer enim neque volutpat ac. Malesuada fames ac turpis egestas maecenas pharetra. Tristique risus nec feugiat in fermentum posuere. Purus gravida quis blandit turpis cursus in hac habitasse. Ultricies leo integer malesuada nunc vel risus commodo viverra.

Velit egestas dui id ornare arcu odio ut sem nulla. Tortor posuere ac ut consequat. Dictumst quisque sagittis purus sit. Egestas sed tempus urna et pharetra pharetra massa massa ultricies. Nulla pellentesque dignissim enim sit amet venenatis urna cursus eget. Non pulvinar neque laoreet suspendisse interdum. Dictum fusce ut placerat orci nulla pellentesque dignissim. Nulla pellentesque dignissim enim sit amet venenatis urna cursus. Hac habitasse platea dictumst quisque sagittis purus sit amet. Augue lacus viverra vitae congue eu consequat. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo. Vitae justo eget magna fermentum iaculis. Tellus at urna condimentum mattis pellentesque id nibh. Aliquam etiam erat velit scelerisque in dictum non consectetur. Sit amet nisl purus in mollis nunc.

Arcu dictum varius duis at. Tortor pretium viverra suspendisse potenti nullam ac tortor vitae purus. Neque laoreet suspendisse interdum consectetur libero id faucibus nisl. Volutpat consequat mauris nunc congue nisi. Pharetra pharetra massa massa ultricies mi quis hendrerit. Ac felis donec et odio pellentesque diam. Nunc non blandit massa enim nec dui. Imperdiet nulla malesuada pellentesque elit eget gravida cum. Turpis egestas sed tempus urna et pharetra pharetra. Auctor urna nunc id cursus metus aliquam eleifend mi. In hac habitasse platea dictumst. Est ullamcorper eget nulla facilisi etiam dignissim diam. Ac turpis egestas maecenas pharetra. Diam maecenas sed enim ut sem viverra aliquet eget. Sit amet consectetur adipiscing elit pellentesque habitant. Sed adipiscing diam donec adipiscing tristique. Vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare.'''),
            ),
          ),
        ],
      ),
    );
  }
}
