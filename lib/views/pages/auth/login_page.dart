import 'package:chat_app/views/pages/auth/signup_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/fonts_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_textfield.dart';
import 'forget_password.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 80.h, bottom: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 8,
                        child: SvgPicture.asset(
                          AssetsManager.loginImage,
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
                        key: authProvider.loginKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                                customHintText: StringsManager.email.tr(),
                                isSecure: false,
                                textFieldValidator: (value) =>
                                    authProvider.validateInput(value, "email"),
                                textFieldController:
                                    authProvider.loginEmailController,
                                prefixIcon: const Icon(Icons.email_rounded),
                                textInputType: TextInputType.emailAddress),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: TextFormField(
                                enabled: authProvider.isLoading == true ? false: true,
                                  onChanged: (value) =>
                                      authProvider.notifyListenerss(),
                                  obscureText: authProvider.isSecure,
                                  controller:
                                      authProvider.loginPasswordController,
                                  validator: (value) => authProvider
                                      .validateInput(value, "password"),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ColorsManager.primaryMain,
                                  decoration: InputDecoration(
                                    hintText: StringsManager.password.tr(),
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Icon(Icons.lock),
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Visibility(
                                        visible: authProvider
                                                .loginPasswordController
                                                .text
                                                .isNotEmpty
                                            ? true
                                            : false,
                                        child: InkWell(
                                          onTap: () {
                                            authProvider.setVisibilty();
                                          },
                                          child: authProvider.isSecure
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(height: defaultPadding),
                            Hero(
                              tag: "login_btn",
                              child: CustomElevatedButton(
                                onTap: () {
                                  authProvider.login();
                                },
                                text: StringsManager.loginButton
                                    .tr()
                                    .toUpperCase(),
                              ),
                            ),
                            const SizedBox(height: defaultPadding),
                            AlreadyHaveAnAccountCheck(
                              reset: (authProvider.isLoading) ? null : () {
                                AppRouter.navigateToWidget(
                                    const ForgetPassword());
                              },
                              press: (authProvider.isLoading)
                                  ? null
                                  : () {
                                AppRouter.navigateWithReplacemenToWidget(
                                    const SignUpPage());
                              },
                            ),
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
  }
}
