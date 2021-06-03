import 'package:redux_test/models/note.dart';
import 'package:redux_test/redux/actions.dart';

List<Note> appReducers(List<Note> items, dynamic action) {
  if (action is AddNoteAction) {
    return addItem(items, action);
  } else if (action is RemoveNoteAction) {
    return removeItem(items, action);
  } else if (action is EditNoteAction) {
    return editItem(items, action);
  }
  return items;
}

List<Note> addItem(List<Note> items, AddNoteAction action) {
  return List.from(items)..add(Note(title: '', subtitle: ''));
}

List<Note> removeItem(List<Note> items, RemoveNoteAction action) {
  return List.from(items)..removeAt(action.item);
}

List<Note> editItem(List<Note> items, EditNoteAction action) {
  items[action.item] = Note(title: action.title, subtitle: action.subtitle);
  return items;
}
