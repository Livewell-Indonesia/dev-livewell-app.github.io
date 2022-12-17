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

  @override
  void onInit() {
    super.onInit();
    numberOfServing.addListener(() {
      if (numberOfServing.text.isNotEmpty && numberOfServing.text.isNum) {
        update();
      }
    });
  }

  @override
  void dispose() {
    numberOfServing.dispose();
    servingSize.dispose();
    time.dispose();
    super.dispose();
  }

  void addMeals(Foods food, MealTime mealTime) async {
    await EasyLoading.show();
    inspect(food);
    inspect(AddMealParams.asParams(
        food, numberOfServing.text, mealTime, selectedTime.value));
    final result = await addMeal.call(AddMealParams.asParams(
        food, numberOfServing.text, mealTime, selectedTime.value));
    await addMealHistory
        .call(MealHistory(date: selectedTime.value, mealType: mealTime.name));
    Get.find<DashboardController>().onInit();
    if (Get.isRegistered<FoodController>()) {
      Get.find<FoodController>().fetchUserMealHistory();
    }
    await EasyLoading.dismiss();
    result.fold((l) {
      print(l);
    }, (r) {
      AppNavigator.popUntil(routeName: AppPages.home);
    });
  }

  Rx<int> percentOfDailyGoals(num cal) {
    var dailyTarget =
        Get.find<DashboardController>().dashboard.value.dashboard?.target ?? 0;
    var percent = (cal / dailyTarget) * 100;
    return percent.toInt() > 100 ? 100.obs : percent.toInt().obs;
  }

  Rx<double> getTotalCalByServings(num cal) {
    var totalCal = 0.0;
    if (numberOfServing.text.isNotEmpty) {
      totalCal = cal * double.parse(numberOfServing.text);
    }
    return totalCal.obs;
  }

  Rx<double> getTotalCarbsByServings(num carbs) {
    var totalCarbs = 0.0;
    if (numberOfServing.text.isNotEmpty) {
      totalCarbs = carbs * double.parse(numberOfServing.text);
    }
    return totalCarbs.obs;
  }

  Rx<double> getTotalFatByServings(num fat) {
    var totalFat = 0.0;
    if (numberOfServing.text.isNotEmpty) {
      totalFat = fat * double.parse(numberOfServing.text);
    }
    return totalFat.obs;
  }

  Rx<double> getTotalProteinByServings(num protein) {
    var totalProtein = 0.0;
    if (numberOfServing.text.isNotEmpty) {
      totalProtein = protein * double.parse(numberOfServing.text);
    }
    return totalProtein.obs;
  }

  double maxHundred(double value) {
    if (value >= 100) {
      return 100;
    } else {
      return value;
    }
  }

  // create a list of time
  List<String> timeList = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Snack",
  ];
}
