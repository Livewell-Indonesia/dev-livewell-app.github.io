import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/mood/presentation/widget/mood_picker_widget.dart';
import 'package:livewell/feature/streak/domain/entity/streak_entity.dart';
import 'package:livewell/feature/streak/domain/usecase/get_total_streak.dart';
import 'package:livewell/feature/streak/domain/usecase/get_wellness_data_batch.dart';
import 'package:livewell/feature/streak/domain/usecase/get_wellness_detail.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_calendar.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';

class StreakController extends BaseController {
  RxList<StreakCalendarItemModel> streakDates = <StreakCalendarItemModel>[].obs;
  RxList<StreakEntity> streakData = <StreakEntity>[].obs;
  RxList<StreakItemModel> selectedStreak = <StreakItemModel>[].obs;
  Rx<int> numberOfStreaks = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<int> todayProgress = 0.obs;

  @override
  void onInit() {
    generateFirstStreakDates();
    getTotalStreak();
    selectedStreak.clear();
    todayProgress.value = 0;
    numberOfStreaks.value = 0;
    super.onInit();
  }

  void generateFirstStreakDates() {
    List<DateTime> dates = generateWeekStartingFromMonday();
    getDetailWellnessForDate(DateTime.now());
    streakDates.value = dates.map((e) => StreakCalendarItemModel(date: e, isCompleted: false)).toList();
    getStreakData(streakDates.first.date, streakDates.last.date);
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
    selectedStreak.clear();
    todayProgress.value = 0;
    getDetailWellnessForDate(date);
  }

  void getTotalStreak() {
    final useCase = GetTotalStreak.instance();
    useCase(NoParams()).then((value) {
      value.fold((l) {
        numberOfStreaks.value = 0;
        Log.error(l);
      }, (r) {
        numberOfStreaks.value = r;
      });
    });
  }

  void getDetailWellnessForDate(DateTime dateTime) {
    final detailWellness = GetWellnessDetail.instance();
    detailWellness(dateTime).then((value) {
      value.fold((l) {
        Log.error(l);
      }, (r) {
        if (r.response?.displayData == null) {
          for (var item in StreakItemType.values) {
            selectedStreak.add(
              StreakItemModel(
                title: item,
                description: item.defaultDescription(),
                isCompleted: false,
              ),
            );
          }
          return;
        }
        for (var item in StreakItemType.values) {
          switch (item) {
            case StreakItemType.activity:
              selectedStreak.add(
                StreakItemModel(
                  title: item,
                  description: r.response?.details?.activity?.value == 0.0 ? "-" : "${r.response?.details?.activity?.value?.toInt() ?? '0'} ${localization.exercisePage?.steps ?? 'langkah'}",
                  isCompleted: r.response?.details?.activity?.value != 0,
                ),
              );
              if (r.response?.details?.activity?.value != 0) {
                todayProgress.value++;
              }
              break;
            case StreakItemType.hydration:
              selectedStreak.add(
                StreakItemModel(
                  title: item,
                  description: r.response?.details?.hydration?.value == 0.0 ? "-" : "${((r.response?.details?.hydration?.value?.toInt() ?? 0) / 1000)} ${localization.streakPage?.liters ?? 'liters'}",
                  isCompleted: r.response?.details?.hydration?.value != 0,
                ),
              );
              if (r.response?.details?.hydration?.value != 0) {
                todayProgress.value++;
              }
              break;
            case StreakItemType.mood:
              selectedStreak.add(
                StreakItemModel(
                  title: item,
                  description: r.response?.details?.mood?.value == 0.0 ? "-" : (MoodTypeExt.getMoodTypeByValue(r.response?.details?.mood?.value?.toInt() ?? 0)?.title() ?? ""),
                  isCompleted: r.response?.details?.mood?.value != 0,
                ),
              );
              if (r.response?.details?.mood?.value != 0) {
                todayProgress.value++;
              }
              break;
            case StreakItemType.nutrition:
              selectedStreak.add(
                StreakItemModel(
                  title: item,
                  description:
                      r.response?.details?.calories?.value == 0.0 ? "-" : "${r.response?.details?.calories?.value?.toInt() ?? '0'} ${r.response?.details?.calories?.displayUnit ?? 'calories'}",
                  isCompleted: r.response?.details?.calories?.value != 0,
                ),
              );
              if (r.response?.details?.calories?.value != 0) {
                todayProgress.value++;
              }
              break;
            case StreakItemType.sleep:
              selectedStreak.add(
                StreakItemModel(
                  title: item,
                  description: r.response?.details?.sleep?.value == 0.0 ? "-" : "${r.response?.details?.sleep?.value?.toStringAsFixed(1) ?? '0'} ${r.response?.details?.sleep?.displayUnit ?? 'hours'}",
                  isCompleted: r.response?.details?.sleep?.value != 0,
                ),
              );
              if (r.response?.details?.sleep?.value != 0) {
                todayProgress.value++;
              }
              break;
          }
        }
      });
    });
  }

  void getStreakData(DateTime dateFrom, DateTime dateTo) {
    final params = GetWellnessDataBatchParams(dateFrom: dateFrom, dateTo: dateTo);
    final useCase = GetWellnessDataBatch.instance();
    useCase(params).then((value) {
      value.fold((l) {
        Log.error(l);
      }, (r) {
        if (r.response?.displayData == null) return;
        for (int i = 0; i < streakDates.length; i++) {
          for (var item in r.response!.displayData!) {
            if (item.recordAt?.year == streakDates[i].date.year && item.recordAt?.month == streakDates[i].date.month && item.recordAt?.day == streakDates[i].date.day) {
              streakDates[i] = streakDates[i].copyWith(isCompleted: item.isStreak ?? false);
            }
          }
        }
      });
    });
  }

  List<DateTime> generateWeekStartingFromMonday() {
    List<DateTime> dates = [];
    DateTime now = DateTime.now();
    int daysSinceLastMonday = (now.weekday - DateTime.monday + 7) % 7;
    DateTime lastMonday = now.subtract(Duration(days: daysSinceLastMonday));

    for (int i = 0; i < 7; i++) {
      dates.add(lastMonday.add(Duration(days: i)));
    }

    return dates;
  }
}
