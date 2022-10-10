import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/data/model/dashboard_model.dart';
import 'package:livewell/feature/dashboard/data/model/user_model.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_dashboard_data.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_user.dart';
import 'package:livewell/feature/food/domain/entity/meal_history.dart';
import 'package:livewell/feature/food/domain/usecase/get_meal_history.dart';
import 'package:livewell/routes/app_navigator.dart';

class DashboardController extends GetxController {
  GetUser getUser = GetUser.instance();
  GetMealHistory getMealHistory = GetMealHistory.instance();
  GetDashboardData getDashboardData = GetDashboardData.instance();
  Rx<UserModel> user = UserModel().obs;
  Rx<DashboardModel> dashboard = DashboardModel().obs;
  Rx<MealHistories> mealHistory = MealHistories().obs;
  ValueNotifier<double> valueNotifier = ValueNotifier(0.0);
  @override
  void onInit() {
    getUsersData();
    getDashBoardData();
    getMealHistories();
    super.onInit();
  }

  void getMealHistories() async {
    final result = await getMealHistory(NoParams());
    result.fold((failure) {
      Log.error(failure.toString());
    }, (mealHistory) {
      Log.colorGreen(mealHistory.mealHistories?.length.toString());
      inspect(mealHistory);
      this.mealHistory.value = mealHistory;
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
      } else {
        valueNotifier.value = 1 -
            (dashboard.value.dashboard?.caloriesTaken ?? 0) /
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

  Rx<bool> isCompleted(int index) {
    // cek user udah pernah makan atau belum
    if (mealHistory.value.mealHistories == null) {
      return false.obs;
    } else {
      for (var element in mealHistory.value.mealHistories!) {
        if (element.mealType?.toUpperCase() ==
            user.value.dailyJournal![index].name?.toUpperCase()) {
          var d1 = DateTime.parse(element.date!);
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
}
