import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/domain/usecase/add_meal.dart';
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

  void addMeals(Foods food, MealTime mealTime) async {
    EasyLoading.show();
    inspect(food);
    inspect(AddMealParams.asParams(food, mealTime, selectedTime.value));
    final result = await addMeal
        .call(AddMealParams.asParams(food, mealTime, selectedTime.value));
    EasyLoading.dismiss();
    result.fold((l) {
      print(l);
    }, (r) {
      AppNavigator.popUntil(routeName: AppPages.home);
    });
  }
}
