import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/water/data/model/water_list_model.dart';
import 'package:livewell/feature/water/domain/usecase/get_water_data.dart';
import 'package:livewell/feature/water/domain/usecase/post_water_data.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';
import 'package:livewell/core/base/base_controller.dart';

class WaterController extends BaseController {
  var waterConsumed = 0.0.obs;
  var waterConsumedPercentage = 0.0.obs;
  final int waterGoal = 2000;
  RxList<WaterModel> waterList = <WaterModel>[].obs;

  @override
  void onInit() {
    getWaterData();
    showInfoFirstTime();
    super.onInit();
  }

  void showInfoFirstTime() async {
    var show = await SharedPref.showInfoWater();
    HomeController controller = Get.find();
    var data = controller.popupAssetsModel.value.water;
    if (show && data != null) {
      showModalBottomSheet(
          context: Get.context!,
          isScrollControlled: true,
          shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
          builder: ((context) {
            return PopupAssetWidget(
              exercise: data,
            );
          }));
      SharedPref.saveShowInfoWater(false);
    }
  }

  void getWaterData() async {
    // mock api call for 2 s
    GetWaterData instance = GetWaterData.instance();
    final result = await instance.call(NoParams());
    result.fold((l) {
      Log.error(l);
    }, (r) {
      if (r.response != null) {
        var consumed = r.response?.firstWhere((element) => element.recordAt == DateFormat('yyyy-MM-dd').format(DateTime.now()), orElse: () => WaterModel(recordAt: '', value: 0)).value ?? 0;
        waterConsumed.value = consumed / 1000;
        waterList.value = r.response ?? [];
        waterConsumedPercentage.value = (consumed / waterGoal).maxOneOrZero;
      }
      Log.colorGreen(r);
    });
  }

  void addWater(int value) async {
    PostWaterData instance = PostWaterData.instance();
    EasyLoading.show();
    final result = await instance.call(PostWaterParams(water: value));
    EasyLoading.dismiss();
    result.fold((l) {
      Log.error(l);
    }, (r) {
      getWaterData();
      Get.find<DashboardController>().getWaterData();
      Get.find<DashboardController>().getTodayWellnessData();
      Log.colorGreen(r);
    });
  }
}

extension on double {
  double get maxOneOrZero {
    if (this > 1) {
      return 1;
    } else if (this < 0) {
      return 0;
    } else {
      return this;
    }
  }
}

class UrineData {
  static List<List<UrineColorType>> urineColors = [
    [UrineColorType.overhydrated],
    [UrineColorType.good, UrineColorType.fair],
    [UrineColorType.lightHydrated, UrineColorType.dehydrated],
  ];
}

enum UrineColorType {
  overhydrated,
  good,
  fair,
  lightHydrated,
  dehydrated,
  veryDehydrated,
  severeDehydrated,
}

extension UrineColorTypeX on UrineColorType {
  Color get color {
    switch (this) {
      case UrineColorType.overhydrated:
        return const Color(0xFFFCFFE4);
      case UrineColorType.good:
        return const Color(0xFFFCF4A9);
      case UrineColorType.fair:
        return const Color(0xFFFBE972);
      case UrineColorType.lightHydrated:
        return const Color(0xFFEBA139);
      case UrineColorType.dehydrated:
        return const Color(0xFFDE6F2B);
      case UrineColorType.veryDehydrated:
        return const Color(0xFFDE6F2B);
      case UrineColorType.severeDehydrated:
        return const Color(0xFFD23C20);
    }
  }

  String get title {
    switch (this) {
      case UrineColorType.overhydrated:
        return Get.find<DashboardController>().localization.hydrationOverhydrated ?? 'Overhydrated';
      case UrineColorType.good:
        return Get.find<DashboardController>().localization.hydrationGood ?? 'Good';
      case UrineColorType.fair:
        return Get.find<DashboardController>().localization.hydrationFair ?? 'Fair';
      case UrineColorType.lightHydrated:
        return Get.find<DashboardController>().localization.hydrationLightDehydrated ?? 'Light Hydrated';
      case UrineColorType.dehydrated:
        return Get.find<DashboardController>().localization.hydrationDehydrated ?? 'Dehydrated';
      case UrineColorType.veryDehydrated:
        return Get.find<DashboardController>().localization.hydrationVeryDehydrated ?? 'Very Dehydrated';
      case UrineColorType.severeDehydrated:
        return Get.find<DashboardController>().localization.hydrationSevereDehydrated ?? 'Severe Dehydrated';
    }
  }

  String get colorName {
    switch (this) {
      case UrineColorType.overhydrated:
        return Get.find<DashboardController>().localization.hydrationNoColor ?? 'No Color';
      case UrineColorType.good:
        return Get.find<DashboardController>().localization.hydrationPaleStrawYellow ?? 'Pale Straw Yellow';
      case UrineColorType.fair:
        return Get.find<DashboardController>().localization.hydrationTranslucentYellow ?? 'Translucent Yellow';
      case UrineColorType.lightHydrated:
        return Get.find<DashboardController>().localization.hydrationDarkYellow ?? 'Dark Yellow';
      case UrineColorType.dehydrated:
        return Get.find<DashboardController>().localization.hydrationAmber ?? 'Amber';
      case UrineColorType.veryDehydrated:
        return Get.find<DashboardController>().localization.hydrationBurntOrange ?? 'Burnt Orange';
      case UrineColorType.severeDehydrated:
        return Get.find<DashboardController>().localization.hydrationRed ?? 'Red';
    }
  }

  String get description {
    switch (this) {
      case UrineColorType.overhydrated:
        return "Time to Slow The Flow";
      case UrineColorType.veryDehydrated:
      case UrineColorType.severeDehydrated:
        return Get.find<DashboardController>().localization.hydrationSeeDoctor ?? 'See Doctor';
      case UrineColorType.good:
      case UrineColorType.fair:
        return Get.find<DashboardController>().localization.hydrationNormal ?? 'Normal';
      case UrineColorType.lightHydrated:
      case UrineColorType.dehydrated:
        return Get.find<DashboardController>().localization.hydrationDrinkWaterNow ?? 'Drink Water Now';
    }
  }
}
