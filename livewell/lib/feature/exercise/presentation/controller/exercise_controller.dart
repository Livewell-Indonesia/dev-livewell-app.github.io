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
import 'package:livewell/feature/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:livewell/feature/diary/presentation/controller/user_diary_controller.dart';
import 'package:livewell/feature/exercise/data/model/activity_history_model.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_activity_histories.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_exercise_list.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/profile/domain/usecase/update_user_info.dart';
import 'package:livewell/feature/streak/domain/usecase/refresh_wellness_data.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';

import '../../../questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/core/base/base_controller.dart';

class ExerciseController extends BaseController with GetSingleTickerProviderStateMixin {
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
  RxList<ActivityHistoryModel> exerciseHistoryList = <ActivityHistoryModel>[].obs;
  TextEditingController dataController = TextEditingController();
  Rx<TargetExerciseSelection> selectedExerciseTarget = TargetExerciseSelection.light.obs;

  Rxn<File> file = Rxn<File>();
  TextEditingController titleController = TextEditingController();
  Rxn<String> titleError = Rxn<String>();
  TextEditingController locationController = TextEditingController();

  TextEditingController exerciseManualInput = TextEditingController();

  @override
  void onReady() {
    checkShouldShowKYC();
    showInfoFirstTime();
    super.onReady();
  }

  double getYValue(int index) {
    var value = 0.0;
    if (exerciseHistoryList.isNotEmpty) {
      var date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 6 + index);
      if (exerciseHistoryList.first.details != null) {
        for (var element in exerciseHistoryList.first.details!) {
          var currentDate = DateTime.parse(element.dateFrom!);
          if (currentDate.day == date.day && currentDate.month == date.month && currentDate.year == date.year) {
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
    return value >= minimum;
  }

  String getXValue(int index) {
    String value = '';
    if (exerciseHistoryList.isNotEmpty) {
      var date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 6 + index);
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
          shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
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
        refreshWellness();
        getExerciseHistorydata();
        tabController = TabController(length: 2, vsync: this);
        tabController.addListener(() {
          changeTab(ExerciseTab.values[tabController.index]);
        });
      }
    }
  }

  void refreshWellness() async {
    RefreshWellnessData refreshWellnessData = RefreshWellnessData.instance();
    await refreshWellnessData.call('ACTIVITY');
  }

  void sendExerciseDataManual() async {
    final usecase = PostExerciseData.instance();
    EasyLoading.show();
    final result = await usecase.call(PostExerciseParams.manualInput(double.parse(exerciseManualInput.text), HealthDataType.STEPS));
    EasyLoading.dismiss();
    result.fold((l) {}, (r) async {
      final calories = 3 * (Get.find<DashboardController>().user.value.weight?.toDouble() ?? 1) * (double.parse(exerciseManualInput.text) / 10000);
      final result = await usecase.call(PostExerciseParams.manualInput(calories, HealthDataType.ACTIVE_ENERGY_BURNED));
      result.fold((l) {}, (r) {
        refreshList();
        exerciseManualInput.clear();
        if (Get.isRegistered<UserDiaryController>()) {
          Get.find<UserDiaryController>().refreshList();
        }
        Get.back();
      });
    });
  }

  Future<bool> refreshList() async {
    steps.value = 0;
    burntCalories.value = 0.0;
    totalSteps.value = 0.0;
    totalCalories.value = 0.0;
    await getStepsData();
    await getBurntCaloriesData();
    await getExerciseHistorydata();
    refreshWellness();
    return true;
  }

  double calculateDistance(int numberOfSteps, double strideLength) {
    return (numberOfSteps * strideLength) / 1000;
  }

  Future<void> getExerciseHistorydata() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59, 0, 0);
    GetActivityHistory getExerciseList = GetActivityHistory.instance();
    final result = await getExerciseList.call(GetActivityHistoryParam(type: ['ACTIVE_ENERGY_BURNED'], dateFrom: currentDate, dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      exerciseHistoryList.assignAll(r);
    });
  }

  void saveExerciseTarget() async {
    var userData = Get.find<DashboardController>().user.value;
    var newUserData = userData.copyWith(exerciseGoalKcal: selectedExerciseTarget.value.value());
    UpdateUserInfo updateUserInfo = UpdateUserInfo.instance();
    EasyLoading.show();
    final result = await updateUserInfo.call(
      UpdateUserInfoParams(
        firstName: newUserData.firstName ?? "",
        lastName: newUserData.lastName ?? "",
        height: newUserData.height ?? 0,
        weight: newUserData.weight ?? 0,
        gender: newUserData.gender ?? "",
        dob: DateFormat('yyyy-MM-dd').format(DateTime.parse(newUserData.birthDate ?? "")),
        weightTarget: newUserData.weightTarget ?? 0,
        exerciseGoalKcal: newUserData.exerciseGoalKcal ?? 0,
        language: newUserData.language ?? "",
      ),
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
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59, 0, 0);
    var result = await getExerciseData(GetExerciseParams(type: HealthDataType.STEPS.name, dateFrom: currentDate, dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      // sum all value from object r and assign it to steps
      steps.value = r.totalValue ?? 0;
      stepsValueNotifier.value = steps.value.toDouble() / (Get.find<DashboardController>().user.value.stepsGoalCount ?? 0);
    });
  }

  int getGoalPercentage() {
    var userData = Get.find<DashboardController>().user.value;
    var goal = userData.exerciseGoalKcal ?? 0;
    var percentage = (burntCalories.value / goal) * 100;
    if (percentage.isNaN || percentage.isInfinite) {
      return 0;
    } else {
      return percentage.roundToDouble().toInt() > 100 ? 100 : percentage.roundToDouble().toInt();
    }
  }

  Future<void> getBurntCaloriesData() async {
    GetExerciseData getExerciseData = GetExerciseData.instance();
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59, 0, 0);
    var result = await getExerciseData(GetExerciseParams(type: HealthDataType.ACTIVE_ENERGY_BURNED.name, dateFrom: currentDate, dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      // sum all value from object r and assign it to burntCalories
      if (r.details != null) {
        for (var element in r.details!) {
          burntCalories.value += element.value!;
        }
      }
      totalCalories.value = burntCalories.value;
      caloriesValueNotifier.value = burntCalories.value.toDouble();
      goalValueNotifier.value = burntCalories.value.toDouble() / (Get.find<DashboardController>().user.value.exerciseGoalKcal ?? 0);
    });
  }
}

enum ExerciseTab { diaries, classes }
