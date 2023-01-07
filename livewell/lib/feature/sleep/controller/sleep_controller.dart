import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_exercise_list.dart';

class SleepController extends GetxController {
  Rx<String> wentToSleep = ''.obs;
  Rx<String> wokeUp = ''.obs;
  Rx<String> feelASleep = ''.obs;
  Rx<String> deepSleep = ''.obs;
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

  Future<void> getSleepData() async {
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day - 1, 12, 0, 0, 0, 0);
    var dateTill = currentDate.add(const Duration(days: 1));
    GetExerciseData getExerciseData = GetExerciseData.instance();
    var result = await getExerciseData(GetExerciseParams(
        type: HealthDataType.SLEEP_IN_BED.name,
        dateFrom: currentDate,
        dateTo: dateTill));
    result.fold((l) => Log.error(l), (r) {
      // sum all value from object r and assign it to steps
      if (r.details?.isEmpty ?? true) {
        return;
      }
      calculateSleep(
          DateTime.parse(
              r.details?.first.dateFrom ?? DateTime.now().toString()),
          DateTime.parse(r.details?.first.dateTo ?? DateTime.now().toString()),
          r.totalValue ?? 0);
    });
  }

  void calculateSleep(DateTime wentToSleep, DateTime wokeUp, num value) {
    // calculate sleep
    var dateFormatter = DateFormat('hh:mm a');
    this.wentToSleep.value = dateFormatter.format(wentToSleep);
    this.wokeUp.value = dateFormatter.format(wokeUp);
    deepSleep.value = durationToString(_calculateDeepSleep(value).toInt());
    feelASleep.value = durationToString(_calculateFeelASleep(value).toInt());
  }

  num _calculateDeepSleep(num totalSleep) {
    // calculate deep sleep
    return totalSleep * 0.2;
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
