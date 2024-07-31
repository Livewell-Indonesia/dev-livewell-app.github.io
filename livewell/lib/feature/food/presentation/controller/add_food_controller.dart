import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/controller/user_diary_controller.dart';
import 'package:livewell/feature/food/domain/entity/meal_history.dart';
import 'package:livewell/feature/food/domain/usecase/add_meal.dart';
import 'package:livewell/feature/food/domain/usecase/add_meal_history.dart';
import 'package:livewell/feature/food/presentation/controller/add_meal_controller.dart';
import 'package:livewell/feature/food/presentation/controller/food_controller.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/nutrico/presentation/controller/nutrico_controller.dart';
import 'package:livewell/feature/nutrico/presentation/controller/nutricoplus_controller.dart';
import 'package:livewell/routes/app_navigator.dart';

import '../../data/model/foods_model.dart';
import '../../domain/entity/add_meal_param.dart';
import 'package:livewell/core/base/base_controller.dart';

class AddFoodController extends BaseController {
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
        numberOfServing.text.trim().replaceAll(',', '.');
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

    // convert selectedTime to DateTime
    var date = DateTime.parse(selectedTime.value);
    if (Get.arguments != null) {
      var secondDate = Get.arguments['date'] as DateTime;
      date = DateTime(secondDate.year, secondDate.month, secondDate.day, date.hour, date.minute, date.second);
    }
    final param = AddMealParams.asParams(food, numberOfServing.text.trim().replaceAll(',', '.'), mealTime, date.toString());
    final result = await addMeal.call(param);
    await addMealHistory.call(MealHistory(date: date.toString(), mealType: mealTime.name));
    Get.find<DashboardController>().onInit();
    if (Get.isRegistered<FoodController>()) {
      Get.find<FoodController>().fetchUserMealHistory();
    }
    await EasyLoading.dismiss();
    result.fold((l) {
      Log.error(l.toString());
    }, (r) {
      if (Get.isRegistered<AddMealController>()) {
        Get.find<AddMealController>().addedFoods.add(food);
      }
      if (Get.isRegistered<UserDiaryController>()) {
        Get.find<UserDiaryController>().refreshList();
      }
      if (Get.isRegistered<NutriCoController>() || Get.isRegistered<NutricoPlusController>()) {
        AppNavigator.popUntil(routeName: AppPages.home);
      } else {
        Get.back();
      }
    });
  }

  Rx<int> percentOfDailyGoals(num cal) {
    var dailyTarget = Get.find<DashboardController>().dashboard.value.dashboard?.target ?? 0;
    var percent = (cal / dailyTarget) * 100;
    if (percent.isNaN || percent.isInfinite) {
      return 0.obs;
    }
    return percent.toInt() > 100 ? 100.obs : percent.toInt().obs;
  }

  Rx<double> getTotalCalByServings(num cal) {
    var totalCal = 0.0;
    if (numberOfServing.text.isNotEmpty) {
      totalCal = cal * double.parse(numberOfServing.text.trim().replaceAll(',', '.'));
    }
    return totalCal.obs;
  }

  Rx<double> getTotalCarbsByServings(num carbs) {
    var totalCarbs = 0.0;
    if (numberOfServing.text.isNotEmpty) {
      totalCarbs = carbs * double.parse(numberOfServing.text.trim().replaceAll(',', '.'));
    } else {
      totalCarbs = carbs * 0;
    }
    return totalCarbs.obs;
  }

  Rx<double> getTotalFatByServings(num fat) {
    var totalFat = 0.0;
    if (numberOfServing.text.isNotEmpty) {
      totalFat = fat * double.parse(numberOfServing.text.trim().replaceAll(',', '.'));
    } else {
      totalFat = fat * 0;
    }
    return totalFat.obs;
  }

  Rx<double> getTotalProteinByServings(num protein) {
    var totalProtein = 0.0;
    var servings = numberOfServing.text.trim().replaceAll(',', '.');
    if (servings.isNotEmpty) {
      totalProtein = protein * double.parse(servings);
    } else {
      totalProtein = protein * 0;
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
