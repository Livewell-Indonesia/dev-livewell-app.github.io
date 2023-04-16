import 'dart:developer';

import 'package:get/get.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';
import 'package:livewell/feature/nutriscore/presentation/controller/nutriscore_controller.dart';
import 'package:livewell/feature/nutriscore/presentation/pages/nutriscore_screen.dart';

class NutriscoreDetailController extends GetxController {
  List<NutrientDetailData> nutrientList = [];
  late NutrientType currentType;
  late num nutrientValue;
  Rx<double> todaysAmount = 0.0.obs;
  Rx<double> weeklyAverage = 0.0.obs;
  @override
  void onInit() {
    currentType = Get.arguments['type'];
    nutrientValue = Get.arguments['value'];
    getDetailData();
    super.onInit();
  }

  bool isYValueOptimal(int index) {
    var target = nutrientList[index].nutrient.optimizedNutrient!;
    var minimum = target * 0.8;
    var maximum = target * 1.2;

    if (nutrientList[index].nutrient.eaten! >= minimum &&
        nutrientList[index].nutrient.eaten! <= maximum) {
      return true;
    } else {
      return false;
    }
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
    todaysAmount.value = nutrientList[0].nutrient.eaten!.toDouble();
    nutrientList = nutrientList.reversed.toList();
    num temp = 0;
    for (var element in nutrientList) {
      temp += element.nutrient.eaten!;
    }
    weeklyAverage.value = (temp / nutrientList.length);
  }

  NutrientScoreStatus getNutriScoreStatus() {
    var value = todaysAmount.value;
    var optimal = nutrientList[0].nutrient.optimizedNutrient!;
    if (value >= optimal * 0.8 && value <= optimal * 1.4) {
      return NutrientScoreStatus.optimal;
    } else if (value < optimal * 0.8) {
      return NutrientScoreStatus.low;
    } else {
      return NutrientScoreStatus.high;
    }
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
