import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_exercise_list.dart';
import 'package:livewell/widgets/switcher/slide_switcher.dart';

class ExerciseController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<ExerciseTab> currentMenu = ExerciseTab.diaries.obs;
  late TabController tabController;
  ValueNotifier<int> sliderValueNotifier = ValueNotifier(0);
  Rx<num> steps = 0.obs;
  Rx<num> burntCalories = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getStepsData();
    getBurntCaloriesData();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      changeTab(ExerciseTab.values[tabController.index]);
    });
  }

  void changeTab(ExerciseTab tab) {
    currentMenu.value = tab;
    tabController.index = tab.index;
    sliderValueNotifier.value = tab.index;
  }

  void getStepsData() async {
    GetExerciseData getExerciseData = GetExerciseData.instance();
    var result = await getExerciseData(
        GetExerciseParams(type: HealthDataType.STEPS.name));
    result.fold((l) => print(l), (r) {
      // sum all value from object r and assign it to steps
      steps.value = r.fold(
          0, (previousValue, element) => previousValue + (element.value ?? 0));
      Log.colorGreen("total steps ${steps.value}");
    });
  }

  void getBurntCaloriesData() async {
    GetExerciseData getExerciseData = GetExerciseData.instance();
    var result = await getExerciseData(
        GetExerciseParams(type: HealthDataType.ACTIVE_ENERGY_BURNED.name));
    result.fold((l) => print(l), (r) {
      // sum all value from object r and assign it to burntCalories
      burntCalories.value = r.fold(
          0, (previousValue, element) => previousValue + (element.value ?? 0));
    });
    Log.colorGreen("total calories ${burntCalories.value}");
  }
}

enum ExerciseTab { diaries, classes }
