import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_exercise_list.dart';

class SleepController extends GetxController {
  Rx<String> wentToSleep = ''.obs;
  Rx<String> wokeUp = ''.obs;
  Rx<String> feelASleep = ''.obs;
  Rx<String> deepSleep = ''.obs;
  Rx<double> deepSleepPercent = 0.0.obs;
  Rx<double> lightSleepPercent = 0.0.obs;
  Rx<double> totalSleepPercent = 0.0.obs;
  Rx<double> leftSleepPercent = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    getSleepData();
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

  Future<void> getSleepData() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day - 1, 12, 0, 0, 0, 0);
    var dateTill = currentDate.add(const Duration(days: 1));
    GetExerciseData getExerciseData = GetExerciseData.instance();
    var deepSleepResult = await getExerciseData(GetExerciseParams(
        type: "DEEP_SLEEP", dateFrom: currentDate, dateTo: dateTill));
    var lightSleepResult = await getExerciseData(GetExerciseParams(
        type: "LIGHT_SLEEP", dateFrom: currentDate, dateTo: dateTill));

    lightSleepResult.fold((l) => Log.error(l), (r) {
      // sum all value from object r and assign it to steps
      if (r.details?.isEmpty ?? true) {
        return;
      }
      var dateFormatter = DateFormat('hh:mm a');
      wentToSleep.value = dateFormatter.format(DateTime.parse(
          r.details?.last.dateFrom ?? DateTime.now().toString()));
      feelASleep.value = durationToString((r.totalValue ?? 0).toInt());

      deepSleepResult.fold((l) => Log.error(l), (r2) {
        // sum all value from object r and assign it to steps
        if (r.details?.isEmpty ?? true) {
          return;
        }
        var dateFormatter = DateFormat('hh:mm a');
        // dapet data woke up dari start light sleep + total value deep sleep and light sleep
        var wokeUpDate = DateTime.parse(
                r.details?.last.dateFrom ?? DateTime.now().toString())
            .add(Duration(
                minutes: ((r2.totalValue ?? 0).toInt() +
                    (r.totalValue ?? 0).toInt())));
        wokeUp.value = dateFormatter.format(wokeUpDate);
        deepSleep.value = durationToString((r2.totalValue ?? 0).toInt());
        if (Get.isRegistered<DashboardController>()) {
          var sleepValue = Get.find<DashboardController>()
                  .user
                  .value
                  .onboardingQuestionnaire
                  ?.sleepDuration ??
              "7";
          var sleepDuration = int.parse(sleepValue);

          deepSleepPercent.value =
              (((r2.totalValue ?? 0.0) / 60) / (sleepDuration * 0.2));
          lightSleepPercent.value =
              (((r.totalValue ?? 0.0) / 60) / (sleepDuration * 0.8));
          totalSleepPercent.value =
              ((((r2.totalValue ?? 0.0) / 60) + ((r.totalValue ?? 0.0) / 60)) /
                      (sleepDuration)) *
                  100;
          leftSleepPercent.value = 100 - totalSleepPercent.value;
        }
      });
    });
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
}
