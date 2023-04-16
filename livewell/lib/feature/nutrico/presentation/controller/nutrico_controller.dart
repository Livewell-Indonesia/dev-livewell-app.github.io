import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/presentation/pages/add_food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/nutrico/domain/usecase/post_nutrico.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:lottie/lottie.dart';

class NutriCoController extends GetxController {
  TextEditingController foodDescription = TextEditingController();
  Rx<bool> buttonEnabled = false.obs;
  @override
  void onInit() {
    foodDescription.addListener(() {
      buttonEnabled.value = foodDescription.text.isNotEmpty;
    });
    super.onInit();
  }

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
      showError();
    }, (r) {
      if (r.servings?.first != null) {
        var calories = num.tryParse(r.servings!.first.calories!);
        var fat = num.tryParse(r.servings!.first.fat!);
        var carbs = num.tryParse(r.servings!.first.carbohydrate!);
        var protein = num.tryParse(r.servings!.first.protein!);

        if (calories != null &&
            fat != null &&
            carbs != null &&
            protein != null) {
          MealTime mealTime = MealTime.values.byName(
              ((Get.arguments['type'] as String?) ?? MealTime.breakfast.name));
          Get.to(() => AddFoodScreen(food: r, mealTime: mealTime));
        } else {
          showError();
        }
      } else {
        showError();
      }
    });
  }

  void showError() {
    showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        shape: ShapeBorder.lerp(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            1),
        builder: ((context) {
          return Container(
            padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Food Failed',
                  style: TextStyle(
                      color: const Color(0xFF171433),
                      fontSize: 24.sp,
                      height: 32.sp / 24.sp,
                      fontWeight: FontWeight.w600),
                ),
                8.verticalSpace,
                Text(
                  'there was an error in the system or the data you entered was not registered in our system.',
                  style: TextStyle(
                      color: const Color(0xFF808080),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                32.verticalSpace,
                LiveWellButton(
                  label: 'Back',
                  color: const Color(0xFFDDF235),
                  textColor: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            ),
          );
        }));
  }
}
