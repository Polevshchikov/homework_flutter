import 'package:flutter/material.dart';

Widget textAdressHotel(String anObject, String value) {
  return Column(
    children: [
      Row(
        children: [
          Text(anObject),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
      SizedBox(
        height: 5.0,
      ),
    ],
  );
}
