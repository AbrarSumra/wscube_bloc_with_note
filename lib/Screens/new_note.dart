import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_bloc_with_note/Constant/text_field.dart';
import 'package:wscube_bloc_with_note/ListBloc/note_list_bloc.dart';
import 'package:wscube_bloc_with_note/ListBloc/note_list_event.dart';
import 'package:wscube_bloc_with_note/Model/note_model.dart';

class NewNote extends StatelessWidget {
  NewNote({
    super.key,
    this.isUpdate = false,
    this.title = "",
    this.desc = "",
    this.noteId = 0,
    this.userId = 0,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final int userId;
  final int noteId;
  final bool isUpdate;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    titleController.text = title;
    descController.text = desc;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("New Note")),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 11),
              CstmTextField(
                hintText: "Title",
                controller: titleController,
              ),
              const SizedBox(height: 11),
              CstmTextField(
                hintText: "Description",
                controller: descController,
              ),
              const SizedBox(height: 11),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isUpdate) {
                        BlocProvider.of<ListBloc>(context).add(UpdateNote(
                          updateNote: NoteModel(
                            userId: userId,
                            noteId: noteId,
                            noteTitle: titleController.text.toString(),
                            noteDesc: descController.text.toString(),
                          ),
                          index: noteId,
                        ));
                      } else {
                        BlocProvider.of<ListBloc>(context).add(AddNote(
                            newNote: NoteModel(
                          userId: 0,
                          noteId: 0,
                          noteTitle: titleController.text.toString(),
                          noteDesc: descController.text.toString(),
                        )));
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isUpdate ? "Update" : "Add",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
