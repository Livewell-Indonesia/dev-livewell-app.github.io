import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/food/domain/entity/meal_history.dart';
import 'package:livewell/feature/food/domain/usecase/add_meal.dart';
import 'package:livewell/feature/food/domain/usecase/add_meal_history.dart';
import 'package:livewell/feature/food/presentation/controller/food_controller.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';

import '../../../../routes/app_navigator.dart';
import '../../data/model/foods_model.dart';
import '../../domain/entity/add_meal_param.dart';

class AddFoodController extends GetxController {
  TextEditingController numberOfServing = TextEditingController();
  TextEditingController servingSize = TextEditingController();
  TextEditingController time = TextEditingController();
  Rx<String> selectedTime = "".obs;

  AddMeal addMeal = AddMeal.instance();
  AddMealHistory addMealHistory = AddMealHistory.instance();

  void addMeals(Foods food, MealTime mealTime) async {
    await EasyLoading.show();
    inspect(food);
    inspect(AddMealParams.asParams(food, mealTime, selectedTime.value));
    final result = await addMeal
        .call(AddMealParams.asParams(food, mealTime, selectedTime.value));
    await addMealHistory
        .call(MealHistory(date: selectedTime.value, mealType: mealTime.name));
    Get.find<DashboardController>().getMealHistories();
    Get.find<FoodController>().fetchUserMealHistory();
    await EasyLoading.dismiss();
    result.fold((l) {
      print(l);
    }, (r) {
      AppNavigator.popUntil(routeName: AppPages.home);
    });
  }

  Rx<int> percentOfDailyGoals(int cal) {
    var dailyTarget =
        Get.find<DashboardController>().dashboard.value.dashboard?.target ?? 0;
    var percent = (cal / dailyTarget) * 100;
    return percent.toInt().obs;
  }
}
