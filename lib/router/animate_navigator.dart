import 'package:chat_app/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class AnimateNavigator extends PageRouteBuilder {
  // ignore: prefer_typing_uninitialized_variables
  final page;
  AnimateNavigator({this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = AppRouter.navKey.currentContext!.locale.toString() == "en"
                    ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
