import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/helper/get_meal_type_by_current_time.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/nutrico/domain/usecase/get_nutrico_plus_loading_asset.dart';
import 'package:livewell/feature/nutrico/domain/usecase/post_nutrico.dart';
import 'package:livewell/feature/nutrico/domain/usecase/search_by_image.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class NutricoPlusController extends BaseController {
  SearchByImage searchByImage = SearchByImage.instance();
  PostNutrico postNutrico = PostNutrico.instance();
  GetNutricoPlusLoadingAssets getNutricoPlusLoadingAssets = GetNutricoPlusLoadingAssets.instance();
  Rx<NutricoPlusState> state = NutricoPlusState.uploading.obs;
  Rx<String> imageUrl = ''.obs;
  Rx<String> description = ''.obs;
  Rx<String> foodName = ''.obs;
  Rx<String> title = ''.obs;
  Rx<String> assetUrl = ''.obs;
  Rx<String> loadingDescription = ''.obs;

  Future<void> searchFoodByImage(File imageFile) async {
    final loadingAssetData = await getNutricoPlusLoadingAssets(NoParams());
    loadingAssetData.fold((l) {
      Get.back();
      showError();
    }, (r) {
      final dataByLocalization = r.where((element) => element.language == currentLanguage().languageCode).toList();
      var random = Random();
      inspect(dataByLocalization);
      final randomizeData = dataByLocalization[random.nextInt(dataByLocalization.length)];
      title.value = randomizeData.title ?? "";
      description.value = randomizeData.belowPicture ?? "";
      assetUrl.value = randomizeData.video ?? "";
    });
    final data = await searchByImage(imageFile);
    data.fold((l) {
      if (l.code == 400) {
        Get.back();
        showError(title: 'Image Request Limit Reached', description: 'You have reached the limit of image requests');
      } else {
        Get.back();
        showError();
      }
    }, (r) async {
      state.value = NutricoPlusState.detectingImage;
      imageUrl.value = r.response?.imageUrl ?? '';
      foodName.value = r.response?.foodEstimation?.foodName ?? '';
      if (foodName.value.isNotEmpty && imageUrl.value.isNotEmpty) {
        MealTime mealTime = getMealTypeByCurrentTime();
        Get.find<DashboardController>().getFeatureLimitData();
        AppNavigator.push(routeName: AppPages.addFood, arguments: {
          "date": DateTime.now(),
          "mealTime": mealTime,
          "food": Foods.fromNutrico(r),
          "imageUrl": imageUrl.value,
        });
      } else {
        Get.back();
        showError();
      }
    });
  }

  void showError({String title = 'Add Food Failed', String description = 'there was an error in the system or the data you entered was not registered in our system.'}) {
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
                  title,
                  style: TextStyle(color: const Color(0xFF171433), fontSize: 24.sp, height: 32.sp / 24.sp, fontWeight: FontWeight.w600),
                ),
                8.verticalSpace,
                Text(
                  description,
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
