import 'dart:developer';

import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';
import 'package:livewell/feature/nutriscore/presentation/controller/nutriscore_controller.dart';
import 'package:livewell/feature/nutriscore/presentation/pages/nutriscore_screen.dart';

class NutriscoreDetailController extends BaseController {
  RxList<NutrientDetailData> nutrientList = <NutrientDetailData>[].obs;
  late NutrientType currentType;
  Rx<double> todaysAmount = 0.0.obs;
  Rx<double> weeklyAverage = 0.0.obs;
  Rx<int> nutrientScore = 0.obs;
  @override
  void onInit() {
    currentType = Get.arguments['type'];
    getDetailData();
    super.onInit();
  }

  bool isYValueOptimal(int index) {
    var target = nutrientList[index].nutrient.optimizedNutrient!;
    var minimum = target * 0.8;
    var maximum = target * 1.2;

    if (nutrientList[index].nutrient.eaten! >= minimum && nutrientList[index].nutrient.eaten! <= maximum) {
      return true;
    } else {
      return false;
    }
  }

  void getDetailData() {
    NutriScoreController nutriScoreController = Get.find();
    var data = nutriScoreController.nutriScoreDetail;
    for (var element in data) {
      nutrientList.add(NutrientDetailData(
        nutrient: Nutrient.fromJson(element.details!.toJson()[currentType.jsonName()]),
        date: element.date!,
      ));
    }
    todaysAmount.value = nutrientList[0].nutrient.eaten!.toDouble();
    nutrientScore.value = ((nutrientList[0].nutrient.eaten!.toDouble() / nutrientList[0].nutrient.optimizedNutrient!.toDouble()) * 100).round().max169();
    nutrientList = nutrientList.reversed.toList().obs;
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
      return convertCustomStatus(NutrientScoreStatus.optimal);
    } else if (value < optimal * 0.8) {
      return convertCustomStatus(NutrientScoreStatus.low);
    } else {
      return convertCustomStatus(NutrientScoreStatus.high);
    }
  }

  NutrientScoreStatus convertCustomStatus(NutrientScoreStatus status) {
    if (currentType == NutrientType.protein || currentType == NutrientType.water) {
      switch (status) {
        case NutrientScoreStatus.optimal:
          return NutrientScoreStatus.ontrack;
        case NutrientScoreStatus.low:
          return NutrientScoreStatus.belowTarget;
        case NutrientScoreStatus.high:
          return NutrientScoreStatus.excellent;
        default:
          return status;
      }
    } else {
      return status;
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

extension on int {
  int max169() {
    return this > 169 ? 169 : this;
  }
}
