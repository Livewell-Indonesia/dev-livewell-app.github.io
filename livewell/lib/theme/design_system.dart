import 'package:flutter/material.dart';

class AppColors {
  static const primaryPurple = Color(0xFF8F01DF);
  static const primaryGreen = Color(0xFFDDF235);
  static const primaryTurquoise = Color(0xFF34EAB2);
  static const secondaryDarkBlue = Color(0xFF171433);
  static const textHiEm = Color(0xFF000000);
  static const textLoEm = Color(0xFF505050);
  static const disabled = Color(0xFF808080);
  static const textBg = Color(0xFFFFFFFF);
  static const borderColor = Color(0xFFF1F1F1);

  // Neutral colors
  static const neutral100 = Color(0xFF0A0A0A);
  static const neutral90 = Color(0xFF404040);
  static const neutral80 = Color(0xFF616161);
  static const neutral70 = Color(0xFF757575);
  static const neutral10 = Color(0xFFFAFAFA);
  static const neutral20 = Color(0xFFF5F5F5);
  static const neutral30 = Color(0xFFEDEDED);


  // black
  static const black = Color(0xFF000000);
  static const black600 = Color(0xFF555555);
}

class Insets {
  /// Padding 4.0
  static const double paddingXSmall = 4.0;

  /// Padding 8.0
  static const double paddingSmall = 8.0;

  /// Padding 12.0
  static const double paddingMedium = 12.0;

  /// Spacing 4.0
  static const double spacingSmall = 4.0;

  /// Spacing 12.0
  static const double spacingMedium = 12.0;

  /// Spacing 24.0
  static const double spacingLarge = 24.0;
}

class TextStyles {
  static TextStyle titleHiEm({required Color color}) {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      fontFamily: 'DM Sans',
      color: color,
    );
  }

  static TextStyle subTitleHiEm({required Color color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      fontFamily: 'DM Sans',
      color: color,
    );
  }

  static TextStyle bodyStrong({required Color color}) {
    /*
  * Add the following text styles
  */
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle body({required Color color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'DM Sans',
      color: color,
    );
  }

  static TextStyle bodySmallStrong({required Color color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      fontFamily: 'DM Sans',
      color: color,
    );
  }

  static TextStyle bodySmall({required Color color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'DM Sans',
      color: color,
    );
  }

  static TextStyle navbarTitle(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.textLoEm,
    );
  }
}

extension LivewellColorScheme on ColorScheme {
  Color get primaryPurple => brightness == Brightness.light ? AppColors.primaryPurple : AppColors.primaryPurple;
  Color get primaryGreen => brightness == Brightness.light ? AppColors.primaryGreen : AppColors.primaryGreen;
  Color get primaryTurquoise => brightness == Brightness.light ? AppColors.primaryTurquoise : AppColors.primaryTurquoise;
  Color get secondaryDarkBlue => brightness == Brightness.light ? AppColors.secondaryDarkBlue : AppColors.secondaryDarkBlue;
  Color get textLoEm => brightness == Brightness.light ? AppColors.textLoEm : AppColors.textLoEm;
  Color get textHiEm => brightness == Brightness.light ? AppColors.textHiEm : AppColors.textHiEm;
  Color get textBg => brightness == Brightness.light ? AppColors.textBg : AppColors.textBg;
  Color get disabled => brightness == Brightness.light ? AppColors.disabled : AppColors.disabled;

  Color get borderColor => brightness == Brightness.light ? AppColors.borderColor : AppColors.borderColor;

  // Neutral colors
  Color get neutral100 => brightness == Brightness.light ? AppColors.neutral100 : AppColors.neutral100;
  Color get neutral90 => brightness == Brightness.light ? AppColors.neutral90 : AppColors.neutral90;
  Color get neutral80 => brightness == Brightness.light ? AppColors.neutral80 : AppColors.neutral80;
  Color get neutral70 => brightness == Brightness.light ? AppColors.neutral70 : AppColors.neutral70;
  Color get neutral10 => brightness == Brightness.light ? AppColors.neutral10 : AppColors.neutral10;
  Color get neutral20 => brightness == Brightness.light ? AppColors.neutral20 : AppColors.neutral20;
  Color get neutral30 => brightness == Brightness.light ? AppColors.neutral30 : AppColors.neutral30;


  // black
  Color get black => brightness == Brightness.light ? AppColors.black : AppColors.black;
  Color get black600 => brightness == Brightness.light ? AppColors.black600 : AppColors.black600;
}
