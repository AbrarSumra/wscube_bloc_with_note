import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wscube_bloc_with_note/AppDataBase/app_db.dart';
import 'package:wscube_bloc_with_note/Constant/text_field.dart';
import 'package:wscube_bloc_with_note/Model/user_model.dart';
import 'package:wscube_bloc_with_note/Screens/login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image:
                AssetImage("assets/images/Login Screen BackGround Image.avif"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 21),
                Container(
                  padding: const EdgeInsets.only(top: 150, left: 30),
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedTextKit(
                        repeatForever: true,
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          WavyAnimatedText(
                            "Create your account",
                            textStyle: GoogleFonts.habibi(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 21),
                CstmTextField(
                  hintText: "Enter your name",
                  controller: nameController,
                ),
                const SizedBox(height: 21),
                CstmTextField(
                  hintText: "Enter your email",
                  controller: emailController,
                ),
                const SizedBox(height: 21),
                CstmTextField(
                  hintText: "Enter your pass",
                  controller: passController,
                ),
                const SizedBox(height: 11),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          passController.text.isNotEmpty) {
                        var appDb = AppDataBase.instance;
                        var check = await appDb.createAccount(UserModel(
                          userId: 0,
                          userName: nameController.text.toString(),
                          userEmail: emailController.text.toString(),
                          userPass: passController.text.toString(),
                        ));

                        var msg = "";

                        if (check) {
                          msg = "Account created successfully";
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => LoginScreen()));
                        } else {
                          msg = "Can't create account as email already exists";
                        }
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(msg)));
                      }
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You have already an account ?",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) => LoginScreen()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
