import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_bloc_with_note/Constant.dart';
import 'package:wscube_bloc_with_note/ListBloc/list_bloc.dart';
import 'package:wscube_bloc_with_note/ListBloc/list_event.dart';

class NewNote extends StatelessWidget {
  NewNote({
    super.key,
    this.isUpdate = false,
    this.title = "",
    this.desc = "",
    this.noteId = 0,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

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
                    onPressed: () {},
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
                          updateNote: {
                            "title": titleController.text,
                            "desc": descController.text,
                          },
                          index: noteId,
                        ));
                      } else {
                        BlocProvider.of<ListBloc>(context)
                            .add(AddNote(newNote: {
                          "title": titleController.text,
                          "desc": descController.text,
                        }));
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
