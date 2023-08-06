import 'package:chat_app/firebase/auth_helper.dart';
import 'package:chat_app/firebase/firestore_helper.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider() {
    getAllUsers();
  }
  TextEditingController messageContentController = TextEditingController();
  List<UserModel> chatUsers = [];
  getAllUsers() async {
    chatUsers = await FirestoreHelper.firestoreHelper.getAllUsers();
    notifyListeners();
  }

  sendMessage(String otherUserId) async {
    MessageModel messageModel = MessageModel(
        content: messageContentController.text,
        senderId: AuthHelper.authHelper.getCurrentUserID());
        
    await FirestoreHelper.firestoreHelper
        .sendMessage(messageModel, otherUserId);
    messageContentController.clear();
  }
}
