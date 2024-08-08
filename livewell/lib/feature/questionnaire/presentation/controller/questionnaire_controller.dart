import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/daily_journal/domain/usecase/post_daily_journal.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/questionnaire/domain/usecase/post_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/calories_need_questionnaire.dart';

import '../../../../core/log.dart';
import '../../../../routes/app_navigator.dart';
import 'package:livewell/core/base/base_controller.dart';

class QuestionnaireController extends BaseController {
  Rx<QuestionnairePage> currentPage = QuestionnairePage.landing.obs;
  var progress = 0.0.obs;
  var date = DateTime(
    DateTime.now().year - 30,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  var dateOfBirth = "".obs;
  var age = 1.obs;
  Rx<int> height = 0.obs;
  var drink = 8.obs;
  var sleep = 7.obs;
  Rx<double> weight = 0.0.obs;
  var targetWeight = 50.0.obs;
  Rx<Gender> selectedGender = Gender.male.obs;
  Rx<GoalSelection> selectedGoals = GoalSelection.none.obs;
  Rx<DietrarySelection> selectedDietrary = DietrarySelection.no.obs;
  Rx<CaloriesNeedType> selectedCaloriesNeed = CaloriesNeedType.none.obs;
  Rx<AvailableLanguage> selectedLanguage = AvailableLanguage.en.obs;
  TextEditingController selectedDietraryText = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController healthCondition = TextEditingController();
  Rx<bool> isNameValid = false.obs;

  PostQuestionnaire postQuestionnaire = PostQuestionnaire.instance();
  PostDailyJournal postDailyJournal = PostDailyJournal.getInstance();

  QuestionnairePage findNextPage() {
    // if current page is questionnairepage.goal and selected goal is not better sleeping, return questionnairepage.targetweight
    final nextIndex = (currentPage.value.index + 1) % QuestionnairePage.values.length;
    final nextPage = QuestionnairePage.values[nextIndex];
    // if (currentPage.value == QuestionnairePage.goal && selectedGoals.value != GoalSelection.betterSleeping) {
    //   return QuestionnairePage.targetWeight;
    // } else if (currentPage.value == QuestionnairePage.goal) {
    //   return QuestionnairePage.finish;
    // } else {
    //   return nextPage;
    // }
    return nextPage;
  }

  void onBackPressed() {
    if (currentPage.value == QuestionnairePage.landing) {
      trackEvent(LivewellAuthEvent.onboardingLandingPagePrev);
      Get.back();
    } else {
      switch (currentPage.value) {
        case QuestionnairePage.landing:
          trackEvent(LivewellAuthEvent.onboardingLandingPagePrev);
          break;
        case QuestionnairePage.name:
          trackEvent(LivewellAuthEvent.onboardingPageOnePrev);
          break;
        case QuestionnairePage.gender:
          trackEvent(LivewellAuthEvent.onboardingPageTwoPrev);
          break;
        case QuestionnairePage.birthDate:
          trackEvent(LivewellAuthEvent.onboardingPageThreePrev);
          break;
        case QuestionnairePage.heightWeight:
          break;
        case QuestionnairePage.caloriesNeed:
          break;
        case QuestionnairePage.healthCondition:
          break;
        case QuestionnairePage.finish:
          break;
      }
      final previousIndex = (currentPage.value.index - 1) % QuestionnairePage.values.length;
      currentPage.value = QuestionnairePage.values[previousIndex];
    }
  }

  @override
  void onInit() {
    firstName.addListener(() {
      if (firstName.text.isNotEmpty) {
        isNameValid.value = true;
      } else {
        isNameValid.value = false;
      }
    });
    Log.colorGreen("questionpage ${QuestionnairePage.values}");
    trackEvent(LivewellAuthEvent.onboardingLandingPage);
    super.onInit();
  }

  void onNextTapped() async {
    switch (currentPage.value) {
      case QuestionnairePage.landing:
        trackEvent(LivewellAuthEvent.onboardingPageOne);
        currentPage.value = QuestionnairePage.name;
      case QuestionnairePage.name:
        trackEvent(LivewellAuthEvent.onboardingPageOneNext);
        trackEvent(LivewellAuthEvent.onboardingPageTwo);
        currentPage.value = QuestionnairePage.gender;
      case QuestionnairePage.gender:
        trackEvent(LivewellAuthEvent.onboardingPageTwoNext);
        trackEvent(LivewellAuthEvent.onboardingPageThree);
        currentPage.value = QuestionnairePage.birthDate;
      case QuestionnairePage.birthDate:
        trackEvent(LivewellAuthEvent.onboardingPageThreeNext);
        currentPage.value = QuestionnairePage.heightWeight;
      case QuestionnairePage.heightWeight:
        currentPage.value = QuestionnairePage.caloriesNeed;
      case QuestionnairePage.caloriesNeed:
        currentPage.value = QuestionnairePage.healthCondition;
      case QuestionnairePage.healthCondition:
        sendData();
      case QuestionnairePage.finish:
        currentPage.value = QuestionnairePage.finish;
    }
  }

  void onStartNowTapped() {
    currentPage.value = QuestionnairePage.name;
  }

  QuestionnairePage findPreviousPage() {
    final prefIndex = (currentPage.value.index - 1) % QuestionnairePage.values.length;
    return QuestionnairePage.values[prefIndex];
  }

  void nextPage() {
    currentPage.value = findNextPage();
  }

  void onButtonTapped() {
    if (currentPage.value == QuestionnairePage.finish) {
      Get.offAllNamed(AppPages.home);
    } else if (findNextPage() == QuestionnairePage.finish) {
      sendData();
    } else {
      nextPage();
    }
  }

  // void onBackPressed() {
  //   currentPage.value = findPreviousPage();
  // }

  void sendData() async {
    var params = QuestionnaireParams.asParams(
      firstName.text,
      lastName.text,
      selectedGender.value.label(),
      DateFormat('yyyy-MM-dd').format(date.value),
      weight.value,
      height.value,
      idealWeight(height.value.toDouble()),
      selectedCaloriesNeed.value.value,
      drink.value.toString(),
      sleep.value.toString(),
      healthCondition.text.isEmpty ? "No" : healthCondition.text,
      selectedGoals.value.value(),
      selectedLanguage.value.code(),
    );
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final result = await postQuestionnaire(params);
    result.fold((l) {}, (r) async {
      final result = await postDailyJournal(DailyJournalParams.asParams('07:00', '12:00', '15:00', '18:00'));
      await EasyLoading.dismiss();
      result.fold((l) {}, (r) {
        trackEvent(LivewellAuthEvent.onboardingThankYouPage);
        AppNavigator.push(routeName: AppPages.finishQuestionnaire);
      });
    });
    //AppNavigator.push(routeName: AppPages.finishQuestionnaire);
  }

  double idealWeight(double heightCm) {
    // Define the ideal BMI
    double idealBmi = 21;

    // Convert height from cm to m
    double heightM = heightCm / 100.0;

    // Calculate weight in kg based on the ideal BMI
    double weightKg = idealBmi * (heightM * heightM);

    return weightKg;
  }
}

enum QuestionnairePage { landing, name, gender, birthDate, heightWeight, caloriesNeed, healthCondition, finish }

extension QuestionnairePageData on QuestionnairePage {
  String title() {
    switch (this) {
      case QuestionnairePage.landing:
        return 'Welcome to LiveWell!';
      case QuestionnairePage.name:
        return 'First, what\'s your name?';
      case QuestionnairePage.gender:
        return 'What is your gender?';
      case QuestionnairePage.birthDate:
        return 'Tell us your birth date!';
      case QuestionnairePage.heightWeight:
        return 'What\'s your current weight and height?';
      case QuestionnairePage.caloriesNeed:
        return 'Your Current Condition';
      case QuestionnairePage.healthCondition:
        return 'Do you have any allergies, intolerances, or health conditions that affect your diet?';
      case QuestionnairePage.finish:
        return 'You\'re all set!';
    }
  }

