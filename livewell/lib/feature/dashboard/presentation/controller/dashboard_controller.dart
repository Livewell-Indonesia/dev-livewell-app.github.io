import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_health_fit/flutter_health_fit.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/data/model/dashboard_model.dart';
import 'package:livewell/feature/dashboard/data/model/user_model.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_dashboard_data.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_user.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:livewell/feature/food/domain/entity/meal_history.dart';
import 'package:livewell/feature/food/domain/usecase/get_meal_history.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../diary/domain/entity/user_meal_history_model.dart';
import '../../../exercise/domain/usecase/post_exercise_data.dart';
import 'dart:core';

class DashboardController extends GetxController {
  GetUser getUser = GetUser.instance();
  GetMealHistory getMealHistory = GetMealHistory.instance();
  GetDashboardData getDashboardData = GetDashboardData.instance();
  Rx<UserModel> user = UserModel().obs;
  Rx<DashboardModel> dashboard = DashboardModel().obs;
  ValueNotifier<double> valueNotifier = ValueNotifier(0.0);
  GetUserMealHistory getUserMealHistory = GetUserMealHistory.instance();
  RxList<MealHistoryModel> mealHistoryList = <MealHistoryModel>[].obs;

  HealthFactory healthFactory = HealthFactory();
  FlutterHealthFit healthFit = FlutterHealthFit();

