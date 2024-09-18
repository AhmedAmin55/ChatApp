import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChatApp extends StatefulWidget {
  static String chatAppId = "ChatApp";

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();
  final conrollerForListView = ScrollController();
  @override
  Widget build(BuildContext context) {
    List<MessageModel> messageList = [];
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(
                MessageModel.fromjason(snapshot.data!.docs[i]),
              );
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Color(0xff314F6B),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/scholar.png",
                      width: 60,
                    ),
                    Text("Chat"),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    reverse: true,
                    controller: conrollerForListView,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return ChatBuble(
                        message: messageList[index],
                      );
                    },
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    child: TextFormField(
                      controller: controller,
                      onFieldSubmitted: (message) {
                        messages.add({
                          'message': message,
                          'createdAt': DateTime.now(),
                        });
                        controller.clear();
                        conrollerForListView.animateTo(
                          0,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeIn,
                        );
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.send,
                            color: Color(0xff314F6B),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xff314F6B),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xff314F6B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                color: Colors.white,
              ),
              inAsyncCall: true,
              child: Scaffold(),
            );
          }
        });
  }
}
