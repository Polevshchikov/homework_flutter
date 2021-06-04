import 'package:flutter/material.dart';

Widget promptRemove(
    {required Function callback, required BuildContext context}) {
  return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Удалить заметку?',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Нет',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                callback();
              },
              child: Text(
                'Да',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ]);
}
