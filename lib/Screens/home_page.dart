import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_bloc_with_note/ListBloc/list_bloc.dart';
import 'package:wscube_bloc_with_note/ListBloc/list_event.dart';
import 'package:wscube_bloc_with_note/ListBloc/list_state.dart';
import 'package:wscube_bloc_with_note/Screens/new_note.dart';

import '../CounterBloc/counter_bloc.dart';
import '../CounterBloc/counter_event.dart';
import '../CounterBloc/counter_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Bloc App")),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<ListBloc, ListState>(
        builder: (_, state) {
          var noteList = state.mData;
          return ListView.builder(
            itemCount: noteList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("${noteList[index]["title"]}"),
                subtitle: Text("${noteList[index]["desc"]}"),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => NewNote(
                                        isUpdate: true,
                                        noteId: index,
                                        title: "${noteList[index]["title"]}",
                                        desc: "${noteList[index]["desc"]}",
                                      )));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text("Delete?"),
                                  content: const Text(
                                      "Are you want sure to delete?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        BlocProvider.of<ListBloc>(context)
                                            .add(DeleteNote(index: index));
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Yes"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No"),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => NewNote()));
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.black,
        ),
      ),
    );
  }
}
