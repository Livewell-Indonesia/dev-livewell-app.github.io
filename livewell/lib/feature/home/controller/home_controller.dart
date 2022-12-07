import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:health/health.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_app_config.dart';

import '../../../core/base/usecase.dart';
import '../../dashboard/data/model/app_config_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<HomeTab> currentMenu = HomeTab.home.obs;

  GetAppConfig appConfig = GetAppConfig.instance();
  Rx<AppConfigModel> appConfigModel = AppConfigModel().obs;

  HealthFactory healthFactory = HealthFactory();

  var types = [
    HealthDataType.STEPS,
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.BODY_MASS_INDEX,
    HealthDataType.BODY_FAT_PERCENTAGE,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_IN_BED,
    HealthDataType.BLOOD_OXYGEN,
  ];

  var permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  @override
  void onInit() {
    getAppConfig();
    //requestHealthAccess();
    super.onInit();
  }

  void requestHealthAccess() async {
    var isAllowed = await healthFactory.requestAuthorization(types,
        permissions: permissions);
    if (isAllowed) {
      fetchHealthDataFromTypes();
    }
  }

  void fetchHealthDataFromTypes() async {
    List<HealthDataPoint> healthData =
        await healthFactory.getHealthDataFromTypes(
      DateTime.now().subtract(Duration(days: 3)),
      DateTime.now(),
      types,
    );
    Get.snackbar('health', healthData.toString());
    print("andi ganteng ${healthData.first.unitString}");
    print("health data ${healthData.toString()}");
    Log.info(jsonEncode(healthData));
    inspect(healthData);
  }

  void getAppConfig() async {
    final result = await appConfig.call(NoParams());
    result.fold((l) {
      print(l);
    }, (r) {
      appConfigModel.value = r;
    });
  }

  void changePage(HomeTab tab) {
    currentMenu.value = tab;
  }

  void changePageIndex(int index) {
    if (index == 0) {
      currentMenu.value = HomeTab.food;
    } else if (index == 1) {
      currentMenu.value = HomeTab.home;
    } else if (index == 2) {
      currentMenu.value = HomeTab.exercise;
    } else if (index == 3) {
      currentMenu.value = HomeTab.account;
    }
  }

  Widget customSelectedImage(Widget child) {
    return ClipOval(
      child: Material(
          color: const Color(0xFF8F01DF), // button color
          child: SizedBox(width: 40.w, height: 40.w, child: child)),
    );
  }

  Widget customUnselectedImage(Widget child) {
    return SizedBox(
      width: 40.w,
      height: 40.w,
      child: child,
    );
  }
}

enum HomeTab {
  home,
  food,
  exercise,
  sleep,
  water,
  meditation,
  nutrition,
  account
}

extension HomeTabIcons on HomeTab {
  String selectedAssets() {
    switch (this) {
      case HomeTab.home:
        return Constant.icHomeSelected;
      case HomeTab.food:
        return Constant.icFoodSelected;
      case HomeTab.exercise:
        return Constant.icExerciseSelected;
      case HomeTab.sleep:
        return Constant.icSleepSelected;
      case HomeTab.water:
        return Constant.icWaterSelected;
      case HomeTab.meditation:
        return Constant.icMeditationSelected;
      case HomeTab.nutrition:
        return Constant.icBloodSelected;
      case HomeTab.account:
        return Constant.icBloodSelected;
    }
  }

  String unselectedAssets() {
    switch (this) {
      case HomeTab.home:
        return Constant.icHomeUnselected;
      case HomeTab.food:
        return Constant.icFoodUnselected;
      case HomeTab.exercise:
        return Constant.icExerciseUnselected;
      case HomeTab.sleep:
        return Constant.icSleepUnselected;
      case HomeTab.water:
        return Constant.icWaterUnselected;
      case HomeTab.meditation:
        return Constant.icMeditationUnselected;
      case HomeTab.nutrition:
        return Constant.icBloodUnselected;
      case HomeTab.account:
        return Constant.icBloodUnselected;
    }
  }

  Widget unselectedImage() {
    return Image.asset(
      unselectedAssets(),
      width: 40.w,
      height: 40.w,
    );
  }

  Widget selectedImage() {
    return ClipOval(
      child: Material(
          color: const Color(0xFF8F01DF), // button color
          child: Image.asset(selectedAssets(), width: 40.w, height: 40.w)),
    );
  }
}
