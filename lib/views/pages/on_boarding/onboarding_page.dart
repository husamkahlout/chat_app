import 'package:easy_localization/easy_localization.dart' as localized;
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/background_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../router/router.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/fonts_manager.dart';
import '../../resources/strings_manager.dart';
import '../auth/login_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final pageViewController = PageController(initialPage: 0);
  late int activeIndex;
  @override
  void initState() {
    activeIndex = pageViewController.initialPage;
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  activeIndex = value;
                });
              },
              controller: pageViewController,
              // reverse: false,
              children: [
                getOnBoardingWidget(
                  context,
                  sliderName: AssetsManager.sliderOne,
                  onboardingText: StringsManager.onboardingOneText,
                  onboardingTitle: StringsManager.onboardingOneTitle,
                ),
                getOnBoardingWidget(
                  context,
                  sliderName: AssetsManager.sliderTwo,
                  onboardingText: StringsManager.onboardingTwoText,
                  onboardingTitle: StringsManager.onboardingTwoTitle,
                ),
                // getOnBoardingWidget(
                //   context,
                //   sliderName: AssetsManager.sliderThree,
                //   onboardingText: StringsManager.onboardingThreeText,
                //   onboardingTitle: StringsManager.onboardingThreeTitle
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 40.h),
            child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 135.w,
                    height: 48.h,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ColorsManager.primaryMain),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.r)),
                            )),
                        onPressed: () {
                          AppRouter.navigateWithReplacemenToWidget(
                              const LoginPage());
                        },
                        child: Text(
                          activeIndex == 1
                              ? StringsManager.start.tr()
                              : StringsManager.skip.tr(),
                          style: TextStyle(
                            fontWeight: FontWeightManager.medium,
                            fontSize: FontSizeManager.s16,
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: BackgroundController(
                      indicatorPosition: 0,
                      indicatorAbove: true,
                      currentPage: activeIndex,
                      totalPage: 2,
                      controllerColor: ColorsManager.secondaryMain,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

Widget getOnBoardingWidget(BuildContext context,
    {required String sliderName,
    required String onboardingTitle,
    required String onboardingText}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      child: Column(
        children: [
          SvgPicture.asset(sliderName),
          SizedBox(
            height: 18.h,
          ),
          Text(onboardingTitle.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: FontSizeManager.s24)),
          SizedBox(
            height: 14.h,
          ),
          Text(onboardingText.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(height: 1.5, fontSize: FontSizeManager.s16)),
          SizedBox(
            height: 130.h,
          ),
        ],
      ),
    ),
  );
}
