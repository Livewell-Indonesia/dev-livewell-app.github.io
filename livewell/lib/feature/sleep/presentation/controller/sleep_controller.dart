import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/controller/user_diary_controller.dart';
import 'package:livewell/feature/exercise/data/model/activity_history_model.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_activity_histories.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/sleep/data/model/sleep_activity_model.dart' as sleep;
import 'package:livewell/feature/sleep/domain/usecase/get_sleep_history.dart';
import 'package:livewell/feature/sleep/domain/usecase/get_sleep_list.dart';
import 'package:livewell/feature/streak/domain/usecase/refresh_wellness_data.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';
import 'package:livewell/core/base/base_controller.dart';

class SleepController extends BaseController {
  Rx<String> wentToSleep = ''.obs;
  Rx<String> wokeUp = ''.obs;
  Rx<String> feelASleep = ''.obs;
  Rx<String> deepSleep = ''.obs;
  Rx<double> deepSleepPercent = 0.0.obs;
  Rx<double> lightSleepPercent = 0.0.obs;
  Rx<double> totalSleepPercent = 0.0.obs;
  Rx<double> leftSleepPercent = 0.0.obs;
  Rx<double> sleepInBedPercent = 0.0.obs;
  Rx<double> sleepInBedValue = 0.0.obs;
  Rx<int> userGoal = 0.obs;

  RxList<ActivityHistoryModel> exerciseHistoryList = <ActivityHistoryModel>[].obs;

