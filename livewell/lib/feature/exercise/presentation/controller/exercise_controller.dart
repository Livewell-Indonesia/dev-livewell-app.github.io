import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/exercise/data/model/activity_history_model.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_activity_histories.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_exercise_list.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/profile/domain/usecase/update_user_info.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';

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
  RxList<ActivityHistoryModel> exerciseHistoryList =
      <ActivityHistoryModel>[].obs;
  TextEditingController dataController = TextEditingController();
  Rx<TargetExerciseSelection> selectedExerciseTarget =
      TargetExerciseSelection.light.obs;

  @override
  void onReady() {
    checkShouldShowKYC();
    showInfoFirstTime();
    super.onReady();
  }

  double getYValue(int index) {
    var value = 0.0;
    if (exerciseHistoryList.isNotEmpty) {
      var date = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day - 6 + index);
      if (exerciseHistoryList.first.details != null) {
        for (var element in exerciseHistoryList.first.details!) {
          var currentDate =
              DateFormat('yyyy-MM-dd HH:mm:ss').parse(element.dateFrom!);
          if (currentDate.day == date.day &&
              currentDate.month == date.month &&
              currentDate.year == date.year) {
            value += element.value!;
          }
        }
      }
    }
    return value;
  }

  bool isYValueOptimal(int index) {
    var userData = Get.find<DashboardController>().user.value;
    var goal = userData.exerciseGoalKcal ?? 0;
    var value = getYValue(index);
    var minimum = goal * 0.8;
    var maximum = goal * 1.2;
    return value >= minimum;
  }

  String getXValue(int index) {
    String value = '';
    if (exerciseHistoryList.isNotEmpty) {
      var date = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day - 6 + index);
      value = DateFormat('dd/MM').format(date);
    }
    return value;
  }

  void showInfoFirstTime() async {
    var show = await SharedPref.showInfoExercise();
    HomeController controller = Get.find();
    var data = controller.popupAssetsModel.value.exercise;
    if (show && data != null) {
      showModalBottomSheet(
          context: Get.context!,
          isScrollControlled: true,
          shape: ShapeBorder.lerp(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              1),
          builder: ((context) {
            return PopupAssetWidget(
              exercise: data,
            );
          }));
      SharedPref.saveShowInfoExercise(false);
    }
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
        getExerciseHistorydata();
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
    await getExerciseHistorydata();
    return true;
  }

  Future<void> getExerciseHistorydata() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day - 7, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 59, 0, 0);
    GetActivityHistory getExerciseList = GetActivityHistory.instance();
    final result = await getExerciseList.call(GetActivityHistoryParam(
        type: ['ACTIVE_ENERGY_BURNED'],
        dateFrom: currentDate,
        dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      Log.info(r);
      inspect(r);
      exerciseHistoryList.assignAll(r);
    });
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
      getStepsData();
      getBurntCaloriesData();
      tabController = TabController(length: 2, vsync: this);
      tabController.addListener(() {
        changeTab(ExerciseTab.values[tabController.index]);
      });
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
      if (r.details != null) {
        for (var element in r.details!) {
          burntCalories.value += element.value!;
        }
      }
      totalCalories.value = burntCalories.value;
      caloriesValueNotifier.value = burntCalories.value.toDouble();
      goalValueNotifier.value = burntCalories.value.toDouble() /
          (Get.find<DashboardController>().user.value.exerciseGoalKcal ?? 0);
    });
  }
}

enum ExerciseTab { diaries, classes }
