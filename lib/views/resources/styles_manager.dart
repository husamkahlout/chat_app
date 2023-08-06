import 'package:flutter/material.dart';
import 'fonts_manager.dart';

// if we have more than fontfamily we param it
TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontFamily: FontFamilyManager.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

// regular style
TextStyle getRegularStyle(
    {
      required double fontsize,
       required Color color}) {
  return _getTextStyle(fontsize, FontWeightManager.regular, color);
}

// medium style
TextStyle getMediumStyle({
  required Color color,
  required double fontsize,
}) {
  return _getTextStyle(fontsize, FontWeightManager.medium, color);
}

// light style
TextStyle getLightStyle({
  required Color color,
  required double fontsize
  
}) {
  return _getTextStyle(fontsize, FontWeightManager.light, color);
}

//bold style
TextStyle getBoldStyle({
  required Color color,
  required double fontsize
}) {
  return _getTextStyle(fontsize, FontWeightManager.bold, color);
}

//semiBold
TextStyle getSemiBoldStyle({
  required Color color,
  required double fontsize
}) {
  return _getTextStyle(fontsize, FontWeightManager.semiBold, color);
}
