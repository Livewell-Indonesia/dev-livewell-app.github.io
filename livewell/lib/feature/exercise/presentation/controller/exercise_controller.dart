import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_exercise_list.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';
import 'package:livewell/widgets/switcher/slide_switcher.dart';
import 'package:permission_handler/permission_handler.dart';

class ExerciseController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<ExerciseTab> currentMenu = ExerciseTab.diaries.obs;
  late TabController tabController;
  ValueNotifier<int> sliderValueNotifier = ValueNotifier(0);
  Rx<num> steps = 0.obs;
  Rx<num> burntCalories = 0.0.obs;
  TextEditingController dataController = TextEditingController();

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
          0,
          (previousValue, element) =>
              previousValue + (element.value?.toDouble() ?? 0.0));
    });
    Log.colorGreen("total calories ${burntCalories.value}");
  }

  HealthFactory healthFactory = HealthFactory();

  var types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_IN_BED,
  ];

  var permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  void requestHealthAccess() async {
    if (Platform.isAndroid) {
      final permissionStatus = await Permission.activityRecognition.request();
      if (permissionStatus.isGranted) {
        fetchHealthDataFromTypes();
        Log.colorGreen("Permission granted");
      } else {
        Log.error("Permission denied");
      }
    } else {
      var isAllowed = await healthFactory.requestAuthorization(types,
          permissions: permissions);
      if (isAllowed) {
        fetchHealthDataFromTypes();
      }
    }
  }

  void fetchHealthDataFromTypes() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 59, 0, 0);
    List<HealthDataPoint> healthData = await healthFactory
        .getHealthDataFromTypes(currentDate, dateTill, types);
    Log.info(jsonEncode(healthData));
    inspect(healthData);
    PostExerciseData postExerciseData = PostExerciseData.instance();
    var lastSyncHealth = await SharedPref.getLastHealthSyncDate();
    // if user ever synced data
    dataController.text = jsonEncode(healthData);
  }
}

enum ExerciseTab { diaries, classes }
