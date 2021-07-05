import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'circle_painter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controllerText = TextEditingController();
  List<num> data = [];
  List<Color> colorList = [];
  num? dataValue;
  late Animation<double> animation;
  late AnimationController controller;
  double _animFraction = 0.0;
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1300),
      vsync: this,
    );

    controller.forward();
    animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut))
          ..addListener(() {
            setState(() {
              _animFraction = animation.value;
            });
          });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ввод числа',
                    ),
                    controller: _controllerText,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    onChanged: (String value) {
                      if (value != '') {
                        setState(() {
                          dataValue = num.parse(value);
                        });
                      }
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (dataValue != null) {
                        setState(() {
                          data.add(dataValue!);
                          colorList.add(Color(
                                  (math.Random().nextDouble() * 0xFFFFFFFFF)
                                      .toInt())
                              .withOpacity(1.0));
                          _controllerText.clear();
                          dataValue = null;
                          startAnimation = true;
                        });
                      }
                      controller.reset();
                      controller.forward();
                    },
                    child: Text('Добавить')),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                  'PieChart( data:${data.map((e) => e).toList().toString()})'),
            ),
            SizedBox(
              height: 30,
            ),
            AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animFraction,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CustomPaint(
                        painter:
                            CirclePainter(numList: data, colorList: colorList),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
