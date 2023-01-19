import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/questionnaire/domain/usecase/post_questionnaire.dart';
import 'package:livewell/routes/app_navigator.dart';

import '../../../questionnaire/presentation/controller/questionnaire_controller.dart';

class PhysicalInformationController extends GetxController {
  TextEditingController gender = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController drink = TextEditingController();
  TextEditingController sleep = TextEditingController();
  TextEditingController dietaryResitriction = TextEditingController();
  TextEditingController specificGoal = TextEditingController();
  TextEditingController targetWeight = TextEditingController();
  RxString genderValue = 'Male'.obs;
  RxString genderTemp = 'Male.'.obs;
  Rxn<DateTime> birthDate = Rxn<DateTime>();
  PostQuestionnaire postQuestionnaire = PostQuestionnaire.instance();
  Rx<GoalSelection> selectedGoals = GoalSelection.getFitter.obs;

  @override
  void onInit() {
    DashboardController dashboardController = Get.find();
    genderValue.value = dashboardController.user.value.gender ?? "";
    gender.text = genderValue.value;
    height.text = ("${dashboardController.user.value.height ?? ""}");
    weight.text = ("${dashboardController.user.value.weight ?? ""}");
    targetWeight.text =
        ("${dashboardController.user.value.weightTarget ?? ""}");
    // convert birth date to age
    age.text = (DateTime.now()
                .difference(DateTime.parse(
                    dashboardController.user.value.birthDate ??
                        DateTime.now().toString()))
                .inDays /
            365)
        .floor()
        .toString();
    drink.text = dashboardController
            .user.value.onboardingQuestionnaire?.glassesOfWaterDaily ??
        "";
    sleep.text =
        dashboardController.user.value.onboardingQuestionnaire?.sleepDuration ??
            "";
    var specificGoalTemp = dashboardController
            .user.value.onboardingQuestionnaire?.targetImprovement ??
        [];
    specificGoal.text =
        specificGoalTemp.isEmpty ? "No" : specificGoalTemp.first;
    selectedGoals.value = specificGoalTemp.isEmpty
        ? GoalSelection.getFitter
        : GoalSelection.values
            .firstWhere((element) => element.title() == specificGoalTemp.first);
    ("${dashboardController.user.value.weightTarget ?? ""}");
    var dietaryRestrictionTemp = dashboardController
            .user.value.onboardingQuestionnaire?.dietaryRestrictions ??
        ["No"];
    dietaryResitriction.text = dietaryRestrictionTemp.isEmpty
        ? "No"
        : dietaryRestrictionTemp.first.isEmpty
            ? "No"
            : dietaryRestrictionTemp.first;
    birthDate.value = DateTime.parse(
        dashboardController.user.value.birthDate ?? DateTime.now().toString());
    super.onInit();
  }

  void showGenderPicker() {
    // create a dialog that show radio button to select gender
  }

  void setGender(String value) {
    genderValue.value = value;
  }

  void setAge(DateTime value) {
    birthDate.value = value;
  }

  void setGenderTextField() {
    gender.text = genderValue.value;
  }

  void setGoal(GoalSelection value) {
    specificGoal.text = value.title();
  }

  void setAgeTextField() {
    age.text =
        (DateTime.now().difference(birthDate.value ?? DateTime.now()).inDays /
                365)
            .floor()
            .toString();
  }

  void onUpdateTapped() async {
    DashboardController dashboardController = Get.find();
    EasyLoading.show();

    final result = await postQuestionnaire.call(QuestionnaireParams.asParams(
        dashboardController.user.value.firstName,
        dashboardController.user.value.lastName,
        gender.text,
        DateFormat('yyyy-MM-dd').format(birthDate.value!),
        int.parse(weight.text),
        int.parse(height.text),
        int.parse(targetWeight.text),
        0,
        drink.text,
        sleep.text,
        dietaryResitriction.text,
        specificGoal.text));
    EasyLoading.dismiss();
    result.fold((l) {
      Get.snackbar("Failed", "Failed to update Physical Information");
    }, (r) {
      dashboardController.getUsersData();
      Get.snackbar("Success", "Physical Information updated");
      AppNavigator.popUntil(routeName: AppPages.home);
      Get.find<HomeController>().currentMenu.value = HomeTab.home;
    });
  }
}
