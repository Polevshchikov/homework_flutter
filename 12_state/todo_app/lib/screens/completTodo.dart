import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/provider/todo_provider.dart';

class CompletTodoPage extends StatefulWidget {
  CompletTodoPage({
    Key key,
    @required this.searchTodo,
    @required this.textEditingController,
  }) : super(key: key);

  List<Todo> searchTodo;
  TextEditingController textEditingController = TextEditingController();
  @override
  _CompletTodoPageState createState() => _CompletTodoPageState();
}

class _CompletTodoPageState extends State<CompletTodoPage>
    with AutomaticKeepAliveClientMixin<CompletTodoPage> {
  List<Todo> _todoIsDone = [];
  List<Todo> _searchTodo = [];
  TextEditingController textSearchController = TextEditingController();

  void _promptRemoveTodo(TodoProvider vm, Todo todo) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Вы уверены что хотите удалить задачу?',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actionsPadding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 1.7),
              actions: <Widget>[
                Column(
                  children: [
                    TextButton(
                        child: Text(
                          'Да',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          vm.delete(todo);
                          Navigator.of(context).pop();
                        }),
                    TextButton(
                        child: Text(
                          'Нет',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop()),
                  ],
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    textSearchController = widget.textEditingController;
    _searchTodo = widget.searchTodo;

    return Consumer<TodoProvider>(
      builder: (context, vm, child) {
        _todoIsDone.clear();
        vm.todo.forEach((todo) {
          if (todo.isDone == true) {
            _todoIsDone.add(todo);
          }
        });

        return ListView(
          children: (textSearchController.text.length != 0)
              ? _searchTodo.map(
                  (todo) {
                    return ListTile(
                      onTap: () {
                        _promptRemoveTodo(vm, todo);
                        _searchTodo.remove(todo);
                      },
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ).toList()
              : _todoIsDone.map(
                  (todo) {
                    return ListTile(
                      onTap: () {
                        _promptRemoveTodo(vm, todo);
                      },
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ).toList(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
