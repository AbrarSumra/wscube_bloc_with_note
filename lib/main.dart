import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_bloc_with_note/AppDataBase/app_db.dart';
import 'package:wscube_bloc_with_note/ListBloc/note_list_bloc.dart';
import 'package:wscube_bloc_with_note/Screens/login_screen.dart';
import 'package:wscube_bloc_with_note/Screens/splash_screen.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ListBloc(db: AppDataBase.instance),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
