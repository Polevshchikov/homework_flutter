import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_test/models/note.dart';
import 'package:redux_test/pages/note_page.dart';
import 'package:redux_test/redux/actions.dart';
import 'package:redux_test/widgets/prompt_remove.dart';

class NoteListItem extends StatelessWidget {
  final Note note;
  final int position;
  const NoteListItem({Key? key, required this.position, required this.note})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<List<Note>> store = StoreProvider.of<List<Note>>(context);
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NotePage(
                      note: note,
                      item: position,
                    )),
          );
        },
        title: Text(note.title),
        subtitle: Text(note.subtitle),
        trailing: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => promptRemove(
                  callback: () {
                    store.dispatch(RemoveNoteAction(position));
                    Navigator.of(context).pop();
                  },
                  context: context),
            );
          },
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
