import 'package:flutter/material.dart';

Widget textServisHotel(String anObject, List<String> value) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          anObject,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Column(
          children: value
              .map((e) => Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(e),
                  )))
              .toList(),
        ),
      ],
    ),
  );
}
