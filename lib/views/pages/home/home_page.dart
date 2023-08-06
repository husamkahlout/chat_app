import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/colors_manager.dart';
import 'chat/chats_page.dart';
import 'components/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
          return Future.value(true);
        } else {
          log('cant pop');
          return Future.value(false);
        }
      },
      child: Scaffold(
        key: HomePage.scaffolKey,
        drawer: const SideMenu(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: getAppBar(context),
        ),
        body: getBody(context),
      ),
    );
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // leading
      leading: IconButton(
          onPressed: () {
            HomePage.scaffolKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: ColorsManager.secondaryColor,
            size: 30,
          )),
      title: Text(
        "المحادثات",
        style: Theme.of(context)
            .textTheme
            .headlineLarge!
            .copyWith(color: ColorsManager.secondaryColor, fontSize: 22.sp),
      ),
      // actions
    );
  }
}

Widget getBody(context) {
  return const ChatsPage();
}
