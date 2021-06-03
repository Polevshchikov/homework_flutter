import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_test/models/note.dart';
import 'package:redux_test/pages/note_page.dart';
import 'package:redux_test/redux/actions.dart';
import 'package:redux_test/widgets/note_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Store<List<Note>> store = StoreProvider.of<List<Note>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Заметки'),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          store.dispatch(AddNoteAction());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NotePage(
                      note: store.state.last,
                      item: store.state.length - 1,
                    )),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StoreConnector<List<Note>, List<Note>>(
        converter: (store) => store.state,
        builder: (context, list) {
          if (list.isEmpty) {
            return Center(
              child: Container(
                child: Text('Заметок нет :('),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, position) {
                  return NoteListItem(
                    note: list[position],
                    position: position,
                  );
                });
          }
        },
      ),
    );
  }
}
