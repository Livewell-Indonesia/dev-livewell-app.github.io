import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/profile/domain/usecase/upload_photo.dart';
import 'package:livewell/feature/questionnaire/domain/usecase/post_questionnaire.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livewell/core/base/base_controller.dart';

import '../../../questionnaire/presentation/controller/questionnaire_controller.dart';

class PhysicalInformationController extends BaseController {
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
  final ImagePicker _picker = ImagePicker();

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
    specificGoal.text = specificGoalTemp.isEmpty
        ? "No"
        : GoalSelection.values
            .firstWhere((element) => element.value() == specificGoalTemp.first)
            .title();
    selectedGoals.value = specificGoalTemp.isEmpty
        ? GoalSelection.getFitter
        : GoalSelection.values
            .firstWhere((element) => element.value() == specificGoalTemp.first);
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

  Future<void> pickImages(File source) async {
    // pick image from gallery
    try {
      UploadPhoto uploadPhoto = UploadPhoto.instance();
      final data = await uploadPhoto.call(source);
      data.fold((l) {
        Log.error(l);
      }, (r) async {
        DashboardController controller = Get.find();
        await controller.getUsersData().then((value) {
          onInit();
        });
      });
    } catch (e) {
      print(e);
    }
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
        specificGoal.text,
        dashboardController.user.value.language));
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
