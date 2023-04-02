import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/presentation/pages/add_food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/nutrico/domain/usecase/post_nutrico.dart';
import 'package:lottie/lottie.dart';

class NutriCoController extends GetxController {
  TextEditingController foodDescription = TextEditingController();

  void postData() async {
    Get.dialog(Center(
      child: SizedBox(
        width: 200.h,
        height: 200.w,
        child: Lottie.asset('assets/jsons/99274-loading.json', repeat: true),
      ),
    ));
    final result =
        await PostNutrico.instance()(PostNutricoParams(foodDescription.text));
    Get.back();
    result.fold((l) {
      Get.snackbar('Error', l.toString());
    }, (r) {
      MealTime mealTime = MealTime.values.byName(
          ((Get.arguments['type'] as String?) ?? MealTime.breakfast.name));
      Get.to(() => AddFoodScreen(food: r, mealTime: mealTime));
      //Get.off(() => AddFoodScreen(food: r, mealTime: mealTime));
    });
  }
}
