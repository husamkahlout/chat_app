import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors_manager.dart';
import '../resources/strings_manager.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  final Function? reset;
  const AlreadyHaveAnAccountCheck(
      {super.key, this.login = true, this.press, this.reset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // =================  have an account ? ================================
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              login
                  ? StringsManager.dontHaveAccount.tr()
                  : StringsManager.haveAccount.tr(),
              style:
                  TextStyle(color: ColorsManager.primaryColor, fontSize: 16.sp),
            ),
            GestureDetector(
              onTap: press as void Function()?,
              child: Text(
                textAlign: TextAlign.center,
                login
                    ? StringsManager.signUp.tr()
                    : StringsManager.signIn.tr(),
                style: TextStyle(
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // =================  Forgot password ? ===============================
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              login ? "${StringsManager.forgetPassword.tr()} " : "",
              style: TextStyle(color: ColorsManager.primaryColor, fontSize: 16.sp),
            ),
            GestureDetector(
              onTap: reset as void Function()?,
              child: Text(
                login ? StringsManager.reset.tr() : "",
                style: TextStyle(
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
