import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_test/models/note.dart';
import 'package:redux_test/pages/home_page.dart';
import 'package:redux_test/redux/actions.dart';

class NotePage extends StatefulWidget {
  final int item;
  final Note note;
  const NotePage({Key? key, required this.note, required this.item})
      : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _focusTitle;
  late FocusNode _focusSubtitle;
  late Store<List<Note>> store;

  @override
  void initState() {
    if (widget.note.title != '' || widget.note.subtitle != '') {
      _titleController.text = widget.note.title;
      _subtitleController.text = widget.note.subtitle;
    }
    _focusTitle = FocusNode();
    _focusSubtitle = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusTitle.dispose();
    _focusSubtitle.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    store = StoreProvider.of<List<Note>>(context);
    super.didChangeDependencies();
  }

  promptRemove() {
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
                  store.dispatch(RemoveNoteAction(widget.item));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заметка'),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            if (_titleController.value.text == '' &&
                _subtitleController.value.text == '') {
              store.dispatch(RemoveNoteAction(widget.item));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            } else {
              store.dispatch(EditNoteAction(
                widget.item,
                _titleController.value.text,
                _subtitleController.value.text,
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete note',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => promptRemove());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 22),
                autofocus: true,
                controller: _titleController,
                focusNode: _focusTitle,
                decoration: InputDecoration(
                  hintText: 'Заголовок',
                  hintStyle: TextStyle(fontSize: 22),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                onFieldSubmitted: (term) {
                  _focusTitle.unfocus();

                  FocusScope.of(context).requestFocus(_focusSubtitle);
                },
              ),
              TextFormField(
                controller: _subtitleController,
                focusNode: _focusSubtitle,
                decoration: InputDecoration(
                  hintText: 'Описание',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                onFieldSubmitted: (term) {
                  _focusSubtitle.unfocus();
                  // FocusScope.of(context).requestFocus(_focusSubtitle);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
