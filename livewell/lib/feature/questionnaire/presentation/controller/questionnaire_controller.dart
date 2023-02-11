import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/questionnaire/domain/usecase/post_questionnaire.dart';

import '../../../../core/log.dart';
import '../../../../routes/app_navigator.dart';

class QuestionnaireController extends GetxController {
  Rx<QuestionnairePage> currentPage = QuestionnairePage.gender.obs;
  var progress = 0.0.obs;
  var date = DateTime(1990, 1, 1).obs;
  var dateOfBirth = "".obs;
  var age = 1.obs;
  var height = 150.obs;
  var drink = 1.obs;
  var sleep = 1.obs;
  var weight = 50.obs;
  var targetWeight = 30.obs;
  Rx<Gender> selectedGender = Gender.male.obs;
  Rx<GoalSelection> selectedGoals = GoalSelection.getFitter.obs;
  Rx<DietrarySelection> selectedDietrary = DietrarySelection.no.obs;
  Rx<TargetExerciseSelection> selectedExerciseTarget =
      TargetExerciseSelection.light.obs;
  TextEditingController selectedDietraryText = TextEditingController();

  PostQuestionnaire postQuestionnaire = PostQuestionnaire.instance();

  QuestionnairePage findNextPage() {
    // if current page is questionnairepage.goal and selected goal is not better sleeping, return questionnairepage.targetweight
    final nextIndex =
        (currentPage.value.index + 1) % QuestionnairePage.values.length;
    final nextPage = QuestionnairePage.values[nextIndex];
    if (currentPage.value == QuestionnairePage.goal &&
        selectedGoals.value != GoalSelection.betterSleeping) {
      return QuestionnairePage.targetWeight;
    } else if (currentPage.value == QuestionnairePage.goal) {
      return QuestionnairePage.finish;
    } else {
      return nextPage;
    }
  }

  QuestionnairePage findPreviousPage() {
    final prefIndex =
        (currentPage.value.index - 1) % QuestionnairePage.values.length;
    return QuestionnairePage.values[prefIndex];
  }

  void nextPage() {
    currentPage.value = findNextPage();
  }

  void onButtonTapped() {
    if (currentPage.value == QuestionnairePage.finish) {
      Get.offAllNamed('/home');
    } else if (findNextPage() == QuestionnairePage.finish) {
      sendData();
    } else {
      nextPage();
    }
  }

  void onBackPressed() {
    if (currentPage.value == QuestionnairePage.gender) {
      Get.back();
    } else {
      currentPage.value = findPreviousPage();
    }
  }

  void sendData() async {
    var usersData = Get.find<DashboardController>().user.value;
    var params = QuestionnaireParams.asParams(
        usersData.firstName,
        usersData.lastName,
        selectedGender.value.label(),
        DateFormat('yyyy-MM-dd').format(date.value),
        weight.value,
        height.value,
        targetWeight.value,
        selectedExerciseTarget.value.value(),
        drink.value.toString(),
        sleep.value.toString(),
        selectedDietraryText.text,
        selectedGoals.value.value());
    inspect(params);
    Log.info(params.toJson());
    inspect(params.toJson());
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final result = await postQuestionnaire(params);
    await EasyLoading.dismiss();
    result.fold((l) {}, (r) {
      AppNavigator.pushAndRemove(routeName: AppPages.finishQuestionnaire);
    });
    //AppNavigator.push(routeName: AppPages.finishQuestionnaire);
  }
}

enum QuestionnairePage {
  gender,
  age,
  weight,
  height,
  drink,
  sleep,
  dieatary,
  exercise,
  goal,
  targetWeight,
  finish
}

