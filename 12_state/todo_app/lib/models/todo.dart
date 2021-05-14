import 'package:flutter/cupertino.dart';

class Todo {
  final UniqueKey id;
  final String title;
  bool isDone;
  Todo({this.id, this.title, this.isDone});
}
