import 'package:chat_app/view/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_rowforloginandregister.dart';
import 'package:chat_app/widgets/custom_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String registerPageId = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;
  bool progress = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(
        color: Colors.white,
      ),
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
                  "Register",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: "Email",
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: "Password",
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: "Register",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      progress = true;
                      setState(() {});
                      try {
                        await userAuth();
                        Navigator.pushNamed(context, ChatApp.chatAppId);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, "Weak Password");
                          progress = false;
                          setState(() {});
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'email-already-in-use');
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
                  text: "You have an account? ",
                  loginOrRegister: "Login",
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