extension QuestionnairePageData on QuestionnairePage {
  String title() {
    switch (this) {
      case QuestionnairePage.gender:
        return 'Gender';
      case QuestionnairePage.age:
        return 'How old are you?';
      case QuestionnairePage.weight:
        return 'What\'s your weight?';
      case QuestionnairePage.height:
        return 'What\'s your height?';
      case QuestionnairePage.drink:
        return 'Drink';
      case QuestionnairePage.sleep:
        return 'Sleep';
      case QuestionnairePage.dieatary:
        return 'Any dietary restriction?';
      case QuestionnairePage.goal:
        return 'Your specific goal?';
      case QuestionnairePage.exercise:
        return 'Exercise';
      case QuestionnairePage.targetWeight:
        return 'Target weight';
      case QuestionnairePage.finish:
        return 'finish';
    }
  }

  String subtitle() {
    switch (this) {
      case QuestionnairePage.gender:
        return 'Help us to create your personalized plan';
      case QuestionnairePage.age:
        return 'Help us to create your personalized plan';
      case QuestionnairePage.weight:
        return 'Help us to create your personalized plan';
      case QuestionnairePage.height:
        return 'Help us to create your personalized plan';
      case QuestionnairePage.drink:
        return 'How Many Glasses of Water Do you Drink Per day?';
      case QuestionnairePage.sleep:
        return 'How Many Hours Of Sleep Do You Usually Have?';
      case QuestionnairePage.dieatary:
        return 'Help us to create your personalized plan';
      case QuestionnairePage.goal:
        return 'You can always change this later';
      case QuestionnairePage.exercise:
        return 'Set your fitness goals';
      case QuestionnairePage.targetWeight:
        return 'Help us to create your personalized plan';
      case QuestionnairePage.finish:
        return 'finish';
    }
  }
}

enum Gender { male, female }

extension GenderContent on Gender {
  String assets() {
    switch (this) {
      case Gender.female:
        return Constant.imgFemaleSVG;
      case Gender.male:
        return Constant.imgMaleSVG;
    }
  }

  String label() {
    switch (this) {
      case Gender.female:
        return "Female";
      case Gender.male:
        return "Male";
    }
  }
}

enum DietrarySelection { yes, no, none }

extension DietrarySelectionContent on DietrarySelection {
  String title() {
    switch (this) {
      case DietrarySelection.yes:
        return 'Yes'.tr;
      case DietrarySelection.no:
        return 'No'.tr;
      case DietrarySelection.none:
        return 'None'.tr;
    }
  }
}

enum GoalSelection {
  getFitter,
  betterSleeping,
  weightLoss,
  trackNutrition,
  improveOverallFitness,
  none
}

extension GoalSelectionContent on GoalSelection {
  String title() {
    switch (this) {
      case GoalSelection.getFitter:
        return "Get Fitter".tr;
      case GoalSelection.betterSleeping:
        return "Better Sleeping".tr;
      case GoalSelection.weightLoss:
        return "Weight Loss".tr;
      case GoalSelection.trackNutrition:
        return "Track Nutrition".tr;
      case GoalSelection.improveOverallFitness:
        return "Improve Overall Fitness".tr;
      case GoalSelection.none:
        return "None".tr;
    }
  }

  String value() {
    switch (this) {
      case GoalSelection.getFitter:
        return "Get Fitter";
      case GoalSelection.betterSleeping:
        return "Better Sleeping";
      case GoalSelection.weightLoss:
        return "Weight Loss";
      case GoalSelection.trackNutrition:
        return "Track Nutrition";
      case GoalSelection.improveOverallFitness:
        return "Improve Overall Fitness";
      case GoalSelection.none:
        return "None";
    }
  }
}

enum TargetExerciseSelection { light, moderate, active }

extension TargetExerciseContent on TargetExerciseSelection {
  String title() {
    switch (this) {
      case TargetExerciseSelection.light:
        return "200 Kcal - Light";
      case TargetExerciseSelection.moderate:
        return "300 Kcal - Moderate";
      case TargetExerciseSelection.active:
        return "400 Kcal - Active";
    }
  }

  int value() {
    switch (this) {
      case TargetExerciseSelection.light:
        return 200;
      case TargetExerciseSelection.moderate:
        return 300;
      case TargetExerciseSelection.active:
        return 400;
    }
  }
}
