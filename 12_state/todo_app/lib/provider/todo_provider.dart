import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todo = [];

  List<Todo> get todo => _todo;

  void add(Todo newTodo) {
    _todo.add(newTodo);
    notifyListeners();
  }

  done(UniqueKey id) {
    Todo findTodo = _todo.firstWhere((element) => element.id == id);
    findTodo.isDone = !findTodo.isDone;
    notifyListeners();
  }

  void delete(Todo newTodo) {
    _todo.remove(newTodo);
    notifyListeners();
  }
}
