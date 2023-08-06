import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../firebase/firestore_helper.dart';
import '../../../resources/colors_manager.dart';
import '../../../widgets/custom_appbar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: getAppBar(context,
            userModel.name![0].toUpperCase() + userModel.name!.substring(1)),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<MessageModel>>(
            stream: FirestoreHelper.firestoreHelper
                .getAllChatMessages(userModel.userID!),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<MessageModel> messages = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ChatBubble(
                          clipper: ChatBubbleClipper5(
                              type: messages[index].isFromMe
                                  ? BubbleType.sendBubble
                                  : BubbleType.receiverBubble),
                          alignment: messages[index].isFromMe
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 10),
                          backGroundColor: messages[index].isFromMe
                              ? Colors.blue
                              : ColorsManager.primaryMain,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              messages[index].content,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "No Messages Here",
                    style: TextStyle(
                        fontSize: 18, color: ColorsManager.primaryColor),
                  ),
                );
              }
            },
          )),
          MessageBarWidget(otherUserId: userModel.userID!)
        ],
      ),
    );
  }
}

class MessageBarWidget extends StatelessWidget {
  const MessageBarWidget({super.key, required this.otherUserId});

  final String otherUserId;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, x) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: ColorsManager.primaryColor,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: chatProvider.messageContentController,
                      keyboardType: TextInputType.text,
                      // textCapitalization: TextCapitalization.sentences,
                      minLines: 1,
                      maxLines: 2,
                      // onChanged: onTextChanged,
                      decoration: InputDecoration(
                        hintText: "write here...",
                        hintMaxLines: 1,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10),
                        hintStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () {
                        chatProvider.sendMessage(otherUserId);
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 30,
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
