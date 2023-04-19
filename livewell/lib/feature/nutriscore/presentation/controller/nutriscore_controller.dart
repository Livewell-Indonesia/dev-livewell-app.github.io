import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_detail_model.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';
import 'package:livewell/feature/nutriscore/domain/usecase/get_nutri_score.dart';
import 'package:livewell/feature/nutriscore/domain/usecase/get_nutri_score_detail.dart';
import 'package:livewell/routes/app_navigator.dart';

class NutriScoreController extends GetxController {
  Rx<NutriScoreModel> nutriScore = NutriScoreModel().obs;
  RxList<NutriscoreDetailModel> nutriScoreDetail =
      <NutriscoreDetailModel>[].obs;
  @override
  void onInit() {
    getNutriScore();
    getNutriscoreDetail();
    super.onInit();
  }

  void getNutriScore() async {
    var usecase = GetNutriScore.instance();
    final result = await usecase(NoParams());
    result.fold((l) {
      // handle error
      Get.snackbar('error', l.message ?? "");
    }, (r) {
      // handle success
      nutriScore.value = r;
    });
  }

  void getNutriscoreDetail() async {
    var usecase = GetNutriscoreDetail.instance();
    final result = await usecase(NoParams());
    result.fold((l) {
      // handle error
      Get.snackbar('error', l.message ?? "");
    }, (r) {
      // handle success
      nutriScoreDetail.value = r;
    });
  }

  void onNutrientTapped(NutrientType type) {
    if (nutriScoreDetail.isNotEmpty) {
      AppNavigator.push(
          routeName: AppPages.nutriScoreDetail,
          arguments: {'type': type, 'value': getNutrientByType(type)!.eaten});
    }
  }

  Nutrient? getNutrientByType(NutrientType type) {
    switch (type) {
      case NutrientType.water:
        return nutriScore.value.details?.water;
      case NutrientType.protein:
        return nutriScore.value.details?.protein;
      case NutrientType.carb:
        return nutriScore.value.details?.carb;
      case NutrientType.fat:
        return nutriScore.value.details?.fat;
      case NutrientType.sodium:
        return nutriScore.value.details?.sodium;
      case NutrientType.saturatedFat:
        return nutriScore.value.details?.saturatedFat;
      case NutrientType.monounsaturatedFat:
        return nutriScore.value.details?.monounsaturatedFat;
      case NutrientType.polyunsaturatedFat:
        return nutriScore.value.details?.polyunsaturatedFat;
      case NutrientType.calcium:
        return nutriScore.value.details?.calcium;
      case NutrientType.vitaminA:
        return nutriScore.value.details?.vitaminA;
      case NutrientType.vitaminC:
        return nutriScore.value.details?.vitaminC;
      case NutrientType.potassium:
        return nutriScore.value.details?.potassium;
      case NutrientType.transFat:
        return nutriScore.value.details?.transFat;
      case NutrientType.sugar:
        return nutriScore.value.details?.sugar;
      case NutrientType.fiber:
        return nutriScore.value.details?.fiber;
      case NutrientType.cholesterol:
        return nutriScore.value.details?.cholesterol;
    }
  }
}

enum NutrientType {
  water,
  protein,
  carb,
  fat,
  sodium,
  saturatedFat,
  monounsaturatedFat,
  polyunsaturatedFat,
  transFat,
  potassium,
  calcium,
  vitaminA,
  vitaminC,
  sugar,
  fiber,
  cholesterol,
}

extension NutrientTypeAtt on NutrientType {
  // create getter for title
  String title() {
    switch (this) {
      case NutrientType.water:
        return "Water";
      case NutrientType.protein:
        return "Protein";
      case NutrientType.carb:
        return "Carbohydrate";
      case NutrientType.fat:
        return "Fat";
      case NutrientType.sodium:
        return "Sodium";
      case NutrientType.saturatedFat:
        return "Saturated Fat";
      case NutrientType.monounsaturatedFat:
        return "Monounsaturated Fat";
      case NutrientType.polyunsaturatedFat:
        return "Polyunsaturated Fat";
      case NutrientType.calcium:
        return "Calcium";
      case NutrientType.vitaminA:
        return "Vitamin A";
      case NutrientType.vitaminC:
        return "Vitamin C";
      case NutrientType.potassium:
        return "Potassium";
      case NutrientType.transFat:
        return "Trans Fat";
      case NutrientType.sugar:
        return "Sugar";
      case NutrientType.fiber:
        return "Fiber";
      case NutrientType.cholesterol:
        return "Cholesterol";
    }
  }

  String jsonName() {
    switch (this) {
      case NutrientType.water:
        return 'water';
      case NutrientType.protein:
        return 'protein';
      case NutrientType.carb:
        return 'carb';
      case NutrientType.fat:
        return 'fat';
      case NutrientType.sodium:
        return 'sodium';
      case NutrientType.saturatedFat:
        return 'saturated_fat';
      case NutrientType.monounsaturatedFat:
        return 'monounsaturated_fat';
      case NutrientType.polyunsaturatedFat:
        return 'polyunsaturated_fat';
      case NutrientType.transFat:
        return 'trans_fat';
      case NutrientType.potassium:
        return 'potassium';
      case NutrientType.calcium:
        return 'calcium';
      case NutrientType.vitaminA:
        return 'vitamin_a';
      case NutrientType.vitaminC:
        return 'vitamin_c';
      case NutrientType.sugar:
        return 'sugar';
      case NutrientType.fiber:
        return 'fiber';
      case NutrientType.cholesterol:
        return 'cholesterol';
    }
  }

  String unit() {
    switch (this) {
      case NutrientType.water:
        return 'ml';
      case NutrientType.protein:
        return 'g';
      case NutrientType.carb:
        return 'g';
      case NutrientType.fat:
        return 'g';
      case NutrientType.sodium:
        return 'mg';
      case NutrientType.saturatedFat:
        return 'g';
      case NutrientType.monounsaturatedFat:
        return 'g';
      case NutrientType.polyunsaturatedFat:
        return 'g';
      case NutrientType.transFat:
        return 'g';
      case NutrientType.potassium:
        return 'mg';
      case NutrientType.calcium:
        return 'mg';
      case NutrientType.vitaminA:
        return 'mcg';
      case NutrientType.vitaminC:
        return 'mg';
      case NutrientType.sugar:
        return 'g';
      case NutrientType.fiber:
        return 'g';
      case NutrientType.cholesterol:
        return 'mcg';
    }
  }
}
