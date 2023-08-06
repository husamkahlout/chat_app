import 'package:chat_app/firebase/auth_helper.dart';

class MessageModel {
  late String content;
  late String senderId;
  late DateTime date;
  late bool isFromMe;

  MessageModel({required this.content, required this.senderId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    senderId = json['senderId'];
    isFromMe = (json['senderId'] == AuthHelper.authHelper.getCurrentUserID());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = DateTime.now().subtract(const Duration(minutes: 1));
    data['content'] = content;
    data['senderId'] = senderId;
    return data;
  }
}
