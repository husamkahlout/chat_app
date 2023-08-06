import 'package:flutter/material.dart';

import 'animate_navigator.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static navigateToWidget(Widget widget) {
    Navigator.of(navKey.currentContext!).push(AnimateNavigator(page: widget));
  }

  static navigateWithReplacemenToWidget(Widget widget) {
    Navigator.of(navKey.currentContext!)
        .pushReplacement(AnimateNavigator(page: widget));
  }

  static popRouter() {
    Navigator.of(navKey.currentContext!).pop();
  }

  static popUntil(Widget widget) {
    Navigator.pushAndRemoveUntil(
        navKey.currentContext!,
        MaterialPageRoute(builder: (BuildContext context) => widget),
        ModalRoute.withName('/'));
  }
}
