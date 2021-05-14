import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';

class ActiveTodoPage extends StatefulWidget {
  const ActiveTodoPage({Key key}) : super(key: key);

  @override
  _ActiveTodoPageState createState() => _ActiveTodoPageState();
}

class _ActiveTodoPageState extends State<ActiveTodoPage>
    with AutomaticKeepAliveClientMixin<ActiveTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, vm, child) {
        return ListView(
          children: vm.todo
              .map(
                (todo) => CheckboxListTile(
                  activeColor: Colors.blue,
                  value: todo.isDone,
                  onChanged: (v) {
                    vm.done(todo.id);
                  },
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
