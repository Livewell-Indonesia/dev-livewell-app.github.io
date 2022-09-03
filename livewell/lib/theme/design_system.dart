import 'package:flutter/cupertino.dart';

class AppColors {
  static const primary100 = Color(0xFF004953);
  static const primary75 = Color(0xFF40767E);
  static const primary50 = Color(0xFF80A4A9);
  static const primary25 = Color(0xFFBFD1D4);
  static const primary15 = Color(0xFFD9E4E5);
  static const primary5 = Color(0xFFF2F6F6);

  static const secondary100 = Color(0xFFFF8B4A);
  static const secondary75 = Color(0xFFFFA877);
  static const secondary50 = Color(0xFFFFC5A4);
  static const secondary25 = Color(0xFFFFE2D2);
  static const secondary15 = Color(0xFFFFEEE4);
  static const secondary5 = Color(0xFFFFF9F6);

  static const tertiary100 = Color(0xFFFFE347);
  static const tertiary75 = Color(0xFFFFEA75);
  static const tertiary50 = Color(0xFFFFF1A3);
  static const tertiary25 = Color(0xFFFFF8D1);
  static const tertiary15 = Color(0xFFFFFBE3);
  static const tertiary5 = Color(0xFFFFFEF6);

  static const textHiEm = Color(0xFF000000);
  static const textLoEm = Color(0xFF505050);
  static const disabled = Color(0xFF808080);
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
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'DM Sans',
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
}
