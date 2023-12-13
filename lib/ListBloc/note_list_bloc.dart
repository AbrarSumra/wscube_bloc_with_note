import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_bloc_with_note/AppDataBase/app_db.dart';
import 'package:wscube_bloc_with_note/ListBloc/note_list_event.dart';
import 'package:wscube_bloc_with_note/ListBloc/note_list_state.dart';
import 'package:wscube_bloc_with_note/Model/note_model.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  AppDataBase db;
  ListBloc({required this.db}) : super(NoteDbInitial()) {
    /// Add Note
    on<AddNote>((event, emit) async {
      emit(NoteDbLoading());
      var check = await db.addNote(event.newNote);
      if (check) {
        var listNote = await db.fetchNote();
        emit(NoteDbLoaded(allNote: listNote));
      } else {
        emit(NoteDbError(errorMsg: "Note not added!!!"));
      }
    });

    ///Fetch Note
    on<FetchNote>((event, emit) async {
      emit(NoteDbLoading());
      var listNote = await db.fetchNote();
      emit(NoteDbLoaded(allNote: listNote));
    });

    /// Update Note
    on<UpdateNote>((event, emit) async {
      emit(NoteDbLoading());
      db.updateNote(event.updateNote);

      List<NoteModel> listNote = await db.fetchNote();
      emit(NoteDbLoaded(allNote: listNote));
    });

    /// Delete Note
    on<DeleteNote>((event, emit) async {
      emit(NoteDbLoading());
      var check = await db.deleteNote(event.index);
      if (check) {
        List<NoteModel> listNote = await db.fetchNote();
        emit(NoteDbLoaded(allNote: listNote));
      } else {
        emit(NoteDbError(errorMsg: "Note not added!!!"));
      }
    });
  }
}

/*class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListState(mData: [])) {
    /// Add Note
    on<AddNote>((event, emit) {
      var currList = state.mData;
      currList.add(event.newNote);
      emit(ListState(mData: currList));
    });

    /// Fetch Note
    on<FetchNote>((event, emit) {
      var currList = state.mData;
      emit(ListState(mData: currList));
    });

    /// Delete Note
    on<DeleteNote>((event, emit) {
      var currList = state.mData;
      currList.removeAt(event.index);
      emit(ListState(mData: currList));
    });

    /// Update Note
    on<UpdateNote>((event, emit) {
      var currList = state.mData;
      currList[event.index] = event.updateNote;
      emit(ListState(mData: currList));
    });
  }
}*/
