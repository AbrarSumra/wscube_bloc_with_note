import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_bloc_with_note/ListBloc/list_event.dart';
import 'package:wscube_bloc_with_note/ListBloc/list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListState(mData: [])) {
    /// Add Note
    on<AddNote>((event, emit) {
      var currList = state.mData;
      currList.add(event.newNote);
      emit(ListState(mData: currList));
    });

    ///Fetch Note
    on<FetchNote>((event, emit) {
      var currList = state.mData;
      emit(ListState(mData: currList));
    });

    /// Update Note
    on<UpdateNote>((event, emit) {
      var currList = state.mData;
      currList[event.index] = event.updateNote;
      emit(ListState(mData: currList));
    });

    /// Delete Note
    on<DeleteNote>((event, emit) {
      var currList = state.mData;
      currList.removeAt(event.index);
      emit(ListState(mData: currList));
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
