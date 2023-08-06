import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../resources/colors_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder:
        (context, authProvider, child) {
      return ElevatedButton(
        onPressed: (authProvider.isLoading == true )
            ? null
            : onTap,
        child: (authProvider.isLoading  == false)
            ? Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: ColorsManager.whiteColor),
              )
            : Center(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: ColorsManager.secondaryMain,
                        strokeWidth: 2,
                      )),
                  SizedBox(width: 10.w),
                  Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: ColorsManager.whiteColor),
                  )
                ],
              )),
      );
    });
  }
}
