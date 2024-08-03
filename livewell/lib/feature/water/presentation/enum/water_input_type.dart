import 'package:flutter/material.dart';

enum WaterInputType { reduce, increase }

extension WaterInputTypeExt on WaterInputType {
  String get title {
    switch (this) {
      case WaterInputType.reduce:
        return 'Reduce Water';
      case WaterInputType.increase:
        return "Water Consumed";
    }
  }

  Color get color {
    switch (this) {
      case WaterInputType.reduce:
        return const Color(0xFFDDF235);
      case WaterInputType.increase:
        return const Color(0xFF8F01DF);
    }
  }

  Color get textColor {
    switch (this) {
      case WaterInputType.reduce:
        return Colors.black;
      case WaterInputType.increase:
        return const Color(0xFFFFFFFF);
    }
  }

  String get navbarTitle {
    switch (this) {
      case WaterInputType.increase:
        return 'Add Water';
      case WaterInputType.reduce:
        return 'Reduce';
    }
  }

  String get buttonText {
    switch (this) {
      case WaterInputType.increase:
        return 'Add Drink';
      case WaterInputType.reduce:
        return 'Reduce Drink';
    }
  }
}
