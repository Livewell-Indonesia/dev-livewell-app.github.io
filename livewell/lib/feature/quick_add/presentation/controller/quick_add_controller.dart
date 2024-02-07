import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/food/domain/entity/add_meal_param.dart';
import 'package:livewell/feature/food/domain/usecase/add_meal.dart';
import 'package:livewell/feature/food/presentation/controller/food_controller.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/core/base/base_controller.dart';

class QuickAddController extends BaseController {
  TextEditingController foodName = TextEditingController();
  TextEditingController calories = TextEditingController();
  TextEditingController fat = TextEditingController();
  TextEditingController carbs = TextEditingController();
  TextEditingController protein = TextEditingController();
  Rx<bool> formValid = false.obs;

  @override
  void onInit() {
    foodName.addListener(() {
      isValid();
    });

    calories.addListener(() {
      isValid();
    });

    fat.addListener(() {
      isValid();
    });

    carbs.addListener(() {
      isValid();
    });

    protein.addListener(() {
      isValid();
    });
    super.onInit();
  }

  void postData(MealTime mealTime) async {
    EasyLoading.show();
    var data = AddMealParams(
      mealName: foodName.text,
      numberOfUnits: "1",
      mealType: mealTime.name,
      mealAt: DateFormat('yyyy-MM-dd HH:mm:ss.sss').format(DateTime.now()),
      nutritions: Nutritions(
        calories: Nutrition(
          unit: 'g',
          value: int.parse(calories.text),
        ),
        fat: Nutrition(
          unit: 'g',
          value: int.parse(fat.text),
        ),
        carbohydrates: Nutrition(
          unit: 'g',
          value: int.parse(carbs.text),
        ),
        protein: Nutrition(
          unit: 'g',
          value: int.parse(protein.text),
        ),
      ),
    );
    AddMeal addMeal = AddMeal.instance();
    var result = await addMeal(data);
    EasyLoading.dismiss();
    result.fold((l) {}, (r) {
      Get.find<DashboardController>().onInit();
      if (Get.isRegistered<FoodController>()) {
        Get.find<FoodController>().fetchUserMealHistory();
      }
      AppNavigator.popUntil(routeName: AppPages.home);
    });
  }

  void isValid() {
    formValid.value = (foodName.text.isNotEmpty &&
        calories.text.isNotEmpty &&
        fat.text.isNotEmpty &&
        carbs.text.isNotEmpty &&
        protein.text.isNotEmpty);
  }
}
