import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health/health.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_app_config.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';

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
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_IN_BED,
  ];

  var permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  @override
  void onInit() {
    getAppConfig();
    requestHealthAccess();
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
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 59, 0, 0);
    List<HealthDataPoint> healthData = await healthFactory
        .getHealthDataFromTypes(currentDate, dateTill, types);
    Get.snackbar('health', healthData.toString());
    Log.info(jsonEncode(healthData));
    PostExerciseData postExerciseData = PostExerciseData.instance();
    var lastSyncHealth = await SharedPref.getLastHealthSyncDate();
    // if user ever synced data
    if (lastSyncHealth != null && healthData.isNotEmpty) {
      healthData.sort((a, b) => a.dateFrom.compareTo(b.dateFrom));
      var lastSyncDate = DateTime.parse(lastSyncHealth);
      if (lastSyncDate.isBefore(healthData.last.dateTo)) {
        var filteredHealth = healthData
            .where((element) => element.dateTo.isAfter(lastSyncDate))
            .toList();
        Log.info("new data: ${filteredHealth.length}");
        final result = await postExerciseData
            .call(PostExerciseParams.fromHealth(filteredHealth));
        result.fold((l) {
          print(l);
        }, (r) async {
          await SharedPref.saveLastHealthSyncDate(healthData.last.dateTo);
        });
      } else {
        Log.info("no new data");
      }
      // if user never synced data
    } else if (healthData.isNotEmpty) {
      final result = await postExerciseData
          .call(PostExerciseParams.fromHealth(healthData));
      result.fold((l) {
        print(l);
      }, (r) async {
        await SharedPref.saveLastHealthSyncDate(healthData.last.dateTo);
      });
    }
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
