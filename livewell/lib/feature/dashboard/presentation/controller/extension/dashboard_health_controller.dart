import 'dart:io';

import 'package:flutter_health_fit/flutter_health_fit.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:permission_handler/permission_handler.dart';

extension DashboardHealthController on DashboardController {
  Future<bool> isHealthAuthorized() async {
    if (Platform.isAndroid && !isAllowedToFetchFromGoogleHealth()) {
      return false;
    }
    if (await Permission.activityRecognition.isDenied) {
      final status = await Permission.activityRecognition.request();
      if (status.isGranted) {
        return true;
      } else {
        if (Platform.isAndroid) {
          return false;
        } else {
          return true;
        }
      }
    } else {
      return true;
    }
  }

  void fetchHealthDataFromLocal() async {
    if (await isHealthAuthorized()) {
      if (await hasPermissionForHealthData()) {
        fetchSleepDataFromLocal();
        fetchExerciseDataFromLocal();
      } else {
        var isAuthorized = await askForAuthorization();
        if (isAuthorized) {
          fetchSleepDataFromLocal();
          fetchExerciseDataFromLocal();
        }
      }
    }
  }

  bool isAllowedToFetchFromGoogleHealth() {
    var allowGoogleHealth = Get.find<HomeController>().appConfigModel.value.googleHealth ?? false;
    return allowGoogleHealth;
  }

  Future<bool> askForAuthorization() {
    return healthFactory.requestAuthorization(types, permissions: permissions);
  }

  Future<bool> hasPermissionForHealthData() async {
    bool isAllowed = false;
    isAllowed = await healthFactory.hasPermissions(types) ?? false;
    return isAllowed;
  }

  void fetchSleepDataFromLocal() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1, 12, 0, 0, 0, 0);
    var dateTill = currentDate.add(const Duration(days: 1));
    if (Platform.isIOS) {
      fetchSleepDataFromLocaliOS(currentDate, dateTill);
    } else {
      fetchSleepDataFromLocalAndroid(currentDate, dateTill);
    }
  }

  void fetchSleepDataFromLocaliOS(DateTime currentDate, DateTime dateTill) async {
    var data = await healthFit.getSleepIOS(currentDate.millisecondsSinceEpoch, dateTill.millisecondsSinceEpoch);
    List<CustomHealthDataPoint> newData = [];
    if (data != null) {
      for (var element in data) {
        newData.add(element.toCustomHealthDataPoint(PlatformType.IOS, element.type));
      }
    }
    saveSleepData(newData);
  }

  void fetchSleepDataFromLocalAndroid(DateTime currentDate, DateTime dateTill) async {
    var data = await healthFit.getSleepAndroid(currentDate.millisecondsSinceEpoch, dateTill.millisecondsSinceEpoch);
    List<CustomHealthDataPoint> newData = [];
    if (data != null) {
      for (var element in data) {
        newData.add(element.toCustomHealthDataPoint(PlatformType.ANDROID, element.gfSleepSampleType));
      }
    }
    saveSleepData(newData);
  }

  void saveSleepData(List<CustomHealthDataPoint> newData) async {
    var filteredData = await filterSleepData(newData);
    if (filteredData.isNotEmpty) {
      var postSleepData = PostExerciseData.instance();
      final result = await postSleepData.call(PostExerciseParams.fromCustomHealth(filteredData));
      result.fold((l) {
        Log.error(l);
      }, (r) async {
        Log.info(r);
        await SharedPref.saveLastSleepSyncDate(filteredData.last.startDate);
      });
    }
  }

  void fetchExerciseDataFromLocal() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0, 0, 0);
    var dateTill = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59, 0, 0);
    List<HealthDataPoint> healthData = await healthFactory.getHealthDataFromTypes(currentDate, dateTill, [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED]);
    healthData.sort((a, b) => a.dateFrom.compareTo(b.dateFrom));
    healthData = await filterExerciseData(healthData);
    if (healthData.isNotEmpty) {
      postExerciseData(PostExerciseParams.fromHealth(healthData), healthData.last.dateFrom);
    } else {
      getExerciseHistorydata();
    }
  }

  void postExerciseData(PostExerciseParams params, DateTime lastSyncedAt) async {
    final result = await PostExerciseData.instance().call(params);
    result.fold((l) {
      Log.error(l);
    }, (r) async {
      await SharedPref.saveLastStepSyncDate(lastSyncedAt);
      getExerciseHistorydata();
    });
  }

  Future<List<HealthDataPoint>> filterExerciseData(List<HealthDataPoint> healthData) async {
    var lastSyncedAt = await SharedPref.getLastStepSyncDate();
    healthData.sort((a, b) => a.dateFrom.compareTo(b.dateFrom));
    if (lastSyncedAt == null) {
      return healthData;
    } else {
      return healthData.where((element) => element.dateFrom.isAfter(lastSyncedAt)).toList();
    }
  }

  Future<List<CustomHealthDataPoint>> filterSleepData(List<CustomHealthDataPoint> healthData) async {
    var lastSyncedAt = await SharedPref.getLastSleepSyncDate();
    healthData.sort((a, b) => a.startDate.compareTo(b.startDate));
    if (lastSyncedAt == null) {
      return healthData;
    } else {
      return healthData.where((element) => element.startDate.isAfter(lastSyncedAt)).toList();
    }
  }
}

