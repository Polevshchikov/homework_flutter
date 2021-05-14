import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/screens/activeTodo.dart';
import 'package:todo_app/screens/completTodo.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool colorChange = false;
  final List<String> nav = ['Список задач', 'Выполненные'];
  List<Todo> _searchTodo = [];
  TextEditingController textActiveController = TextEditingController();
  TextEditingController textCompletController = TextEditingController();

  Widget activeAppBar(TodoProvider todoProvider) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            controller: textActiveController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              hintText: 'Добавить задачу',
              hintStyle: TextStyle(
                color: Colors.white38,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              setState(() {
                if (textActiveController.text != '') {
                  todoProvider.add(Todo(
                    id: UniqueKey(),
                    title: textActiveController.text,
                    isDone: false,
                  ));
                }
                textActiveController.clear();
              });
            },
            child: Text(
              'Добавить',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget completAppBar(TodoProvider todoProvider) {
    return TextField(
      style: TextStyle(
        color: Colors.white,
      ),
      controller: textCompletController,
      onChanged: (String value) {
        onSearchTextChanged(todoProvider, value);
      },
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.blue,
          ),
          onPressed: () {
            textCompletController.clear();
            onSearchTextChanged(todoProvider, '');
          },
        ),
        hintText: 'Поиск',
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        return DefaultTabController(
          length: nav.length,
          child: Scaffold(
            appBar: AppBar(
              title: colorChange == false
                  ? activeAppBar(todoProvider)
                  : completAppBar(todoProvider),
              bottom: TabBar(
                indicatorWeight: 5,
                tabs: nav
                    .map(
                      (item) => Tab(
                        text: item,
                      ),
                    )
                    .toList(),
                onTap: (int index) {
                  setState(() {
                    index == 0 ? colorChange = false : colorChange = true;
                    // if (textEditingController != null)
                    // {
                    //   textActiveController.clear();
                    //   textCompletController.clear();
                    // }
                  });
                },
              ),
              backgroundColor: !colorChange ? Colors.black : Colors.indigo,
            ),
            body: TabBarView(
              children: [
                ActiveTodoPage(),
                CompletTodoPage(
                  searchTodo: _searchTodo,
                  textEditingController: textCompletController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onSearchTextChanged(TodoProvider todoProvider, String text) async {
    _searchTodo.clear();
    if (text.isEmpty) {
      textCompletController.text = '';
    }

    todoProvider.todo.forEach((todo) {
      if (todo.title.contains(text)) _searchTodo.add(todo);
    });

    setState(() {});
  }
}
