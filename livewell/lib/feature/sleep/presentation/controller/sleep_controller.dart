import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/exercise/data/model/activity_history_model.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_activity_histories.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/sleep/data/model/sleep_activity_model.dart';
import 'package:livewell/feature/sleep/domain/usecase/get_sleep_list.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';

class SleepController extends GetxController {
  Rx<String> wentToSleep = ''.obs;
  Rx<String> wokeUp = ''.obs;
  Rx<String> feelASleep = ''.obs;
  Rx<String> deepSleep = ''.obs;
  Rx<double> deepSleepPercent = 0.0.obs;
  Rx<double> lightSleepPercent = 0.0.obs;
  Rx<double> totalSleepPercent = 0.0.obs;
  Rx<double> leftSleepPercent = 0.0.obs;
  Rx<double> sleepInBedPercent = 0.0.obs;

  RxList<ActivityHistoryModel> exerciseHistoryList =
      <ActivityHistoryModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    getSleepData();
    getExerciseHistorydata();
    showInfoFirstTime();
  }

  void showInfoFirstTime() async {
    var show = await SharedPref.showInfoSleep();
    HomeController controller = Get.find();
    var data = controller.popupAssetsModel.value.sleep;
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
      SharedPref.saveShowInfoSleep(false);
    }
  }

  HealthFactory healthFactory = HealthFactory();

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

  double getYValue(int index) {
    var value = 0.0;
    if (exerciseHistoryList.isNotEmpty) {
      var date = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day - 6 + index);
      for (var data in exerciseHistoryList) {
        var temp = 0.0;
        if (data.details != null) {
          for (var element in data.details!) {
            var currentDate =
                DateFormat('yyyy-MM-dd HH:mm:ss').parse(element.dateFrom!);
            if (currentDate.day == date.day &&
                currentDate.month == date.month &&
                currentDate.year == date.year) {
              temp += element.value!;
            }
          }
        }
        value += temp;
      }
    }
    return value == 0.0 ? value : (value / 60);
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

  Future<void> getExerciseHistorydata() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day - 7, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 23, 59, 59, 0, 0);
    GetActivityHistory getExerciseList = GetActivityHistory.instance();
    final result = await getExerciseList.call(GetActivityHistoryParam(
        type: ['SLEEP_IN_BED', 'LIGHT_SLEEP', 'DEEP_SLEEP'],
        dateFrom: currentDate,
        dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      Log.info(r);
      inspect(r);
      exerciseHistoryList.assignAll(r);
    });
  }

  Future<void> getSleepData() async {
    var getSleepData = GetSleepData.instance();
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day - 1, 18, 0, 0);
    var dateTill = currentDate.add(const Duration(hours: 24));
    var result = await getSleepData(GetSleepParams(
        type: ['SLEEP_IN_BED', 'LIGHT_SLEEP', 'DEEP_SLEEP'],
        dateFrom: currentDate,
        dateTo: dateTill));
    result.fold((l) {
      Log.error(l);
    }, (r) {
      inspect(r);
      if (r.isNotEmpty) {
        var lightSleepValue =
            r.where((element) => element.type == 'LIGHT_SLEEP').toList();
        var deepSleepValue =
            r.where((element) => element.type == 'DEEP_SLEEP').toList();
        var sleepInBedValue =
            r.where((element) => element.type == 'SLEEP_IN_BED').toList();
        if (lightSleepValue.first.details != null &&
            deepSleepValue.first.details != null) {
          calculateDeepSleepAndLightSleep(lightSleepValue, deepSleepValue);
        } else if (sleepInBedValue.isNotEmpty) {
          if (sleepInBedValue.first.totalValue != 0) {
            calculateSleepInBed(sleepInBedValue);
          }
        }
      }
    });
  }

  void calculateSleepInBed(List<SleepActivityModel> sleepInBedValue) {
    wentToSleep.value = DateFormat('hh:mm a').format(DateTime.parse(
        sleepInBedValue.first.details?.first.dateFrom ??
            DateTime.now().toIso8601String()));
    wokeUp.value = DateFormat('hh:mm a').format(
        DateTime.parse(sleepInBedValue.first.details?.first.dateTo ?? ""));
    if (Get.isRegistered<DashboardController>()) {
      var sleepValue = Get.find<DashboardController>()
              .user
              .value
              .onboardingQuestionnaire
              ?.sleepDuration ??
          "7";
      var sleepDuration = int.parse(sleepValue);
      sleepInBedPercent.value =
          (((sleepInBedValue.first.totalValue ?? 0) / 60) / sleepDuration)
              .maxOneOrZero;
      totalSleepPercent.value = sleepInBedPercent.value * 100;
      leftSleepPercent.value = 100 - totalSleepPercent.value;
      feelASleep.value = durationToString(0.toInt());
      deepSleep.value = durationToString(0.toInt());
    }
  }

  void calculateDeepSleepAndLightSleep(List<SleepActivityModel> lightSleepValue,
      List<SleepActivityModel> deepSleepValue) {
    feelASleep.value = durationToString(lightSleepValue.first.totalValue ?? 0);
    deepSleep.value = durationToString(deepSleepValue.first.totalValue ?? 0);
    var newValue = lightSleepValue.first.details ?? [];
    newValue.addAll(deepSleepValue.first.details ?? []);

    var listDateFrom = newValue.map((e) {
      DateTime tempDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').parse(e.dateFrom ?? "");
      return tempDate;
    }).toList();
    var listDateTo = newValue.map((e) {
      DateTime tempDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').parse(e.dateTo ?? "");
      return tempDate;
    }).toList();
    listDateFrom.sort((a, b) => a.compareTo(b));
    listDateTo.sort((a, b) => a.compareTo(b));
    wentToSleep.value = DateFormat('hh:mm a').format(listDateFrom.first);
    wokeUp.value = DateFormat('hh:mm a').format(listDateTo.last);
    if (Get.isRegistered<DashboardController>()) {
      var sleepValue = Get.find<DashboardController>()
              .user
              .value
              .onboardingQuestionnaire
              ?.sleepDuration ??
          "7";
      var sleepd = int.parse(sleepValue);
      deepSleepPercent.value =
          (((deepSleepValue.first.totalValue ?? 0) / 60) / (sleepd * 0.2))
              .maxOneOrZero;
      lightSleepPercent.value = ((lightSleepValue.first.totalValue ?? 0) / 60) /
          (sleepd * 0.8).maxOneOrZero;
      totalSleepPercent.value =
          ((((deepSleepValue.first.totalValue ?? 0) / 60) +
                          ((lightSleepValue.first.totalValue ?? 0) / 60)) /
                      sleepd)
                  .maxOneOrZero *
              100;
      leftSleepPercent.value = 100 - totalSleepPercent.value;
    }
  }

  num _calculateDeepSleep(num totalSleep) {
    // calculate deep sleep
    return totalSleep * 0.2;
  }

  void calculateDeepSleepPercent(num totalSleep) {
    deepSleepPercent.value = totalSleep / _calculateDeepSleep(totalSleep);
  }

  void calculateLightSleepPercent(num totalSleep) {
    lightSleepPercent.value = totalSleep / _calculateFeelASleep(totalSleep);
  }

  num _calculateFeelASleep(num totalSleep) {
    // calculate feel a sleep
    return totalSleep * 0.8;
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')} Min';
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

  double maxOrZero(double max) {
    if (this > max) {
      return max;
    } else if (this < 0) {
      return 0;
    } else {
      return this;
    }
  }
}
