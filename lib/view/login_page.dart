import 'package:chat_app/view/chat_page.dart';
import 'package:chat_app/view/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_rowforloginandregister.dart';
import 'package:chat_app/widgets/custom_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String loginPageId = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool progress = false;
  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progress,
      child: Scaffold(
        backgroundColor: Color(0xff314F6B),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset(
                  "assets/images/scholar.png",
                  height: 100,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Scholar chat",
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: "Pacifico",
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: "Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: "Password",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: "LOGIN",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      progress = true;
                      setState(() {});
                      try {
                        await userLogin();
                        Navigator.pushNamed(context, ChatApp.chatAppId);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, "No user found for that email");
                          progress = false;
                          setState(() {});
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'Wrong Password');
                          progress = false;
                          setState(() {});
                        }
                      } catch (e) {
                        showSnackBar(context, "Try Later");
                      }
                      progress = false;
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomRowForLoginAndRegister(
                  text: "don't have an account? ",
                  loginOrRegister: "Register",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RegisterPage.registerPageId,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
