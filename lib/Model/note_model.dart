import 'package:wscube_bloc_with_note/AppDataBase/app_db.dart';

class NoteModel {
  NoteModel({
    required this.userId,
    required this.noteId,
    required this.noteTitle,
    required this.noteDesc,
  });

  int userId;
  int noteId;
  String noteTitle;
  String noteDesc;

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      userId: map[AppDataBase.COLUMN_USER_ID],
      noteId: map[AppDataBase.COLUMN_NOTE_ID],
      noteTitle: map[AppDataBase.COLUMN_NOTE_TITLE],
      noteDesc: map[AppDataBase.COLUMN_NOTE_DESC],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBase.COLUMN_USER_ID: userId,
      AppDataBase.COLUMN_NOTE_TITLE: noteTitle,
      AppDataBase.COLUMN_NOTE_DESC: noteDesc,
    };
  }
}
