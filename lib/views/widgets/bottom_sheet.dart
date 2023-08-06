import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../router/router.dart';

class CustomBottomSheet {
  static showBottomSheet({required Widget widget, Color? color}) {
    showModalBottomSheet(
        backgroundColor: color,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: AppRouter.navKey.currentContext!,
        builder: (context) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 20.h, right: 25.w, left: 25.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget,
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                    ),
                  )
                ],
              ));
        });
  }
}
