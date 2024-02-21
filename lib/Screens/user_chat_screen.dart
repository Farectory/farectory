// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farectory/Services/chat_services.dart';
import 'package:farectory/componenets/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserChatScreen extends StatefulWidget {
  String profileName;
  String imageUrl;
  String receiverID;
  UserChatScreen(
      {super.key,
      required this.profileName,
      required this.imageUrl,
      required this.receiverID});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String time = DateFormat('K:mm a, M/d/y').format(DateTime.now());
  bool _isVisible = false;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text, time);
      _messageController.clear();
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(0),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.blue,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.profileName,
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      width: 70,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.network(
                          widget.imageUrl,
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 180,
                child: _buildMessageList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(24, 95, 159, 228),
                    ),
                    child: TextFormField(
                      minLines: null,
                      maxLines: null,
                      expands: true,
                      controller: _messageController,
                      autofocus: true,
                      onChanged: (value) => null,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: '  Start chatting'),
                    ),
                  ),
                  IconButton(onPressed: sendMessage, icon: Icon(Icons.send))
                ],
              ),
            )
          ])),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.data?.docs == null) {
            return Center(child: Text('No message yet... Send a message now'));
          }

          return ListView(
            reverse: true,
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.bottomRight
        : Alignment.bottomLeft;

    return Container(
        padding: EdgeInsets.all(8),
        alignment: alignment,
        child: Column(
            crossAxisAlignment:
                (data['senderID'] == _firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              Column(children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    child: ChatBubble(message: data['message'])),
                Visibility(
                  visible: _isVisible,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data['time']}',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ])
            ]));
  }
}
