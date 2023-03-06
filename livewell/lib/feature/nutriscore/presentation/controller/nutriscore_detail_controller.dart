import 'dart:developer';

import 'package:get/get.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';
import 'package:livewell/feature/nutriscore/presentation/controller/nutriscore_controller.dart';

class NutriscoreDetailController extends GetxController {
  List<NutrientDetailData> nutrientList = [];
  late NutrientType currentType;
  late num nutrientValue;
  @override
  void onInit() {
    currentType = Get.arguments['type'];
    nutrientValue = Get.arguments['value'];
    getDetailData();
    super.onInit();
  }

  void getDetailData() {
    NutriScoreController nutriScoreController = Get.find();
    var data = nutriScoreController.nutriScoreDetail;
    for (var element in data) {
      inspect(element.details!.toJson()[currentType.jsonName()]);
      nutrientList.add(NutrientDetailData(
        nutrient: Nutrient.fromJson(
            element.details!.toJson()[currentType.jsonName()]),
        date: element.date!,
      ));
    }
    nutrientList = nutrientList.reversed.toList();
  }

  double getMaxY() {
    double max = 0;
    for (var element in nutrientList) {
      if (element.nutrient.eaten! > max) {
        max = element.nutrient.eaten!.toDouble();
      }
    }
    return max;
  }

  double getMinY() {
    double min = 0;
    for (var element in nutrientList) {
      if (element.nutrient.eaten! < min) {
        min = element.nutrient.eaten!.toDouble();
      }
    }
    return min;
  }
}

class NutrientDetailData {
  Nutrient nutrient;
  String date;

  NutrientDetailData({required this.nutrient, required this.date});
}
