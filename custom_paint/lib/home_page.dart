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

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  List<num> data = [];
  List<Color> colorList = [];
  num dataValue = 0;
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
                    controller: _controller,
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
                      setState(() {
                        data.add(dataValue);
                        colorList.add(Color(
                                (math.Random().nextDouble() * 0xFFFFFFFFF)
                                    .toInt())
                            .withOpacity(1.0));
                        _controller.clear();
                        dataValue = 0;
                      });
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
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: CirclePainter(numList: data, colorList: colorList),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
