import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_detail_model.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';
import 'package:livewell/feature/nutriscore/domain/usecase/get_nutri_score.dart';
import 'package:livewell/feature/nutriscore/domain/usecase/get_nutri_score_detail.dart';
import 'package:livewell/routes/app_navigator.dart';

class NutriScoreController extends BaseController {
  Rx<NutriScoreModel> nutriScore = NutriScoreModel().obs;
  RxList<NutriscoreDetailModel> nutriScoreDetail = <NutriscoreDetailModel>[].obs;
  NutrientType? nutrientFromSummary;
  @override
  void onInit() {
    getNutriScore();

    if (Get.arguments != null) {
      nutrientFromSummary = Get.arguments['type'];
    }
    super.onInit();
  }

  void getNutriScore() async {
    var usecase = GetNutriScore.instance();
    EasyLoading.show();
    final result = await usecase(NoParams());
    result.fold((l) {
      // handle error
      Get.snackbar('error', l.message ?? "");
    }, (r) async {
      // handle success
      nutriScore.value = r;
      await getNutriscoreDetail();
      EasyLoading.dismiss();
    });
  }

  Future<void> getNutriscoreDetail() async {
    var usecase = GetNutriscoreDetail.instance();
    final result = await usecase(NoParams());
    result.fold((l) {
      // handle error
      Get.snackbar('error', l.message ?? "");
    }, (r) {
      // handle success
      nutriScoreDetail.value = r;

      if (nutrientFromSummary != null) {
        onNutrientTapped(nutrientFromSummary!);
      }
    });
  }

  void onNutrientTapped(NutrientType type) {
    if (nutriScoreDetail.isNotEmpty) {
      AppNavigator.push(routeName: AppPages.nutriScoreDetail, arguments: {'type': type});
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
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.water ?? "Water";
      case NutrientType.protein:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.protein ?? "Protein";
      case NutrientType.carb:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.carbohydrate ?? "Carbohydrate";
      case NutrientType.fat:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.fat ?? "Fat";
      case NutrientType.sodium:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.sodium ?? "Sodium";
      case NutrientType.saturatedFat:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.saturatedFat ?? "Saturated Fat";
      case NutrientType.monounsaturatedFat:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.monounsaturatedFat ?? "Monounsaturated Fat";
      case NutrientType.polyunsaturatedFat:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.polyunsaturatedFat ?? "Polyunsaturated Fat";
      case NutrientType.calcium:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.calcium ?? "Calcium";
      case NutrientType.vitaminA:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.calcium ?? "Calcium";
      case NutrientType.vitaminC:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.vitaminC ?? "Vitamin C";
      case NutrientType.potassium:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.potassium ?? "Potassium";
      case NutrientType.transFat:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.transFat ?? "Trans Fat";
      case NutrientType.sugar:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.sugar ?? "Sugar";
      case NutrientType.fiber:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.fiber ?? "Fiber";
      case NutrientType.cholesterol:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.cholesterol ?? "Cholesterol";
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

  Color lowColor() {
    return const Color(0xFF808080);
  }

  Color highColor() {
    switch (this) {
      case NutrientType.protein:
        return const Color(0xFFDDF235);
      case NutrientType.water:
        return const Color(0xFFDDF235);
      default:
        return const Color(0xFFFA6F6F);
    }
  }

  Color optimalColor() {
    switch (this) {
      case NutrientType.protein:
        return const Color(0xFFDDF235);
      case NutrientType.water:
        return const Color(0xFFDDF235);
      default:
        return const Color(0xFF80A4A9);
    }
  }

  String lowTitle() {
    switch (this) {
      case NutrientType.water:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.belowTarget ?? "Below Target";
      case NutrientType.protein:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.belowTarget ?? "Below Target";
      default:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.low ?? "Low";
    }
  }

  String optimalTitle() {
    switch (this) {
      case NutrientType.water:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.onTrack ?? "On Track";
      case NutrientType.protein:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.onTrack ?? "On Track";
      default:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.optimal ?? "Optimal";
    }
  }

  String highTitle() {
    switch (this) {
      case NutrientType.water:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.excellent ?? "Excellent";
      case NutrientType.protein:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.excellent ?? "Excellent";
      default:
        return Get.find<HomeController>().localization.nutriscoreDetailPage?.high ?? "High";
    }
  }
}
