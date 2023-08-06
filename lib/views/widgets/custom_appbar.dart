import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../router/router.dart';
import '../resources/colors_manager.dart';
import '../resources/fonts_manager.dart';

Widget getAppBar(context, String title) {
  return AppBar(
    // leading
    leading: Consumer< AuthProvider>(
      builder: (context, authProvider, x) {
        return IconButton(
          onPressed: (authProvider.isLoading == true) ? null : () {
           AppRouter.popRouter();
          },
          icon: Container(
            width: 35.w,
            height: 35.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: ColorsManager.secondaryColor.withOpacity(0.2))),
            child: const Center(
              child: Icon(Icons.arrow_back_ios_rounded,
                  size: 15, color: ColorsManager.secondaryColor),
            ),
          ),
        );
      }
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: ColorsManager.secondaryColor,
            fontWeight: FontWeightManager.semiBold,
            fontSize: 21.sp,
          ),
    ),
  );
}