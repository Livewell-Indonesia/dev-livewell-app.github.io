import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';

import '../page/finish_questionnaire_screen.dart';

class QuestionnaireController extends GetxController {
  Rx<QuestionnairePage> currentPage = QuestionnairePage.gender.obs;
  var progress = 0.0.obs;
  var date = DateTime.now().obs;
  var dateOfBirth = "".obs;
  var age = 1.obs;
  var height = 1.obs;
  var drink = 1.obs;
  var sleep = 1.obs;

  Rx<GoalSelection> selectedGoals = GoalSelection.none.obs;
  Rx<DietrarySelection> selectedDietrary = DietrarySelection.none.obs;

  QuestionnairePage findNextPage() {
    final nextIndex =
        (currentPage.value.index + 1) % QuestionnairePage.values.length;
    return QuestionnairePage.values[nextIndex];
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
      Get.to(() => const FinishQuestionnaireScreen());
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
}

enum QuestionnairePage {
  gender,
  age,
  weight,
  height,
  drink,
  sleep,
  dieatary,
  goal,
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
        return 'You always change this latter';
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
        return 'Yes';
      case DietrarySelection.no:
        return 'No';
      case DietrarySelection.none:
        return 'None';
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
