import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'Constant.dart';

class CustomTheme {
  Color get hintColor => Color(0xFFCED3D3);

  Color get darkHintColor => Color(0xFF9C9696);

  Color get blackColor => Color(0xFF000000);

  Color get whiteColor => Color(0xFFFFFFFF);

  Color get redColor => Color(0xFFF62326);

  Color get colorPrimary => Color(0xFF0AA2D7);

  Color get colorPrimaryLight => Color(0xFF77aafc);

  Color get textFieldBorder => Color(0xFFCED3D3);

// Bold Text Style
  TextStyle boldTextStyle({
    int? size,
    Color? color,
    FontWeight? weight,
    // String? fontFamily,
    double? letterSpacing,
    FontStyle? fontStyle,
    double? wordSpacing,
    TextDecoration? decoration,
    TextDecorationStyle? textDecorationStyle,
    TextBaseline? textBaseline,
    Color? decorationColor,
    Color? backgroundColor,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: size != null ? size.toDouble() : textBoldSizeGlobal,
      color: color ?? textPrimaryColorGlobal,
      fontWeight: weight ?? fontWeightBoldGlobal,
      // fontFamily: fontFamily ?? fontFamilyBoldGlobal,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: textDecorationStyle,
      decorationColor: decorationColor,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      backgroundColor: backgroundColor,
      height: height,
    );
  }

// Primary Text Style
  TextStyle primaryTextStyle({
    int? size,
    Color? color,
    FontWeight? weight,
    String? fontFamily,
    double? letterSpacing,
    FontStyle? fontStyle,
    double? wordSpacing,
    TextDecoration? decoration,
    TextDecorationStyle? textDecorationStyle,
    TextBaseline? textBaseline,
    Color? decorationColor,
    Color? backgroundColor,
    double? height,
  }) {
    return TextStyle(
      fontSize: size != null ? size.toDouble() : textBoldSizeGlobal,
      color: color ?? textPrimaryColorGlobal,
      fontWeight: weight ?? fontWeightPrimaryGlobal,
      fontFamily: fontFamily ?? fontFamilyPrimaryGlobal,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: textDecorationStyle,
      decorationColor: decorationColor,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      backgroundColor: backgroundColor,
      height: height,
    );
  }

// Secondary Text Style
  TextStyle secondaryTextStyle({
    int? size,
    Color? color,
    FontWeight? weight,
    String? fontFamily,
    double? letterSpacing,
    FontStyle? fontStyle,
    double? wordSpacing,
    TextDecoration? decoration,
    TextDecorationStyle? textDecorationStyle,
    TextBaseline? textBaseline,
    Color? decorationColor,
    Color? backgroundColor,
    double? height,
  }) {
    return TextStyle(
      fontSize: size != null ? size.toDouble() : textSecondarySizeGlobal,
      color: color ?? textSecondaryColorGlobal,
      fontWeight: weight ?? fontWeightSecondaryGlobal,
      fontFamily: fontFamily ?? fontFamilySecondaryGlobal,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: textDecorationStyle,
      decorationColor: decorationColor,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      backgroundColor: backgroundColor,
      height: height,
    );
  }
}
