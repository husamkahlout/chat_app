import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/fonts_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_textfield.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Selector<AuthProvider, bool>(
        selector: (context, provider) => provider.isLoading,
        builder: (context, isLoading, x) {
          return WillPopScope(
            onWillPop: isLoading
                ? () => Future.value(false)
                : () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.pop(context);
                      return Future.value(true);
                    } else {
                      return Future.value(false);
                    }
                  },
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.h),
                child: getAppBar(
                    context, StringsManager.forgetPasswordAppbar.tr()),
              ),
              body: SingleChildScrollView(  
                padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 8,
                              child: SvgPicture.asset(
                                AssetsManager.forgetImage,
                                width: 300,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: defaultPadding * 2),
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                          return Expanded(
                            flex: 8,
                            child: Form(
                              key: authProvider.forgeKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    StringsManager.forgetPassword.tr(),
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeightManager.semiBold),
                                  ),
                                  Text(
                                    StringsManager.forgetPasswordText.tr(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: ColorsManager.blackColor
                                            .withOpacity(0.5),
                                        fontWeight: FontWeightManager.regular),
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  CustomTextField(
                                      customHintText: StringsManager.email.tr(),
                                      isSecure: false,
                                      textFieldValidator: (value) =>
                                          authProvider.validateInput(
                                              value, "email"),
                                      textFieldController:
                                          authProvider.forgetPasswordController,
                                      prefixIcon:
                                          const Icon(Icons.email_rounded),
                                      textInputType:
                                          TextInputType.emailAddress),
                                  const SizedBox(height: defaultPadding * 1.5),
                                  Hero(
                                      tag: "forget_btn",
                                      child: CustomElevatedButton(
                                        onTap: () {
                                          authProvider.forgetPassword();
                                        },
                                        text: StringsManager.send
                                            .tr()
                                            .toUpperCase(),
                                      )),
                                ],
                              ),
                            ),
                          );
                        }),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
