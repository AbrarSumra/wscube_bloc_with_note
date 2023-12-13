import 'package:wscube_bloc_with_note/Model/note_model.dart';

abstract class ListEvent {}

class AddNote extends ListEvent {
  AddNote({required this.newNote});

  NoteModel newNote;
}

class FetchNote extends ListEvent {}

class UpdateNote extends ListEvent {
  UpdateNote({
    required this.updateNote,
    required this.index,
  });

  NoteModel updateNote;
  int index;
}

class DeleteNote extends ListEvent {
  DeleteNote({required this.index});

  int index;
}
