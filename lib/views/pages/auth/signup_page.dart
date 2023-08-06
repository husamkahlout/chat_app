// ignore_for_file: prefer_const_constructors

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
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
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
          padding: EdgeInsets.symmetric(vertical: 40.h),
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
                          AssetsManager.signupImage,
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
                  Expanded(
                    flex: 8,
                    child: Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                      return Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: authProvider.signUpKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                  customHintText: StringsManager.name.tr(),
                                  isSecure: false,
                                  textFieldValidator: (value) => authProvider
                                      .validateInput(value, "required"),
                                  textFieldController:
                                      authProvider.signUpUserNameController,
                                  prefixIcon: const Icon(Icons.person),
                                  textInputType: TextInputType.text),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                child: CustomTextField(
                                    customHintText: StringsManager.email.tr(),
                                    isSecure: false,
                                    textFieldValidator: (value) => authProvider
                                        .validateInput(value, "email"),
                                    textFieldController:
                                        authProvider.signUpEmailController,
                                    prefixIcon: const Icon(Icons.email_rounded),
                                    textInputType: TextInputType.emailAddress),
                              ),
                              TextFormField(
                               enabled: authProvider.isLoading == true ? false: true,
                                  onChanged: (value) =>
                                      authProvider.notifyListenerss(),
                                  obscureText: authProvider.isSecure,
                                  controller:
                                      authProvider.signUpPasswordController,
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
                                                .signUpPasswordController
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
                              const SizedBox(height: defaultPadding),
                              Hero(
                                  tag: "signUp_btn",
                                  child: CustomElevatedButton(
                                      onTap: () {
                                        authProvider.signUp();
                                      },
                                      text: StringsManager.signUp
                                          .tr()
                                          .toUpperCase())),
                              const SizedBox(height: defaultPadding),
                              AlreadyHaveAnAccountCheck(
                                login: false,
                                press: (authProvider.isLoading)
                                    ? null
                                    : () {
                                  AppRouter.navigateWithReplacemenToWidget(
                                      LoginPage());
                                },
                              ),
                            ],
                          ));
                    }),
                  ),
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
