class AddNoteAction {}

class RemoveNoteAction {
  final int item;

  RemoveNoteAction(this.item);
}

class EditNoteAction {
  final int item;
  final String title;
  final String subtitle;

  EditNoteAction(this.item, this.title, this.subtitle);
}