  String subtitle() {
    switch (this) {
      case QuestionnairePage.landing:
        return 'Tell us your name to unlock your personalized experience';
      case QuestionnairePage.name:
        return 'Tell us your name to unlock your personalized experience';
      case QuestionnairePage.gender:
        return 'Knowing your gender allows us to provide a more comprehensive picture of your health.';
      case QuestionnairePage.birthDate:
        return 'As your body changes with age, so do your nutritional needs.';
      case QuestionnairePage.heightWeight:
        return 'It\'s essential for calculating your BMI and setting realistic goals.';
      case QuestionnairePage.caloriesNeed:
        return 'Help us calculate your daily calorie needs';
      case QuestionnairePage.healthCondition:
        return 'Tap next if you don’t have any.';
      case QuestionnairePage.finish:
        return 'Your personalized plan is ready. Let\'s start your health journey by keeping track of your daily habit.';
    }
  }

  int realIndex() {
    switch (this) {
      case QuestionnairePage.landing:
        return 0;
      case QuestionnairePage.name:
        return 1;
      case QuestionnairePage.gender:
        return 2;
      case QuestionnairePage.birthDate:
        return 3;
      case QuestionnairePage.heightWeight:
        return 4;
      case QuestionnairePage.caloriesNeed:
        return 5;
      case QuestionnairePage.healthCondition:
        return 6;
      case QuestionnairePage.finish:
        return 7;
    }
  }

