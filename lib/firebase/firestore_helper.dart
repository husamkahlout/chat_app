import 'package:chat_app/firebase/auth_helper.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();

  CollectionReference<Map<String, dynamic>> usersCollection =
      FirebaseFirestore.instance.collection("users");
  CollectionReference<Map<String, dynamic>> chatsCollection =
      FirebaseFirestore.instance.collection("chats");

//================================================ Users ==================================================

// add Users Collection and add a document to it
  addUserToFirestore(UserModel userModel) async {
    await usersCollection.doc(userModel.userID).set(userModel.toJson());
  }

// get user from Firestore
  Future<UserModel> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await usersCollection.doc(id).get();
    return UserModel.fromJson(documentSnapshot.data()!);
  }

  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> result = await usersCollection.get();
    List<UserModel> users = result.docs.map((e) {
      return UserModel.fromJson(e.data());
    }).toList();
    users.removeWhere((element) =>
        element.userID == AuthHelper.authHelper.getCurrentUserID());
    return users;
  }

// delete user from Firestore
  Future<void> deleteUserFromFirestore(String id) async {
    // List<Category> categories =
    //     await FirestoreHelper.firestoreHelper.getAllCategories();
    // for (Category category in categories) {
    //   List<CardModel> cards = await FirestoreHelper.firestoreHelper
    //       .getAllcards(category.categoryID);
    //   for (CardModel card in cards) {
    //   await  FirestoreHelper.firestoreHelper.deleteCard(card, category.categoryID);
    //   }
    //  await FirestoreHelper.firestoreHelper.deleteCategory(category);
    // }
    // await usersCollection.doc(id).delete();
  }
//================================================ Messages ==================================================
  // get chat id
  String getChatId(String otherUserId) {
    String myId = AuthHelper.authHelper.getCurrentUserID();
    int myHashCode = myId.hashCode;
    int otherUserHashCode = otherUserId.hashCode;
    String chatId = myHashCode > otherUserHashCode
        ? "$myHashCode$otherUserHashCode"
        : "$otherUserHashCode$myHashCode";

    return chatId;
  }

// send message
  sendMessage(MessageModel messageModel, String otherUserId) async {
    String chatId = getChatId(otherUserId);
    chatsCollection
        .doc(chatId)
        .collection("messages")
        .add(messageModel.toJson());
  }

  Stream<List<MessageModel>> getAllChatMessages(String otherUserId) {
    String chatId = getChatId(otherUserId);
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = chatsCollection
        .doc(chatId)
        .collection("messages")
        .orderBy("time")
        .snapshots();

    return stream.map((event) {
      List<MessageModel> messages = event.docs.map((message) {
        MessageModel messageModel = MessageModel.fromJson(message.data());
        return messageModel;
      }).toList();
      return messages;
    });
  }
}
