import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';

import 'nutriscore_controller.dart';

class NutriscoreScoreDetailController extends BaseController {
  List<NutriScoreDetailModel> nutrientList = [];
  late num nutrientValue;
  Rx<double> todaysAmount = 0.0.obs;
  Rx<double> weeklyAverage = 0.0.obs;
  Rx<int> nutrientScore = 0.obs;

  @override
  void onInit() {
    getDetailData();
    super.onInit();
  }

  void getDetailData() {
    NutriScoreController nutriScoreController = Get.find();
    var data = nutriScoreController.nutriScoreDetail;
    for (var element in data) {
      nutrientList.add(NutriScoreDetailModel(
        value: element.totalPoints ?? 0,
        date: element.date ?? "",
      ));
    }
    if (nutrientList.isNotEmpty) {
      todaysAmount.value = nutrientList[0].value.toDouble();
      nutrientList = nutrientList.reversed.toList();
      num temp = 0;
      for (var element in nutrientList) {
        temp += element.value;
      }
      weeklyAverage.value = (temp / nutrientList.length);
      nutrientScore.value = todaysAmount.value.toInt();
    }
  }

  double getMaxY() {
    double max = 0;
    for (var element in nutrientList) {
      if (element.value > max) {
        max = element.value.toDouble();
      }
    }
    return max;
  }

  double getMinY() {
    double min = 0;
    for (var element in nutrientList) {
      if (element.value < min) {
        min = element.value.toDouble();
      }
    }
    return min;
  }
}

class NutriScoreDetailModel {
  num value;
  String date;

  NutriScoreDetailModel({required this.value, required this.date});
}
