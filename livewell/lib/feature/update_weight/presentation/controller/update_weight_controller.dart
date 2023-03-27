import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:livewell/feature/food/domain/usecase/get_meal_history.dart';
import 'package:livewell/feature/questionnaire/domain/usecase/post_questionnaire.dart';
import 'package:livewell/feature/update_weight/domain/model/weight_history.dart';
import 'package:livewell/feature/update_weight/domain/usecase/get_user_history.dart';

import 'package:livewell/feature/update_weight/domain/usecase/update_user_weight.dart';

import '../../../dashboard/presentation/controller/dashboard_controller.dart';

class UpdateWeightController extends GetxController {
  Rx<double> targetWeight = 0.0.obs;
  Rx<double> weight = 0.0.obs;
  RxList<WeightHistory> weightHistory = <WeightHistory>[].obs;
  Rx<double> minY = 0.0.obs;
  Rx<double> maxY = 0.0.obs;
  double inputtedWeight = 0.0;
  Rx<double> weightPrediciton = 0.0.obs;
  double inputtedTargetWeight = 0.0;
  Rx<String> title = ''.obs;
  GetUserMealHistory getUserMealHistory = GetUserMealHistory.instance();
  RxList<MealHistoryModel> mealHistoryList = <MealHistoryModel>[].obs;

  @override
  void onInit() {
    getCurrentWeight();
    getWeightHistory();
    calculatePrediction();
    generateTitle();
    getMealHistory();
    super.onInit();
  }

  void getMealHistory() async {
    GetUserMealHistory getUserMealHistory = GetUserMealHistory.instance();
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 59);
    var endDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day - 90, 0, 0, 0);
    if (Get.isRegistered<DashboardController>()) {
      EasyLoading.show();
      final result = await getUserMealHistory(UserMealHistoryParams(
          filter: Filter(
        startDate: currentDate,
        endDate: endDate,
      )));
      EasyLoading.dismiss();
      result.fold((l) {}, (r) {
        inspect(r.response);
        mealHistoryList.value = r.response!;
      });
    }
  }

  String getXValue(int index) {
    String value = '';
    if (mealHistoryList.isNotEmpty) {
      var date = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day - 6 + index);
      value = DateFormat('dd/MM').format(date);
    }
    return value;
  }

  double getYValue(int index) {
    var value = 0.0;
    if (mealHistoryList.isNotEmpty) {
      var date = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day - 6 + index);
      for (var data in mealHistoryList) {
        if (DateTime.parse(data.mealAt!).year == date.year &&
            DateTime.parse(data.mealAt!).month == date.month &&
            DateTime.parse(data.mealAt!).day == date.day) {
          value += data.caloriesInG!;
        }
      }
    }
    return value;
  }

  void generateTitle() {
    var calculation =
        NumberFormat('#.0').format(weight.value - targetWeight.value);
  }

  void getCurrentWeight() {
    if (Get.isRegistered<DashboardController>()) {
      var user = Get.find<DashboardController>().user.value;
      weight.value = user.weight!.toDouble();
      inputtedWeight = user.weight!.toDouble();
      targetWeight.value = user.weightTarget!.toDouble();
      inputtedTargetWeight = user.weightTarget!.toDouble();
    }
  }

  void getWeightHistory() async {
    GetUserHistory getUserHistory = GetUserHistory.instance();
    if (Get.isRegistered<DashboardController>()) {
      EasyLoading.show();
      final result = await getUserHistory(NoParams());
      EasyLoading.dismiss();
      result.fold((l) {}, (r) {
        weightHistory.value = r;
        if (weightHistory.isNotEmpty) {
          var maxWeight = weightHistory
              .asMap()
              .entries
              .reduce((a, b) => a.value.weight! > b.value.weight! ? a : b)
              .value
              .weight!
              .toDouble();
          minY.value = weightHistory
              .asMap()
              .entries
              .reduce((a, b) => a.value.weight! < b.value.weight! ? a : b)
              .value
              .weight!
              .toDouble();
          maxY.value = targetWeight.toDouble() > maxWeight
              ? targetWeight.toDouble()
              : maxWeight;
          var initialWeight = weightHistory.last.weight!.toDouble();
          var latestWeight = weightHistory.first.weight!.toDouble();
          title.value = initialWeight >= latestWeight
              ? 'You have lost ${NumberFormat('0.0').format(initialWeight - latestWeight)} kg'
              : 'You have gained ${NumberFormat('0.0').format(latestWeight - initialWeight)} kg';
        }
        inspect(weightHistory);
        inspect(minY);
      });
    }
  }

  void onUpdateTapped() async {
    UpdateUserWeight updateUserWeight = UpdateUserWeight.instance();
    if (Get.isRegistered<DashboardController>()) {
      EasyLoading.show();
      final result =
          await updateUserWeight(UpdateWeightParams(weight: inputtedWeight));
      EasyLoading.dismiss();
      result.fold((l) {}, (r) {
        Get.find<DashboardController>().getUsersData();
        Get.back();
        getWeightHistory();
        weight.value = inputtedWeight;
        calculatePrediction();
      });
    }
  }

  void calculatePrediction() {
    if (Get.isRegistered<DashboardController>()) {
      var user = Get.find<DashboardController>().dashboard.value;
      var remainingKcal = user.dashboard?.caloriesLeft ?? 0;
      weightPrediciton.value = weight.value - (remainingKcal * 28 * 0.00013);
    }
  }

  void onUpdateTargetTapped() async {
    DashboardController dashboardController = Get.find();
    EasyLoading.show();
    PostQuestionnaire postQuestionnaire = PostQuestionnaire.instance();
    var params = QuestionnaireParams.asParams(
      dashboardController.user.value.firstName,
      dashboardController.user.value.lastName,
      dashboardController.user.value.gender,
      DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(dashboardController.user.value.birthDate!)),
      dashboardController.user.value.weight,
      dashboardController.user.value.height,
      inputtedTargetWeight,
      dashboardController.user.value.exerciseGoalKcal,
      dashboardController
          .user.value.onboardingQuestionnaire!.glassesOfWaterDaily!,
      dashboardController.user.value.onboardingQuestionnaire!.sleepDuration!,
      dashboardController
          .user.value.onboardingQuestionnaire!.dietaryRestrictions!.first,
      dashboardController
          .user.value.onboardingQuestionnaire!.targetImprovement!.first,
    );
    inspect(params);
    final result = await postQuestionnaire.call(params);
    EasyLoading.dismiss();
    result.fold((l) {}, (r) {
      Get.find<DashboardController>().getUsersData();
      Get.back();
      targetWeight.value = inputtedTargetWeight;
      getWeightHistory();
    });
  }
}
