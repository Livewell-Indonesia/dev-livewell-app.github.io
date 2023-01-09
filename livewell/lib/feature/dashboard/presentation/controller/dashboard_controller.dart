import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
        var checkSleepPermission = await healthFactory.requestAuthorization(
            [HealthDataType.SLEEP_IN_BED],
            permissions: [HealthDataAccess.READ]);
        if (checkSleepPermission) {
          fetchSleepData();
        }
      }
      Log.colorGreen("Permission granted");
    } else {
      Log.error("Permission denied");
    }
    if (Platform.isAndroid) {
    } else {
      var isAllowed = await healthFactory.requestAuthorization(types,
          permissions: permissions);
      if (isAllowed) {
        fetchHealthDataFromTypes();
        var checkSleepPermission = await healthFactory.requestAuthorization(
            [HealthDataType.SLEEP_IN_BED],
            permissions: [HealthDataAccess.READ]);
        if (checkSleepPermission) {
          fetchSleepData();
        }
      }
    }
  }

  Future<List<HealthDataPoint>> fetchSleepData() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day - 1, 12, 0, 0, 0, 0);
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
    await fetchSleepData().then((value) {
      if (value.isNotEmpty) {
        healthData.add(value.first);
      }
    });
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
