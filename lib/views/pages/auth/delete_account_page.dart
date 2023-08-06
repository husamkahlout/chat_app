
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

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Selector<AuthProvider, bool>(
        selector: (context, provider) => provider.isLoading,
        builder: (context, isLoading, x) {
        return WillPopScope(
          onWillPop:      isLoading
                ? () => Future.value(false) : ()
             {
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
          child: getAppBar(context, StringsManager.deleteAccount.tr()),
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
                          AssetsManager.deleteAccount,
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
                        key: authProvider.deleteKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringsManager.confirmDeleteUser.tr(),
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeightManager.semiBold),
                            ),
                            Text(
                              StringsManager.confirmDeleteUserText.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color:
                                      ColorsManager.blackColor.withOpacity(0.5),
                                  fontWeight: FontWeightManager.regular),
                            ),
                            const SizedBox(height: defaultPadding),
    
                   TextFormField(
                                enabled:
                                    authProvider.isLoading == true ? false : true,
                                onChanged: (value) =>
                                    authProvider.notifyListenerss(),
                                obscureText: authProvider.isSecure,
                                controller: authProvider.deletePasswordController,
                                validator: (value) =>
                                    authProvider.validateInput(value, "password"),
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
                                              .deletePasswordController
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
                                            : const Icon(Icons.visibility_off),
                                      ),
                                    ),
                                  ),
                                )),
    
                            const SizedBox(height: defaultPadding * 1.5),
                            Hero(
                                tag: "delete_btn",
                                child: CustomElevatedButton(
                                  onTap: () {
                                    authProvider.deleteAccount();
                                  },
                                  text: StringsManager.delete.tr().toUpperCase(),
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
