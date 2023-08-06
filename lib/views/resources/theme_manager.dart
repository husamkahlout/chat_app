import 'package:chat_app/views/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors_manager.dart';
import 'fonts_manager.dart';

ThemeData lightTheme() {
  return ThemeData(
      scaffoldBackgroundColor: ColorsManager.whiteColor,
      fontFamily: FontFamilyManager.fontFamily,
      // text theme
      textTheme: TextTheme(
        //  fontWeight 700
        headlineLarge: getBoldStyle(
            color: ColorsManager.neutral_100, fontsize: FontSizeManager.s17),
        //  fontWieght 500
        headlineMedium: getMediumStyle(
            color: ColorsManager.neutral_70, fontsize: FontSizeManager.s14),
        //  fontWeight 400
        headlineSmall: getRegularStyle(
            color: ColorsManager.neutral_70, fontsize: FontSizeManager.s12),
        // fontWeight 600
        bodyLarge: getSemiBoldStyle(
            color: ColorsManager.neutral_100, fontsize: FontSizeManager.s16),
        //  fontWeight 400
        bodySmall: getRegularStyle(
            color: ColorsManager.neutral_100, fontsize: FontSizeManager.s12),
      ),

      // colors
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: ColorsManager.secondaryMain.withOpacity(0.6)),
      // app bar theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ColorsManager.whiteColor,
      ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorsManager.secondaryMain
    ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:  ElevatedButton.styleFrom(
          disabledBackgroundColor : ColorsManager.primaryMain,
          elevation: 0,
          backgroundColor: ColorsManager.primaryMain,
          shape: const StadiumBorder(),
          maximumSize:  Size(double.infinity, 56.h),
          minimumSize:  Size(double.infinity, 56.h),
        ),
      ),
      inputDecorationTheme:  InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.primaryLightColor,
        iconColor: ColorsManager.primaryColor,
        prefixIconColor: ColorsManager.primaryColor.withOpacity(0.72),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
      ));
}
