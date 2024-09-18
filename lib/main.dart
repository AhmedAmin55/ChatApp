import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/view/chat_page.dart';
import 'package:chat_app/view/login_page.dart';
import 'package:chat_app/view/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarApp());
}

class ScholarApp extends StatelessWidget {
  const ScholarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.loginPageId: (context) => LoginPage(),
        RegisterPage.registerPageId: (context) => RegisterPage(),
        ChatApp.chatAppId: (context) => ChatApp(),
      },
      initialRoute: LoginPage.loginPageId,
    );
  }
}