  TextEditingController manualSleepInput = TextEditingController();
  TextEditingController manualWakeUpInput = TextEditingController();
  Rx<DateTime> sleepInput = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1, 22, 0).obs;
  Rx<DateTime> wakeUpInput = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6, 0).obs;
  Rx<double> finalSleepValue = 0.0.obs;
  final yValues = <double>[].obs;
  @override
  void onInit() {
    super.onInit();
    getSleepData();
    getExerciseHistorydata();
    getAllYvaluesFromApi();
    showInfoFirstTime();
    wentToSleep = ''.obs;
    wokeUp = ''.obs;
    feelASleep = ''.obs;
    deepSleep = ''.obs;
    deepSleepPercent = 0.0.obs;
    lightSleepPercent = 0.0.obs;
    totalSleepPercent = 0.0.obs;
    leftSleepPercent = 0.0.obs;
    sleepInBedPercent = 0.0.obs;
    sleepInBedValue = 0.0.obs;
    userGoal = 0.obs;
    manualSleepInput.clear();
    yValues.clear();
    manualWakeUpInput.clear();
    manualSleepInput.text = DateFormat('hh:mm a').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1, 22, 0));
    manualWakeUpInput.text = DateFormat('hh:mm a').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6, 0));
  }

  void refreshList() async {
    wentToSleep = ''.obs;
    wokeUp = ''.obs;
    feelASleep = ''.obs;
    deepSleep = ''.obs;
    deepSleepPercent = 0.0.obs;
    lightSleepPercent = 0.0.obs;
    totalSleepPercent = 0.0.obs;
    leftSleepPercent = 0.0.obs;
    sleepInBedPercent = 0.0.obs;
    sleepInBedValue = 0.0.obs;
    userGoal = 0.obs;
    manualSleepInput.clear();
    yValues.clear();
    manualWakeUpInput.clear();
    getSleepData();
    showInfoFirstTime();
    //getExerciseHistorydata();
    getAllYvaluesFromApi();
    refreshWellness();
  }

  void refreshWellness() async {
    RefreshWellnessData refreshWellnessData = RefreshWellnessData.instance();
    await refreshWellnessData.call('SLEEP');
  }

  void getNewSleepHistoryData() async {
    // GetSleepHistory getSleepHistory = GetSleepHistory.instance();
    // var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
    //     DateTime.now().day - 7, 0, 0, 0, 0, 0);
    // var dateTill = DateTime(DateTime.now().year, DateTime.now().month,
    //     DateTime.now().day, 23, 59, 59, 0, 0);
    // final result = await getSleepHistory.call(GetSleepHistoryParams(
    //     dateFrom: DateFormat('yyyy-MM-dd').format(currentDate),
    //     dateTo: DateFormat('yyyy-MM-dd').format(dateTill)));
    // result.fold((l) {}, (r) {
    //   r.response?.entries.forEach((element) {
    //     var temp = ActivityHistoryModel(
    //         details: element.value.details?.map((e) {
    //           return Details(
    //               value: e.value,
    //               type: e.type,
    //               unit: e.unit?.name,
    //               dateFrom: e.dateFrom,
    //               dateTo: e.dateTo);
    //         }).toList(),
    //         totalValue: element.value.total,
    //         type: element.key,
    //         unit: 'min',
    //         dateFrom: DateFormat('yyyy-MM-dd').format(currentDate),
    //         dateTo: DateFormat('yyyy-MM-dd').format(dateTill));
    //     exerciseHistoryList.add(temp);
    //   });
    // });
  }

  void showInfoFirstTime() async {
    var show = await SharedPref.showInfoSleep();
    HomeController controller = Get.find();
    var data = controller.popupAssetsModel.value.sleep;
    if (show && (data != null) && Get.currentRoute == AppPages.sleepScreen) {
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
      SharedPref.saveShowInfoSleep(false);
    }
  }

  var types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_IN_BED,
  ];

  var permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  Future<double> getYvalueFromApi(DateTime dateFrom, DateTime dateTo) async {
    var y = 0.0;
    GetActivityHistory getExerciseList = GetActivityHistory.instance();
    final result = await getExerciseList.call(GetActivityHistoryParam(type: ['SLEEP_IN_BED', 'LIGHT_SLEEP', 'DEEP_SLEEP'], dateFrom: dateFrom, dateTo: dateTo));
    result.fold((l) {
      y = 0.0;
    }, (r) {
      y = r.fold(0, (previousValue, element) {
        var temp = element.totalValue ?? 0.0;
        return previousValue + temp;
      });
    });
    return y;
  }

  double getYValue(int index) {
    return yValues[index] / 60;
    // var value = 0.0;
    // if (exerciseHistoryList.isNotEmpty) {
    //   var date = DateTime(DateTime.now().year, DateTime.now().month,
    //       DateTime.now().day - 6 + index);
    //   var rangeDateFrom =
    //       DateTime(date.year, date.month, date.day - 1, 18, 0, 0, 0, 0);
    //   var rangeDateTo =
    //       DateTime(date.year, date.month, date.day, 17, 59, 59, 0, 0);
    //   for (var data in exerciseHistoryList) {
    //     var temp = 0.0;
    //     if (data.details != null) {
    //       for (var element in data.details!) {
    //         var currentDate = DateTime.parse(element.dateFrom!);
    //         if ((currentDate.isAfter(rangeDateFrom) &&
    //                 currentDate.isBefore(rangeDateTo) ||
    //             currentDate.isBefore(rangeDateTo))) {
    //           temp += element.value!;
    //         }
    //       }
    //     }
    //     value += temp;
    //   }
    // }
    // return value == 0.0 ? value : (value / 60);
  }

  bool isYValueOptimal(int index) {
    var value = getYValue(index);
    var minimum = userGoal.value * 0.8;
    if (value >= minimum) {
      return true;
    }
    return false;
  }

  double? getMaxYValue() {
    // get maxY value by comparing exercisehistorylist value with user goal
    var temp = [];
    for (var i = 0; i < 7; i++) {
      temp.add(getYValue(i));
    }
    // check if any value inside temp bigger temp user goal
    temp.sort();
    if (temp.last < userGoal.value) {
      return userGoal.value.toDouble();
    }
    return null;
  }

  String getXValue(int index) {
    String value = '';
    var date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 6 + index);
    value = DateFormat('dd/MM').format(date);
    return value;
  }

  Future<void> getAllYvaluesFromApi() async {
    GetSleepHistory getSleepHistory = GetSleepHistory.instance();
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 6);
    var dateTill = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final result = await getSleepHistory.call(GetSleepHistoryParams(dateFrom: DateFormat('yyyy-MM-dd').format(currentDate), dateTo: DateFormat('yyyy-MM-dd').format(dateTill)));
    result.fold((l) {
      Log.error(l);
    }, (r) {
      r.response?.entries.forEach((element) {
        yValues.add(element.value.total?.toDouble() ?? 0.0);
      });
      Log.colorGreen(r.response?.entries.toString());
      update();
    });
  }

  Future<void> getExerciseHistorydata() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59, 0, 0);
    GetActivityHistory getExerciseList = GetActivityHistory.instance();
    final result = await getExerciseList.call(GetActivityHistoryParam(type: ['SLEEP_IN_BED', 'LIGHT_SLEEP', 'DEEP_SLEEP'], dateFrom: currentDate, dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      exerciseHistoryList.assignAll(r);
    });
  }

  Future<void> getSleepData() async {
    var getSleepData = GetSleepData.instance();
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1, 18, 0, 0);
    var dateTill = currentDate.add(const Duration(hours: 24));
    var result = await getSleepData(GetSleepParams(type: ['SLEEP_IN_BED', 'LIGHT_SLEEP', 'DEEP_SLEEP'], dateFrom: currentDate, dateTo: dateTill));
    result.fold((l) {
      Log.error(l);
    }, (r) {
      if (r.isNotEmpty) {
        var lightSleepValue = r.where((element) => element.type == 'LIGHT_SLEEP').toList();
        var deepSleepValue = r.where((element) => element.type == 'DEEP_SLEEP').toList();
        var sleepInBedValue = r.where((element) => element.type == 'SLEEP_IN_BED').toList();
        if (isContainManualInput(sleepInBedValue)) {
          calculateManualSleep(sleepInBedValue);
        } else if (lightSleepValue.first.details != null && deepSleepValue.first.details != null) {
          calculateDeepSleepAndLightSleep(lightSleepValue, deepSleepValue);
        } else if (sleepInBedValue.isNotEmpty) {
          if (sleepInBedValue.first.totalValue != 0) {
            calculateSleepInBed(sleepInBedValue);
            this.sleepInBedValue.value = sleepInBedValue.first.totalValue?.toDouble() ?? 0.0;
          }
        }
      }
    });
  }

  bool isContainManualInput(List<sleep.SleepActivityModel> value) {
    var result = false;
    if (value.isNotEmpty) {
      for (var element in value.first.details ?? []) {
        if (element.sourceName == 'manual') {
          result = true;
        }
      }
    }
    return result;
  }

  void calculateManualSleep(List<sleep.SleepActivityModel> value) {
    wentToSleep.value = DateFormat('hh:mm a').format(DateTime.parse(value.first.details?.first.dateFrom ?? DateTime.now().toIso8601String()));
    wokeUp.value = DateFormat('hh:mm a').format(DateTime.parse(value.first.details?.first.dateTo ?? (value.first.details?.first.dateFrom ?? "")));
    if (Get.isRegistered<DashboardController>()) {
      var sleepValue = Get.find<DashboardController>().user.value.onboardingQuestionnaire?.sleepDuration ?? "7";
      var sleepDuration = int.parse(sleepValue);
      sleepInBedPercent.value = (((value.first.totalValue ?? 0) / 60) / sleepDuration).maxOneOrZero;
      userGoal.value = sleepDuration;
      totalSleepPercent.value = sleepInBedPercent.value * 100;
      leftSleepPercent.value = 100 - totalSleepPercent.value;
      feelASleep.value = durationToString(0.toInt());
      deepSleep.value = durationToString(0.toInt());
      var tempFinalSleepValue = (value.first.details?.first.value?.toDouble() ?? 0.0);
      finalSleepValue.value = tempFinalSleepValue == 0.0 ? tempFinalSleepValue : tempFinalSleepValue / 60;
      update();
    }
  }

  void calculateSleepInBed(List<sleep.SleepActivityModel> sleepInBedValue) {
    Log.colorGreen(sleepInBedValue.first);
    wentToSleep.value = DateFormat('hh:mm a').format(DateTime.parse(sleepInBedValue.first.details?.first.dateFrom ?? DateTime.now().toIso8601String()));
    wokeUp.value = DateFormat('hh:mm a').format(DateTime.parse(sleepInBedValue.first.details?.last.dateTo ?? (sleepInBedValue.first.details?.last.dateFrom ?? "")));
    if (Get.isRegistered<DashboardController>()) {
      var sleepValue = Get.find<DashboardController>().user.value.onboardingQuestionnaire?.sleepDuration ?? "7";
      var sleepDuration = int.parse(sleepValue);
      sleepInBedPercent.value = (((sleepInBedValue.first.totalValue ?? 0) / 60) / sleepDuration).maxOneOrZero;
      userGoal.value = sleepDuration;
      totalSleepPercent.value = sleepInBedPercent.value * 100;
      leftSleepPercent.value = 100 - totalSleepPercent.value;
      feelASleep.value = durationToString(0.toInt());
      deepSleep.value = durationToString(0.toInt());
      var tempFinalSleepValue = (sleepInBedValue.first.totalValue?.toDouble() ?? 0.0);
      finalSleepValue.value = tempFinalSleepValue == 0.0 ? tempFinalSleepValue : tempFinalSleepValue / 60;
      update();
    }
  }

  void sendExerciseDataManual() async {
    final usecase = PostExerciseData.instance();
    EasyLoading.show();
    Duration duration = wakeUpInput.value.difference(sleepInput.value).abs();
    final result = await usecase.call(PostExerciseParams.manualInputDate(duration.inMinutes.toDouble(), HealthDataType.SLEEP_IN_BED, sleepInput.value, wakeUpInput.value));

    result.fold((l) {}, (r) {
      refreshList();
      manualSleepInput.clear();
      manualWakeUpInput.clear();
      if (Get.isRegistered<UserDiaryController>()) {
        Get.find<UserDiaryController>().refreshList();
      }
      Get.back();
    });
    EasyLoading.dismiss();
  }

  void calculateDeepSleepAndLightSleep(List<sleep.SleepActivityModel> lightSleepValue, List<sleep.SleepActivityModel> deepSleepValue) {
    feelASleep.value = durationToString(lightSleepValue.first.totalValue?.toInt() ?? 0);
    deepSleep.value = durationToString(deepSleepValue.first.totalValue?.toInt() ?? 0);
    var newValue = lightSleepValue.first.details ?? [];
    newValue.addAll(deepSleepValue.first.details ?? []);

    var listDateFrom = newValue.map((e) {
      DateTime tempDate = DateTime.parse(e.dateFrom ?? "");
      return tempDate;
    }).toList();
    var listDateTo = newValue.map((e) {
      DateTime tempDate = DateTime.parse(e.dateTo ?? "");
      return tempDate;
    }).toList();
    listDateFrom.sort((a, b) => a.compareTo(b));
    listDateTo.sort((a, b) => a.compareTo(b));
    wentToSleep.value = DateFormat('hh:mm a').format(listDateFrom.first);
    wokeUp.value = DateFormat('hh:mm a').format(listDateTo.last);
    if (Get.isRegistered<DashboardController>()) {
      var sleepValue = Get.find<DashboardController>().user.value.onboardingQuestionnaire?.sleepDuration ?? "7";
      var sleepd = int.parse(sleepValue);
      deepSleepPercent.value = (((deepSleepValue.first.totalValue ?? 0) / 60) / (sleepd * 0.2)).maxOneOrZero;
      lightSleepPercent.value = ((lightSleepValue.first.totalValue ?? 0) / 60) / (sleepd * 0.8).maxOneOrZero;
      totalSleepPercent.value = ((((deepSleepValue.first.totalValue ?? 0) / 60) + ((lightSleepValue.first.totalValue ?? 0) / 60)) / sleepd).maxOneOrZero * 100;
      leftSleepPercent.value = 100 - totalSleepPercent.value;
      var tempFinalLightSleepValue = (lightSleepValue.first.totalValue?.toDouble() ?? 0.0);
      var tempFinalDeepSleepValue = (deepSleepValue.first.totalValue?.toDouble() ?? 0.0);
      finalSleepValue.value =
          (tempFinalLightSleepValue + tempFinalDeepSleepValue) == 0.0 ? (tempFinalLightSleepValue + tempFinalDeepSleepValue) : (tempFinalLightSleepValue + tempFinalDeepSleepValue) / 60;
      update();
    }
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')} ${Get.find<DashboardController>().localization.sleepPage?.hrs ?? 'hrs'}';
  }
}

extension on double {
  double get maxOneOrZero {
    if (this > 1) {
      return 1;
    } else if (this < 0) {
      return 0;
    } else {
      return this;
    }
  }
}
