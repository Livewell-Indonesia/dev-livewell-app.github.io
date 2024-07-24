import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';

enum WaterShortcutType {
  custom,
  hundredMl,
  twoFiftyMl,
  fiveHundredMl,
}

extension WaterShortCutTypeX on WaterShortcutType {
  String get title {
    switch (this) {
      case WaterShortcutType.custom:
        return Get.find<DashboardController>().localization.custom ?? 'Custom';
      case WaterShortcutType.hundredMl:
        return Get.find<DashboardController>().localization.hydration100Ml ?? '100 ml';
      case WaterShortcutType.twoFiftyMl:
        return Get.find<DashboardController>().localization.hydration250Ml ?? '250 ml';
      case WaterShortcutType.fiveHundredMl:
        return Get.find<DashboardController>().localization.hydration500Ml ?? '500 ml';
    }
  }

  int get value {
    switch (this) {
      case WaterShortcutType.custom:
        return 0;
      case WaterShortcutType.hundredMl:
        return 100;
      case WaterShortcutType.twoFiftyMl:
        return 250;
      case WaterShortcutType.fiveHundredMl:
        return 500;
    }
  }

  String get assets {
    switch (this) {
      case WaterShortcutType.custom:
        return 'assets/icons/ic_water_custom.svg';
      case WaterShortcutType.hundredMl:
        return 'assets/icons/ic_water_100ml.svg';
      case WaterShortcutType.twoFiftyMl:
        return 'assets/icons/ic_water_250ml.svg';
      case WaterShortcutType.fiveHundredMl:
        return 'assets/icons/ic_water_500ml.svg';
    }
  }
}
