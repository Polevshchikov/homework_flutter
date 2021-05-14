import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/domain/event.dart';
import 'package:firebase_project/services/auth.dart';

import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  static const routName = '/todo';
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _filedTitleCtr = TextEditingController();
  TextEditingController _filedDescrCtr = TextEditingController();
  AuthService _authService = AuthService();
  User user;
  List<Event> _todoItems = [];

  final dbRef = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getDocs();
  }

  Future getDocs() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("todos").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var elements = querySnapshot.docs[i];

      setState(() {
        _todoItems.add(
          Event(
            title: elements.data()['title'],
            description: elements.data()['description'],
            isDone: elements.data()['isDone'],
            crossOut: elements.data()['crossOut'],
          ),
        );
      });
    }
  }

  _saveToDo() async {
    await dbRef.collection('todos').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    _todoItems.forEach((element) async {
      if (element.isDone == true) {
        await dbRef.collection('todos').add({
          'title': element.title,
          'description': element.description,
          'isDone': element.isDone,
          'crossOut': element.crossOut,
        });
      }
    });
  }

  void _addTodoItem() {
    String task = _filedTitleCtr.text;
    String descr = _filedDescrCtr.text;
    _filedTitleCtr.clear();
    _filedDescrCtr.clear();
    setState(() {
      _todoItems.add(
        Event(
          title: task.length != 0 ? task : '...',
          description: descr.length != 0 ? descr : '...',
          isDone: false,
          crossOut: false,
        ),
      );
    });
  }

  void _editTodoItem(int index) {
    String task;
    String descr;
    task = _filedTitleCtr.text;
    descr = _filedDescrCtr.text;
    _filedTitleCtr.clear();
    _filedDescrCtr.clear();
    setState(() {
      _todoItems[index].title = task.length != 0 ? task : '...';
      _todoItems[index].description = descr.length != 0 ? descr : '...';
      _todoItems[index].isDone = false;
      _todoItems[index].crossOut = false;
    });
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Вы действительно хотите удалить запись?'),
              actions: <Widget>[
                TextButton(
                    child: Text('Нет'),
                    onPressed: () => Navigator.of(context).pop()),
                TextButton(
                    child: Text('Да'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  Widget _eventCard(Event _todoItems, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: _todoItems.crossOut == false
                      ? Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.check_box_outlined,
                          color: Colors.black,
                        ),
                  onPressed: () {
                    setState(() {
                      !_todoItems.crossOut
                          ? _todoItems.crossOut = true
                          : _todoItems.crossOut = false;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _pushEditTodoScreen(index);
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () {
                setState(() {
                  !_todoItems.isDone
                      ? _todoItems.isDone = true
                      : _todoItems.isDone = false;
                });
              },
              onLongPress: () {
                _pushEditTodoScreen(index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _todoItems.title,
                    style: _todoItems.crossOut == true
                        ? TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                          )
                        : TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    _todoItems.description,
                    style: _todoItems.crossOut == true
                        ? TextStyle(
                            decoration: TextDecoration.lineThrough,
                          )
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'isDone: ${_todoItems.isDone.toString()}',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                onPressed: () => _promptRemoveTodoItem(index)),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoItem(Event _todoItems, int index) {
    return Card(
      color: _todoItems.isDone == true
          ? Colors.lightGreenAccent[100]
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: BorderSide(
          width: 3,
          color: Colors.black,
        ),
      ),
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: _eventCard(_todoItems, index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.supervisor_account),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
          child: Text(
            'ToDo app',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _authService.signOut();
                setState(() {
                  user = null;
                });
              }),
        ],
      ),
      body: _buildTodoList(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                width: 2,
                color: Colors.black,
              ),
            ),
            tooltip: 'Сохранить выделенное в базу',
            child: Icon(
              Icons.save,
              color: Colors.black,
            ),
            onPressed: () {
              _saveToDo();
            },
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: _pushAddTodoScreen,
            tooltip: 'Добавить запись',
            child: Icon(Icons.add),
            heroTag: null,
          )
        ],
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text('Добавить запись')),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      controller: _filedTitleCtr,
                      decoration: InputDecoration(
                          hintText: 'Добавить заголовок...',
                          contentPadding: const EdgeInsets.all(16.0)),
                    ),
                    TextField(
                      maxLines: 3,
                      controller: _filedDescrCtr,
                      decoration: InputDecoration(
                          hintText: 'Добавить текст...',
                          contentPadding: const EdgeInsets.all(16.0)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _addTodoItem();
                        Navigator.of(context).pop();
                      },
                      child: Text('Сохранить'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _pushEditTodoScreen(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text('Редактировать запись')),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      controller: _filedTitleCtr,
                      decoration: InputDecoration(
                          hintText: 'Изменить заголовок...',
                          contentPadding: const EdgeInsets.all(16.0)),
                    ),
                    TextField(
                      maxLines: 3,
                      controller: _filedDescrCtr,
                      decoration: InputDecoration(
                          hintText: 'Изменить текст...',
                          contentPadding: const EdgeInsets.all(16.0)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _editTodoItem(index);
                        Navigator.of(context).pop();
                      },
                      child: Text('Сохранить'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