  var types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_IN_BED,
  ];

  var permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  void requestHealthAccess() async {
    final permissionStatus = await Permission.activityRecognition.request();
    if (permissionStatus.isGranted) {
      var isAllowed = await healthFactory.requestAuthorization(types,
          permissions: permissions);
      if (isAllowed) {
        fetchHealthDataFromTypes();
        testingSleepNew();
        // var checkSleepPermission = await healthFactory.requestAuthorization(
        //     [HealthDataType.SLEEP_IN_BED],
        //     permissions: [HealthDataAccess.READ]);
        // if (checkSleepPermission) {
        //   fetchSleepData();
        // }
      }
      Log.colorGreen("Permission granted");
    } else {
      Log.error("Permission denied");
    }
    // if (Platform.isAndroid) {
    // } else {
    //   var isAllowed = await healthFactory.requestAuthorization(types,
    //       permissions: permissions);
    //   if (isAllowed) {
    //     fetchHealthDataFromTypes();
    //     testingSleepNew();
    //   }
    // }
  }

  Future<List<HealthDataPoint>> fetchSleepData() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day - 7, 12, 0, 0, 0, 0);
    var dateTill = currentDate.add(const Duration(days: 1));
    List<HealthDataPoint> healthData = await healthFactory
        .getHealthDataFromTypes(
            currentDate, dateTill, [HealthDataType.SLEEP_IN_BED]);
    return healthData;
  }

  void fetchHealthDataFromTypes() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 59, 0, 0);
    List<HealthDataPoint> healthData = await healthFactory
        .getHealthDataFromTypes(currentDate, dateTill,
            [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED]);
    Log.info(jsonEncode(healthData));
    inspect(healthData);
    PostExerciseData postExerciseData = PostExerciseData.instance();
    var lastSyncHealth = user.value.lastSyncedAt;
    // if user ever synced data
    if (lastSyncHealth != null && healthData.isNotEmpty) {
      healthData.sort((a, b) => a.dateFrom.compareTo(b.dateFrom));
      var filteredData = healthData
          .where((element) => element.sourceName != "com.google.android.gms")
          .toList();
      var lastSyncDate = DateTime.parse(lastSyncHealth);
      if (lastSyncDate.isBefore(filteredData.last.dateTo)) {
        var filteredHealth = filteredData
            .where((element) => element.dateTo.isAfter(lastSyncDate))
            .toList();
        if (filteredHealth.isNotEmpty) {
          final result = await postExerciseData
              .call(PostExerciseParams.fromHealth(filteredHealth));
          result.fold((l) {
            Log.error(l);
          }, (r) async {
            if (filteredHealth.isNotEmpty) {
              await SharedPref.saveLastHealthSyncDate(
                  filteredHealth.last.dateTo);
            }
          });
        }
      } else {
        Log.info("no new data");
      }
      // if user never synced data
    } else if (healthData.isNotEmpty) {
      healthData.sort((a, b) => a.dateFrom.compareTo(b.dateFrom));
      var filteredData = healthData
          .where((element) => element.sourceName != "com.google.android.gms")
          .toList();
      final result = await postExerciseData
          .call(PostExerciseParams.fromHealth(filteredData));
      result.fold((l) {
        Log.error(l);
      }, (r) async {
        if (filteredData.isNotEmpty) {
          await SharedPref.saveLastHealthSyncDate(filteredData.last.dateTo);
        }
      });
    }
  }

  @override
  void onInit() {
    getUsersData();
    getDashBoardData();
    getMealHistories();
    super.onInit();
  }

  void testingSleepNew() async {
    if (await healthFit.isSleepAuthorized()) {
      var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day - 1, 12, 0, 0, 0, 0);
      var dateTill = currentDate.add(const Duration(days: 1));
      List<CustomHealthDataPoint> newData = [];
      if (Platform.isIOS) {
        await fetchSleepIOS(currentDate, dateTill, newData);
      } else {
        await fetchSleepAndroid(currentDate, dateTill, newData);
      }
    }
  }

  Future<void> fetchSleepIOS(DateTime currentDate, DateTime dateTill,
      List<CustomHealthDataPoint> newData) async {
    var data = await healthFit.getSleepIOS(
        currentDate.millisecondsSinceEpoch, dateTill.millisecondsSinceEpoch);
    if (data != null) {
      var filteredData = data.where((element) =>
          element.type == SleepSampleType.asleepCore ||
          element.type == SleepSampleType.asleepDeep);
      if (filteredData.isNotEmpty) {
        for (var item in filteredData) {
          newData.add(item.toCustomHealthDataPoint(
              Platform.isAndroid ? PlatformType.ANDROID : PlatformType.IOS,
              item.type == SleepSampleType.asleepCore
                  ? "LIGHT_SLEEP"
                  : "DEEP_SLEEP"));
        }
        await saveData(newData);
      } else {
        var filteredData2 = data.where((element) =>
            element.type == SleepSampleType.inBed ||
            element.type == SleepSampleType.asleepUnspecified);
        if (filteredData.isNotEmpty) {
          for (var item in filteredData2) {
            if (item.type == SleepSampleType.asleepUnspecified ||
                item.type == SleepSampleType.inBed) {
              // split sleep value to deep and light sleep
              var sleepValue = item.end.difference(item.start).inMinutes;
              newData.add(CustomHealthDataPoint(
                  value: sleepValue,
                  type: "SLEEP_IN_BED",
                  unit: "MINUTES",
                  startDate: item.start,
                  endDate: item.end,
                  source: item.source));
            }
          }
          await saveData(newData);
        }
      }
    }
  }

  Future<void> fetchSleepAndroid(DateTime currentDate, DateTime dateTill,
      List<CustomHealthDataPoint> newData) async {
    var data = await healthFit.getSleepAndroid(
        currentDate.millisecondsSinceEpoch, dateTill.millisecondsSinceEpoch);
    if (data != null) {
      var filteredData = data
          .where((element) =>
              element.gfSleepSampleType == GFSleepSampleType.sleepLight ||
              element.gfSleepSampleType == GFSleepSampleType.sleepDeep)
          .toList();
      if (filteredData.isNotEmpty) {
        for (var item in filteredData) {
          newData.add(item.toCustomHealthDataPoint(
              Platform.isAndroid ? PlatformType.ANDROID : PlatformType.IOS,
              item.gfSleepSampleType == GFSleepSampleType.sleepLight
                  ? "LIGHT_SLEEP"
                  : "DEEP_SLEEP"));
        }
        await saveData(newData);
      } else {
        var filteredData2 = data
            .where((element) =>
                element.gfSleepSampleType == GFSleepSampleType.unspecified)
            .toList();
        Log.info(filteredData2);
        if (filteredData2.isNotEmpty) {
          for (var item in filteredData2) {
            if (item.gfSleepSampleType == GFSleepSampleType.unspecified) {
              // split sleep value to deep and light sleep
              var sleepValue = item.end.difference(item.start).inMinutes;
              newData.add(CustomHealthDataPoint(
                  value: sleepValue,
                  type: "SLEEP_IN_BED",
                  unit: "MINUTES",
                  startDate: item.start,
                  endDate: item.end,
                  source: item.source));
              // var lightSleep = sleepValue * 0.8;
              // var deepSleep = sleepValue * 0.2;
              // newData.add(CustomHealthDataPoint(
              //     value: lightSleep,
              //     type: 'LIGHT_SLEEP',
              //     unit: 'MINUTES',
              //     startDate: item.start,
              //     endDate:
              //         item.start.add(Duration(minutes: lightSleep.toInt())),
              //     source: item.source));
              // newData.add(CustomHealthDataPoint(
              //     value: deepSleep,
              //     type: 'DEEP_SLEEP',
              //     unit: 'MINUTES',
              //     startDate:
              //         item.end.subtract(Duration(minutes: deepSleep.toInt())),
              //     endDate: item.end,
              //     source: item.source));
            }
          }
          await saveData(newData);
        }
      }
    }
  }

  Future<void> saveData(List<CustomHealthDataPoint> newData) async {
    var lastSyncHealth = user.value.lastSyncedAt;
    if (lastSyncHealth != null && newData.isNotEmpty) {
      newData.sort((a, b) => a.startDate.compareTo(b.startDate));
      var lastSyncDate = DateTime.parse(lastSyncHealth);
      if (lastSyncDate.isBefore(newData.last.endDate)) {
        var filteredHealth = newData
            .where((element) => element.endDate.isAfter(lastSyncDate))
            .toList();
        if (filteredHealth.isNotEmpty) {
          var postSleepData = PostExerciseData.instance();
          final result = await postSleepData
              .call(PostExerciseParams.fromCustomHealth(filteredHealth));
          result.fold((l) {
            Log.error(l);
          }, (r) async {});
        }
      } else {
        Log.info("no new data");
      }
    } else if (newData.isNotEmpty && lastSyncHealth == null) {
      newData.sort((a, b) => a.startDate.compareTo(b.startDate));
      var postSleepData = PostExerciseData.instance();
      final result = await postSleepData
          .call(PostExerciseParams.fromCustomHealth(newData));
      result.fold((l) {
        Log.error(l);
      }, (r) async {});
    }
  }

  void getMealHistories() async {
    var currentDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
    final result = await getUserMealHistory(UserMealHistoryParams(
        filter: Filter(
            endDate: currentDate,
            startDate: currentDate.add(const Duration(seconds: 86399)))));
    result.fold((l) {}, (r) {
      mealHistoryList.value = r.response ?? [];
    });
  }

  void getUsersData() async {
    var result = await getUser(NoParams());
    result.fold((l) => print(l), (r) {
      user.value = r;
      inspect(r);
      if (r.onboardingQuestionnaire == null &&
          Get.currentRoute == AppPages.home) {
        Future.delayed(Duration(milliseconds: 800), () {
          AppNavigator.push(routeName: AppPages.questionnaire);
        });
      } else {
        requestHealthAccess();
      }
    });
  }

  void getDashBoardData() async {
    var result = await getDashboardData(NoParams());
    result.fold((l) => print(l), (r) {
      inspect(r);
      dashboard.value = r;
      if ((dashboard.value.dashboard?.target ?? 0) == 0) {
        valueNotifier.value = 0;
      } else if ((dashboard.value.dashboard?.caloriesTaken ?? 0) == 0) {
        valueNotifier.value = 0;
      } else if ((dashboard.value.dashboard?.caloriesTaken ?? 0) >=
          (dashboard.value.dashboard?.target ?? 0)) {
        valueNotifier.value = 1;
      } else {
        valueNotifier.value = (dashboard.value.dashboard?.caloriesTaken ?? 0) /
            (dashboard.value.dashboard?.target ?? 0);
      }
    });
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  Rx<double> getWeightPercentage() {
    var currentWeight = user.value.weight;
    var targetWeight = user.value.weightTarget;
    var percentage = 0.0.obs;

    if (user.value.weight == null || user.value.weight == 0) {
      return percentage;
    }
    if (user.value.weightTarget == null || user.value.weightTarget == 0) {
      return percentage;
    }
    if (currentWeight! > targetWeight!) {
      percentage.value = (1 - (currentWeight - targetWeight) / currentWeight);
    } else {
      percentage.value = (1 - (targetWeight - currentWeight) / currentWeight);
    }
    return percentage;
  }

  RxString remainingCalToShow() {
    var remaining = dashboard.value.dashboard?.caloriesLeft ?? 0;
    var remainingCal = remaining.toString().obs;
    if (remaining < 0) {
      remainingCal.value = '+ ${remaining * -1}';
    }
    return remainingCal;
  }

  Rx<bool> isCompleted(int index) {
    // cek user udah pernah makan atau belum
    if (mealHistoryList.isEmpty) {
      return false.obs;
    } else {
      for (var element in mealHistoryList) {
        if (element.mealType?.toLowerCase() ==
            user.value.dailyJournal![index].name?.toLowerCase()) {
          var d1 = DateTime.parse(element.mealAt!);
          var d2 = DateTime.now();
          if (d1.day == d2.day && d1.month == d2.month && d1.year == d2.year) {
            return true.obs;
          } else {
            return false.obs;
          }
        }
      }
      return false.obs;
    }
  }

  Rx<num> totalCarbs() {
    var total = 0.0.obs;
    if (user.value.bmr == null) {
      return total;
    } else {
      var bmr = dashboard.value.dashboard?.totalCalories ?? 0;
      total = ((0.5 * bmr) / 4).obs;
      return total;
    }
  }

  Rx<num> totalProtein() {
    var total = 0.0.obs;
    if (user.value.bmr == null) {
      return total;
    } else {
      var bmr = dashboard.value.dashboard?.totalCalories ?? 0;
      total = ((0.2 * bmr) / 4).obs;
      return total;
    }
  }

  Rx<num> totalFat() {
    var total = 0.0.obs;
    if (user.value.bmr == null) {
      return total;
    } else {
      var bmr = dashboard.value.dashboard?.totalCalories ?? 0;
      total = ((0.3 * bmr) / 9).obs;
      return total;
    }
  }
}

