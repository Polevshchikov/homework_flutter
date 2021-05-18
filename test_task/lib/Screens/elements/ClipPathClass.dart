import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    //угол отреза составляет 10 градусов
    path.lineTo(
        size.width, size.height - size.width * math.tan(10 * math.pi / 180));

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
