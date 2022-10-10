import 'package:get/state_manager.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:livewell/feature/food/domain/usecase/get_food_history.dart';
import 'package:get/get.dart';

import '../../../diary/domain/entity/user_meal_history_model.dart';

class FoodController extends GetxController {
  var firstValue = 0.0.obs;
  var secondValue = 0.0.obs;
  var thirdValue = 0.0.obs;
  var dashboardData = Get.find<DashboardController>().dashboard;

  GetUserMealHistory getUserMealHistory = GetUserMealHistory.instance();
  RxList<MealHistoryModel> mealHistory = <MealHistoryModel>[].obs;
  Rx<bool> isLoadingHistory = false.obs;

  @override
  void onInit() {
    fetchUserMealHistory();
    super.onInit();
  }

  void fetchUserMealHistory() async {
    isLoadingHistory.value = true;
    final result = await getUserMealHistory(UserMealHistoryParams(
        filter: Filter(
            endDate: DateTime.now(),
            startDate: DateTime.now().add(const Duration(days: 1)))));
    isLoadingHistory.value = false;
    result.fold((l) => print(l), (r) {
      mealHistory.value = r.response ?? [];
    });
  }

  @override
  void onReady() {
    firstValue.value = 50.0;
    secondValue.value = 40.0;
    thirdValue.value = 30.0;
  }

  @override
  void dispose() {
    firstValue.value = 0;
    secondValue.value = 0;
    thirdValue.value = 0;
    super.dispose();
  }

  Rx<int> percentageOfDailyGoals() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.caloriesTaken == null) {
        return 0.obs;
      }
      if (dashboardData.value.dashboard!.target == null) {
        return 0.obs;
      }
      var result = ((dashboardData.value.dashboard!.caloriesTaken! /
              dashboardData.value.dashboard!.target!) *
          100);
      if (result.isNaN || result.isInfinite) {
        return 0.obs;
      }
      return result.round().obs;
    } else {
      return 0.obs;
    }
  }

  Rx<int> getTotalCal() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.caloriesTaken == null) {
        return 0.obs;
      }
      return dashboardData.value.dashboard!.caloriesTaken!.round().obs;
    } else {
      return 0.obs;
    }
  }

  Rx<int> getTotalMacroNut() {
    if (dashboardData.value.dashboard != null) {
      var carbs = dashboardData.value.dashboard!.totalCarbsInG ?? 0;
      var protein = dashboardData.value.dashboard!.totalProteinInG ?? 0;
      var fat = dashboardData.value.dashboard!.totalFatsInG ?? 0;
      return (carbs + protein + fat).obs;
    } else {
      return 0.obs;
    }
  }
}
