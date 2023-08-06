import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/views/pages/home/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../resources/colors_manager.dart';
import '../../../resources/fonts_manager.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false).getAllUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        itemCount: chatProvider.chatUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  AppRouter.navigateToWidget(
                      ChatPage(userModel: chatProvider.chatUsers[index]));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryLightColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Text(
                              chatProvider.chatUsers[index].name![0]
                                  .toUpperCase(),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            chatProvider.chatUsers[index].name![0]
                                    .toUpperCase() +
                                chatProvider.chatUsers[index].name!
                                    .substring(1),
                            style: TextStyle(
                                color: ColorsManager.blackColor,
                                fontSize: 18.spMin,
                                fontWeight: FontWeightManager.semiBold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              )
            ],
          );
        },
      );
    });
  }
}
