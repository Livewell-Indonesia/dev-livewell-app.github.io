import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_exercise_list.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';
import 'package:livewell/feature/profile/domain/usecase/update_user_info.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/switcher/slide_switcher.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../questionnaire/presentation/controller/questionnaire_controller.dart';

class ExerciseController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<ExerciseTab> currentMenu = ExerciseTab.diaries.obs;
  late TabController tabController;
  ValueNotifier<int> sliderValueNotifier = ValueNotifier(0);
  ValueNotifier<double> goalValueNotifier = ValueNotifier(0);
  ValueNotifier<double> caloriesValueNotifier = ValueNotifier(0);
  ValueNotifier<double> stepsValueNotifier = ValueNotifier(0);
  Rx<num> steps = 0.obs;
  Rx<num> burntCalories = 0.0.obs;
  Rx<num> totalSteps = 0.0.obs;
  Rx<num> totalCalories = 0.0.obs;
  TextEditingController dataController = TextEditingController();
  Rx<TargetExerciseSelection> selectedExerciseTarget =
      TargetExerciseSelection.light.obs;

  @override
  void onReady() {
    checkShouldShowKYC();
    super.onReady();
  }

  void checkShouldShowKYC() {
    if (Get.isRegistered<DashboardController>()) {
      var userData = Get.find<DashboardController>().user.value;
      if (userData.exerciseGoalKcal == null || userData.exerciseGoalKcal == 0) {
        // navigate to kyc
        AppNavigator.push(routeName: AppPages.exerciseKYC);
      } else {
        getStepsData();
        getBurntCaloriesData();
        tabController = TabController(length: 2, vsync: this);
        tabController.addListener(() {
          changeTab(ExerciseTab.values[tabController.index]);
        });
      }
    }
  }

  Future<bool> refresh() async {
    await getStepsData();
    await getBurntCaloriesData();
    return true;
  }

  void saveExerciseTarget() async {
    var userData = Get.find<DashboardController>().user.value;
    var newUserData = userData.copyWith(
        exerciseGoalKcal: selectedExerciseTarget.value.value());
    UpdateUserInfo updateUserInfo = UpdateUserInfo.instance();
    EasyLoading.show();
    final result = await updateUserInfo.call(
      UpdateUserInfoParams(
          firstName: newUserData.firstName ?? "",
          lastName: newUserData.lastName ?? "",
          height: newUserData.height ?? 0,
          weight: newUserData.weight ?? 0,
          gender: newUserData.gender ?? "",
          dob: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(newUserData.birthDate ?? "")),
          weightTarget: newUserData.weightTarget ?? 0,
          exerciseGoalKcal: newUserData.exerciseGoalKcal ?? 0),
    );
    EasyLoading.dismiss();
    result.fold((l) => Log.error(l), (r) {
      Get.find<DashboardController>().getUsersData();
      Get.back();
      checkShouldShowKYC();
    });
  }

  void changeTab(ExerciseTab tab) {
    currentMenu.value = tab;
    tabController.index = tab.index;
    sliderValueNotifier.value = tab.index;
  }

  Future<void> getStepsData() async {
    GetExerciseData getExerciseData = GetExerciseData.instance();
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 59, 0, 0);
    var result = await getExerciseData(GetExerciseParams(
        type: HealthDataType.STEPS.name,
        dateFrom: currentDate,
        dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      // sum all value from object r and assign it to steps
      steps.value = r.totalValue ?? 0;
      stepsValueNotifier.value = steps.value.toDouble() /
          (Get.find<DashboardController>().user.value.stepsGoalCount ?? 0);
    });
  }

  int getGoalPercentage() {
    var userData = Get.find<DashboardController>().user.value;
    var goal = userData.exerciseGoalKcal ?? 0;
    var percentage = (burntCalories.value / goal) * 100;
    if (percentage.isNaN || percentage.isInfinite) {
      return 0;
    } else {
      return percentage.roundToDouble().toInt();
    }
  }

  Future<void> getBurntCaloriesData() async {
    GetExerciseData getExerciseData = GetExerciseData.instance();
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 59, 0, 0);
    var result = await getExerciseData(GetExerciseParams(
        type: HealthDataType.ACTIVE_ENERGY_BURNED.name,
        dateFrom: currentDate,
        dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      // sum all value from object r and assign it to burntCalories
      burntCalories.value = (r.totalValue ?? 0).toDouble();
      totalCalories.value = burntCalories.value;
      caloriesValueNotifier.value = burntCalories.value.toDouble();
      goalValueNotifier.value = burntCalories.value.toDouble() /
          (Get.find<DashboardController>().user.value.exerciseGoalKcal ?? 0);
    });
  }
}

enum ExerciseTab { diaries, classes }
