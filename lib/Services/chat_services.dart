import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farectory/Model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ChatService extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverID, String message, String time) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    final String time = DateFormat('K:mm a, M/d/y').format(DateTime.now());

    Message newMessage = Message(
        message: message,
        receiverID: receiverID,
        timestamp: timestamp,
        time: time,
        senderEmail: currentUserEmail,
        senderID: currentUserId);

    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _fireStore
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('Messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _fireStore
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('Messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