extension on SleepSample {
  CustomHealthDataPoint toCustomHealthDataPoint(PlatformType platformType, SleepSampleType type) {
    var value = end.difference(start).inMinutes;
    switch (type) {
      case SleepSampleType.asleepREM:
        return CustomHealthDataPoint(value: value, type: 'REM_SLEEP', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case SleepSampleType.asleepDeep:
        return CustomHealthDataPoint(value: value, type: 'DEEP_SLEEP', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case SleepSampleType.asleepCore:
        return CustomHealthDataPoint(value: value, type: 'LIGHT_SLEEP', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case SleepSampleType.asleepUnspecified:
        return CustomHealthDataPoint(value: value, type: 'SLEEP_IN_BED', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case SleepSampleType.awake:
        return CustomHealthDataPoint(value: value, type: 'SLEEP_AWAKE', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case SleepSampleType.inBed:
        return CustomHealthDataPoint(value: value, type: 'SLEEP_IN_BED', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      default:
        return CustomHealthDataPoint(value: value, type: 'UNSPECIFIED', unit: 'MINUTES', startDate: start, endDate: end, source: source);
    }
  }
}

extension on GFSleepSample {
  CustomHealthDataPoint toCustomHealthDataPoint(PlatformType platformType, GFSleepSampleType type) {
    var value = end.difference(start).inMinutes;
    switch (type) {
      case GFSleepSampleType.sleepDeep:
        return CustomHealthDataPoint(value: value, type: 'DEEP_SLEEP', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case GFSleepSampleType.sleepLight:
        return CustomHealthDataPoint(value: value, type: 'LIGHT_SLEEP', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case GFSleepSampleType.unspecified:
        return CustomHealthDataPoint(value: value, type: 'SLEEP_IN_BED', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case GFSleepSampleType.sleepRem:
        return CustomHealthDataPoint(value: value, type: 'REM_SLEEP', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case GFSleepSampleType.sleep:
        return CustomHealthDataPoint(value: value, type: 'SLEEP_IN_BED', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case GFSleepSampleType.outOfBed:
        return CustomHealthDataPoint(value: value, type: 'OUT_OF_BED', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      case GFSleepSampleType.awake:
        return CustomHealthDataPoint(value: value, type: 'SLEEP_AWAKE', unit: 'MINUTES', startDate: start, endDate: end, source: source);
      default:
        return CustomHealthDataPoint(value: value, type: 'UNSPECIFIED', unit: 'MINUTES', startDate: start, endDate: end, source: source);
    }
  }
}

class CustomHealthDataPoint {
  num value;
  String type;
  String unit;
  DateTime startDate;
  DateTime endDate;
  String source;

  CustomHealthDataPoint({required this.value, required this.type, required this.unit, required this.startDate, required this.endDate, required this.source});

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'data_type': type,
      'unit': unit,
      'date_from': startDate.toIso8601String(),
      'date_to': endDate.toIso8601String(),
      'source_name': source,
    };
  }
}
