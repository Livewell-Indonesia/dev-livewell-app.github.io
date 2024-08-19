import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';

enum WaterInputType { reduce, increase }

extension WaterInputTypeExt on WaterInputType {
  String get title {
    switch (this) {
      case WaterInputType.reduce:
        return Get.find<HomeController>().localization.waterPage?.reduceWater ?? 'Reduce Water';
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
        return Get.find<HomeController>().localization.waterPage?.addWater ?? 'Add Water';
      case WaterInputType.reduce:
        return Get.find<HomeController>().localization.waterPage?.reduceWater ?? 'Reduce';
    }
  }

  String get buttonText {
    switch (this) {
      case WaterInputType.increase:
        return Get.find<HomeController>().localization.waterPage?.addDrink ?? 'Add Drink';
      case WaterInputType.reduce:
        return Get.find<HomeController>().localization.waterPage?.reduceDrink ?? 'Reduce Drink';
    }
  }
}
