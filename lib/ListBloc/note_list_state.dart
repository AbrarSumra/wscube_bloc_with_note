import 'package:wscube_bloc_with_note/Model/note_model.dart';

abstract class ListState {}

class NoteDbInitial extends ListState {}

class NoteDbLoading extends ListState {}

class NoteDbLoaded extends ListState {
  NoteDbLoaded({required this.allNote});

  List<NoteModel> allNote;
}

class NoteDbError extends ListState {
  NoteDbError({required this.errorMsg});

  String errorMsg;
}
