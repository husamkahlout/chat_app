import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../router/router.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import 'package:line_icons/line_icons.dart';

import '../../../resources/strings_manager.dart';
import '../../auth/delete_account_page.dart';
import '../home_page.dart';

List sideMenuItems = [
  {
    "label": StringsManager.home,
    "selected": true,
    "icon": LineIcons.home,
    "page": const HomePage()
  },
];

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          getHeader(context),
          getBody(context),
          getFooter(),
        ],
      ),
    );
  }

  Widget getHeader(BuildContext context) {
    String userName = Provider.of<AuthProvider>(context, listen: false)
            .userModel
            ?.name
            ?.split(" ")
            .first ??
        "User";
    return SizedBox(
      height: 190.h,
      child: DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.h, bottom: 15.h),
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(AssetsManager.user),
                  )),
                ),
                InkWell(
                  onTap: () {
                    if (context.locale.toString() == "ar") {
                      context.setLocale(const Locale("en"));
                    } else {
                      context.setLocale(const Locale("ar"));
                    }
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: ColorsManager.whiteColor,
                        border: Border.all(
                            color:
                                ColorsManager.secondaryColor.withOpacity(0.05)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color:
                                ColorsManager.secondaryColor.withOpacity(0.03),
                            blurRadius: 2.5,
                            offset: const Offset(0, 5),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        context.locale.toString() == "ar" ? 'EN' : 'AR',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: ColorsManager.secondaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Text(
              StringsManager.hey.tr(),
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            Expanded(
              child: Text(
                userName.substring(0, 1).toUpperCase() + userName.substring(1),
                style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody(context) {
    return Column(children: [
      AppRouter.navKey.currentContext!.locale.toString() == "en"
          ? FadeInLeft(
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorsManager.whiteColor,
                      border: Border.all(
                          color:
                              ColorsManager.secondaryColor.withOpacity(0.05)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorsManager.secondaryColor.withOpacity(0.03),
                          blurRadius: 2.5,
                          offset: const Offset(0, 5),
                        )
                      ]),
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    minLeadingWidth: 10,
                    leading: const Icon(
                      LineIcons.home,
                      color: ColorsManager.secondaryColor,
                    ),
                    title: Text(
                      StringsManager.home.tr(),
                      style: const TextStyle(
                          fontSize: 16, color: ColorsManager.secondaryColor),
                    ),
                  ),
                ),
              ),
            )
          : FadeInRight(
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorsManager.whiteColor,
                      border: Border.all(
                          color:
                              ColorsManager.secondaryColor.withOpacity(0.05)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorsManager.secondaryColor.withOpacity(0.03),
                          blurRadius: 2.5,
                          offset: const Offset(0, 5),
                        )
                      ]),
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    minLeadingWidth: 10,
                    leading: const Icon(
                      LineIcons.home,
                      color: ColorsManager.secondaryColor,
                    ),
                    title: Text(
                      StringsManager.home.tr(),
                      style: const TextStyle(
                          fontSize: 16, color: ColorsManager.secondaryColor),
                    ),
                  ),
                ),
              ),
            ),
      AppRouter.navKey.currentContext!.locale.toString() == "en"
          ? FadeInLeft(
              duration: const Duration(milliseconds: 400),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: InkWell(
                  onTap: () {
                    Provider.of<AuthProvider>(AppRouter.navKey.currentContext!,
                            listen: false)
                        .signOut();
                  },
                  child: SizedBox(
                    child: ListTile(
                      minLeadingWidth: 10,
                      leading: const Icon(
                        LineIcons.alternateSignOut,
                        color: ColorsManager.secondaryColor,
                      ),
                      title: Text(
                        StringsManager.logout.tr(),
                        style: const TextStyle(
                            fontSize: 16, color: ColorsManager.secondaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : FadeInRight(
              duration: const Duration(milliseconds: 400),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: InkWell(
                  onTap: () {
                    Provider.of<AuthProvider>(AppRouter.navKey.currentContext!,
                            listen: false)
                        .signOut();
                  },
                  child: SizedBox(
                    child: ListTile(
                      minLeadingWidth: 10,
                      leading: const Icon(
                        LineIcons.alternateSignOut,
                        color: ColorsManager.secondaryColor,
                      ),
                      title: Text(
                        StringsManager.logout.tr(),
                        style: const TextStyle(
                            fontSize: 16, color: ColorsManager.secondaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
      const Divider(),
    ]);
  }

  Widget getFooter() {
    return AppRouter.navKey.currentContext!.locale.toString() == "en"
        ? FadeInLeft(
            duration: const Duration(milliseconds: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: InkWell(
                onTap: () {
                  AppRouter.popRouter();
                  AppRouter.navigateToWidget(const DeleteAccountPage());
                },
                child: SizedBox(
                  child: ListTile(
                    minLeadingWidth: 10,
                    leading: const Icon(
                      LineIcons.removeUser,
                      color: ColorsManager.errorColor,
                    ),
                    title: Text(
                      StringsManager.deleteAccount.tr(),
                      style: const TextStyle(
                          fontSize: 16, color: ColorsManager.errorColor),
                    ),
                  ),
                ),
              ),
            ),
          )
        : FadeInRight(
            duration: const Duration(milliseconds: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: InkWell(
                onTap: () {
                  AppRouter.popRouter();
                  AppRouter.navigateToWidget(const DeleteAccountPage());
                },
                child: SizedBox(
                  child: ListTile(
                    minLeadingWidth: 10,
                    leading: const Icon(
                      LineIcons.removeUser,
                      color: ColorsManager.errorColor,
                    ),
                    title: Text(
                      StringsManager.deleteAccount.tr(),
                      style: const TextStyle(
                          fontSize: 16, color: ColorsManager.errorColor),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