extension on SleepSample {
  HealthDataPoint toHealthDataPoint(PlatformType platformType) {
    var value = end.difference(start).inMinutes;
    return HealthDataPoint(
        NumericHealthValue(value),
        HealthDataType.SLEEP_IN_BED,
        HealthDataUnit.MINUTE,
        start,
        end,
        platformType,
        "",
        source,
        source);
  }

  CustomHealthDataPoint toCustomHealthDataPoint(
      PlatformType platformType, String type) {
    var value = end.difference(start).inMinutes;
    return CustomHealthDataPoint(
        value: value,
        type: type,
        unit: 'MINUTES',
        startDate: start,
        endDate: end,
        source: source);
  }
}

extension on GFSleepSample {
  CustomHealthDataPoint toCustomHealthDataPoint(
      PlatformType platformType, String type) {
    var value = end.difference(start).inMinutes;
    return CustomHealthDataPoint(
        value: value,
        type: type,
        unit: 'MINUTES',
        startDate: start,
        endDate: end,
        source: source);
  }
}

class CustomHealthDataPoint {
  num value;
  String type;
  String unit;
  DateTime startDate;
  DateTime endDate;
  String source;

  CustomHealthDataPoint(
      {required this.value,
      required this.type,
      required this.unit,
      required this.startDate,
      required this.endDate,
      required this.source});

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'data_type': type,
      'unit': unit,
      'date_from': startDate.toIso8601String(),
      'date_to': endDate.toIso8601String(),
      'source_name': source,
    };
  }
}
