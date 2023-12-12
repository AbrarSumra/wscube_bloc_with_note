abstract class ListEvent {}

class AddNote extends ListEvent {
  AddNote({required this.newNote});

  Map<String, dynamic> newNote;
}

class FetchNote extends ListEvent {}

class UpdateNote extends ListEvent {
  UpdateNote({
    required this.updateNote,
    required this.index,
  });

  Map<String, dynamic> updateNote;
  int index;
}

class DeleteNote extends ListEvent {
  DeleteNote({required this.index});

  int index;
}

/*
abstract class ListEvent {}

class AddNote extends ListEvent {
  AddNote({required this.newNote});

  Map<String, dynamic> newNote;
}

class FetchNote extends ListEvent {}

class UpdateNote extends ListEvent {
  UpdateNote({required this.updateNote, required this.index});

  Map<String, dynamic> updateNote;
  int index;
}

class DeleteNote extends ListEvent {
  DeleteNote({required this.index});

  int index;
}*/
