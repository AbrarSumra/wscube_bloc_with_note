import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wscube_bloc_with_note/AppDataBase/app_db.dart';
import 'package:wscube_bloc_with_note/Constant/text_field.dart';
import 'package:wscube_bloc_with_note/Screens/home_page.dart';
import 'package:wscube_bloc_with_note/Screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static final String LOGIN_PREFS_KEY = "isLogin";

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
                Container(
                  padding: const EdgeInsets.only(top: 150, left: 30),
                  height: 270,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedTextKit(
                        repeatForever: true,
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          WavyAnimatedText(
                            "Welcome in Bloc App",
                            textStyle: GoogleFonts.habibi(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "Back",
                            speed: const Duration(milliseconds: 250),
                            textStyle: GoogleFonts.damion(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
                      if (emailController.text.isNotEmpty &&
                          passController.text.isNotEmpty) {
                        var email = emailController.text.toString();
                        var pass = passController.text.toString();

                        var appDb = AppDataBase.instance;
                        if (await appDb.authenticateUser(email, pass)) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx) => HomePage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Invalid Email and Password !!!")));
                        }

                        var prefs = await SharedPreferences.getInstance();
                        prefs.setBool(LOGIN_PREFS_KEY, true);
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You have not an account ?",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => SignupScreen()));
                      },
                      child: const Text(
                        "Create account",
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
