import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/get_meal_type_by_current_time.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/nutrico/domain/usecase/post_nutrico.dart';
import 'package:livewell/feature/nutrico/domain/usecase/search_by_image.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class NutricoPlusController extends GetxController {
  SearchByImage searchByImage = SearchByImage.instance();
  PostNutrico postNutrico = PostNutrico.instance();
  Rx<NutricoPlusState> state = NutricoPlusState.uploading.obs;
  Rx<String> imageUrl = ''.obs;
  Rx<String> description = ''.obs;
  Rx<String> foodName = ''.obs;

  Future<void> searchFoodByImage(File imageFile) async {
    final data = await searchByImage(imageFile);
    data.fold((l) {
      Get.back();
      showError();
    }, (r) async {
      state.value = NutricoPlusState.detectingImage;
      imageUrl.value = r.response?.imageUrl ?? '';
      foodName.value = r.response?.foodName ?? '';
      if (foodName.value.isNotEmpty && imageUrl.value.isNotEmpty) {
        await detectImage(foodName.value);
      } else {
        Get.back();
        showError();
      }
    });
  }

  Future<void> detectImage(String foodName) async {
    final data = await postNutrico(PostNutricoParams(foodName));
    Get.back();
    data.fold((l) {
      showError();
    }, (r) {
      state.value = NutricoPlusState.done;
      if (r.servings?.first != null) {
        var calories = num.tryParse(r.servings!.first.calories!);
        var fat = num.tryParse(r.servings!.first.fat!);
        var carbs = num.tryParse(r.servings!.first.carbohydrate!);
        var protein = num.tryParse(r.servings!.first.protein!);

        if (calories != null && fat != null && carbs != null && protein != null) {
          MealTime mealTime = getMealTypeByCurrentTime();
          AppNavigator.push(routeName: AppPages.addFood, arguments: {"date": DateTime.now(), "mealTime": mealTime, "food": r});
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
        shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
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
                  style: TextStyle(color: const Color(0xFF171433), fontSize: 24.sp, height: 32.sp / 24.sp, fontWeight: FontWeight.w600),
                ),
                8.verticalSpace,
                Text(
                  'there was an error in the system or the data you entered was not registered in our system.',
                  style: TextStyle(color: const Color(0xFF808080), fontSize: 16.sp, fontWeight: FontWeight.w500),
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

enum NutricoPlusState { uploading, detectingImage, done }

extension NutricoPlusStateExt on NutricoPlusState {
  String title() {
    switch (this) {
      case NutricoPlusState.uploading:
        return 'Analyzing Image';
      case NutricoPlusState.detectingImage:
        return 'Generating Nutrition';
      case NutricoPlusState.done:
        return 'Done';
    }
  }

  String subtitle() {
    switch (this) {
      case NutricoPlusState.uploading:
        return 'Please wait, currently analyzing the image';
      case NutricoPlusState.detectingImage:
        return 'Currently generating detailed nutrition';
      case NutricoPlusState.done:
        return 'Done';
    }
  }
}
