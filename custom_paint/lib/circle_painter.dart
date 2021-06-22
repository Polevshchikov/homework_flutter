import 'dart:math' as math;

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  CirclePainter({
    required this.numList,
    required this.colorList,
  });
  double _degToRad(double deg) => deg * (math.pi / 180.0);
  final List<num> numList;
  final List<Color> colorList;

  final _paint = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    num sum = numList.fold(0, (p, c) => p + c);
    double radiansStart = 0;
    double radiansSweep = 0;
    final Rect arcRect = Rect.fromLTWH(0, 0, size.width, size.height);

    for (int i = 0; i < numList.length; i++) {
      _paint.color = colorList[i];
      double angle = 360.0 * numList[i].toDouble() / sum;
      radiansSweep = _degToRad(angle);
      canvas.drawArc(arcRect, radiansStart, radiansSweep, true, _paint);
      radiansStart = radiansStart + radiansSweep;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