  int realLength() {
    return 6;
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
        return 'Female';
      case Gender.male:
        return 'Male';
    }
  }
}

enum DietrarySelection { yes, no, none }

extension DietrarySelectionContent on DietrarySelection {
  String title() {
    switch (this) {
      case DietrarySelection.yes:
        return "";
      case DietrarySelection.no:
        return "";
      case DietrarySelection.none:
        return "";
    }
  }
}

enum LanguageSelection { english, indonesia }

extension LangaugeSelectionContent on LanguageSelection {
  String title() {
    switch (this) {
      case LanguageSelection.english:
        return 'English';
      case LanguageSelection.indonesia:
        return 'Indonesia';
    }
  }

  String code() {
    switch (this) {
      case LanguageSelection.english:
        return 'en_US';
      case LanguageSelection.indonesia:
        return 'id_ID';
    }
  }
}

enum GoalSelection { getFitter, betterSleeping, weightLoss, trackNutrition, none }

extension GoalSelectionContent on GoalSelection {
  String title() {
    switch (this) {
      case GoalSelection.getFitter:
        return "";
      case GoalSelection.betterSleeping:
        return "";
      case GoalSelection.weightLoss:
        return "";
      case GoalSelection.trackNutrition:
        return "";
      case GoalSelection.none:
        return "";
    }
  }

  String value() {
    switch (this) {
      case GoalSelection.getFitter:
        return 'Get Fitter';
      case GoalSelection.betterSleeping:
        return "Better Sleeping";
      case GoalSelection.weightLoss:
        return "Weight Loss";
      case GoalSelection.trackNutrition:
        return "Track Nutrition";
      case GoalSelection.none:
        return "none";
    }
  }
}

enum TargetExerciseSelection { light, moderate, active }

extension TargetExerciseContent on TargetExerciseSelection {
  String title() {
    switch (this) {
      case TargetExerciseSelection.light:
        return Get.find<HomeController>().localization.onboardingPage?.light100Kcal ?? "(100kcal)";
      case TargetExerciseSelection.moderate:
        return Get.find<HomeController>().localization.onboardingPage?.moderate250Kcal ?? "(250kcal)";
      case TargetExerciseSelection.active:
        return Get.find<HomeController>().localization.onboardingPage?.active400Kcal ?? "(400kcal)";
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
