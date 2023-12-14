import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wscube_bloc_with_note/ListBloc/note_list_bloc.dart';
import 'package:wscube_bloc_with_note/ListBloc/note_list_event.dart';
import 'package:wscube_bloc_with_note/ListBloc/note_list_state.dart';
import 'package:wscube_bloc_with_note/Screens/login_screen.dart';
import 'package:wscube_bloc_with_note/Screens/new_note.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListBloc>(context).add(FetchNote());
    BlocProvider.of<ListBloc>(context).db;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/blur-background.jpg"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Center(child: Text("Bloc App")),
          backgroundColor: Colors.blue,
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setBool(LoginScreen.LOGIN_PREFS_KEY, false);

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) => LoginScreen()));
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: BlocBuilder<ListBloc, ListState>(
          builder: (_, state) {
            if (state is NoteDbLoaded) {
              var noteList = state.allNote;
              return ListView.builder(
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.primaries[index],
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ),
                      title: Text(
                        noteList[index].noteTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        noteList[index].noteDesc,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: PopupMenuButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => NewNote(
                                                isUpdate: true,
                                                userId: noteList[index].userId,
                                                noteId: noteList[index].noteId,
                                                title:
                                                    noteList[index].noteTitle,
                                                desc: noteList[index].noteDesc,
                                              )));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                label: const Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              child: TextButton.icon(
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
                                                BlocProvider.of<ListBloc>(
                                                        context)
                                                    .add(DeleteNote(
                                                        index: noteList[index]
                                                            .noteId));
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
                                  color: Colors.blue,
                                ),
                                label: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            )
                          ];
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
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
      ),
    );
  }
}
