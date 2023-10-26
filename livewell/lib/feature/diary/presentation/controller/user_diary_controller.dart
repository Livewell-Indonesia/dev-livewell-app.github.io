import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/dashboard/domain/usecase/post_mood.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:livewell/feature/exercise/data/model/activity_history_model.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_activity_histories.dart';
import 'package:livewell/feature/food/domain/usecase/update_food_history.dart';
import 'package:livewell/feature/food/presentation/controller/food_controller.dart';
import 'package:livewell/feature/mood/data/model/mood_model.dart';
import 'package:livewell/feature/mood/domain/usecase/get_mood_list.dart';
import 'package:livewell/feature/mood/domain/usecase/get_single_mood.dart';
import 'package:livewell/feature/mood/presentation/widget/mood_picker_widget.dart';
import 'package:livewell/feature/water/data/model/water_list_model.dart';
import 'package:livewell/feature/water/domain/usecase/get_water_data.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../core/log.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../food/domain/usecase/delete_meal_history.dart';
import '../../../food/presentation/pages/food_screen.dart';

class UserDiaryController extends BaseController {
  Rx<DiaryType> diaryType = DiaryType.food.obs;
  // create a varaible that contains list of datetime
  RxList<DateTime> dateList = <DateTime>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<int> selectedIndex = 0.obs;
  final ItemScrollController itemScrollController = ItemScrollController();

  GetUserMealHistory getUserMealHistory = GetUserMealHistory.instance();

  PostMood postMood = PostMood.instance();
  GetSingleMood getSingleMood = GetSingleMood.instance();

  RxList<MealHistoryModel> allMealHistory = <MealHistoryModel>[].obs;
  RxList<MealHistoryModel> filteredMealHistory = <MealHistoryModel>[].obs;

  RxList<ActivityHistoryModel> allActivityHistory =
      <ActivityHistoryModel>[].obs;
  RxList<Details> allExerciseHistory = <Details>[].obs;
  RxList<Details> filteredExerciseHistory = <Details>[].obs;
  RxList<Details> allStepsHistory = <Details>[].obs;
  RxList<Details> filteredStepsHistory = <Details>[].obs;

  RxList<WaterModel> allWaterHistory = <WaterModel>[].obs;
  RxList<WaterModel> filteredWaterHistory = <WaterModel>[].obs;

  RxList<ActivityHistoryModel> allSleepHistory = <ActivityHistoryModel>[].obs;
  RxList<ActivityHistoryModel> filteredSleepHistory =
      <ActivityHistoryModel>[].obs;
  RxList<Mood> allMoodHistory = <Mood>[].obs;
  RxList<Mood> filteredMoodHistory = <Mood>[].obs;

  Rx<bool> isLoading = true.obs;

  @override
  void onInit() {
    populateDateList();
    doGetUserMealHistory();
    doGetUserExerciseHistory();
    doGetUserWaterHistory();
    doGetUserSleepHistory();
    doGetMoodHistory();
    super.onInit();
  }

  void refreshList() {
    allMealHistory.clear();
    doGetUserMealHistory();
    doGetUserExerciseHistory();
    doGetUserWaterHistory();
    doGetUserSleepHistory();
    doGetMoodHistory();
  }

  @override
  void onResumed() {
    refreshList();
    super.onResumed();
  }

  // create a function date populate datelist with date up to 30 days
  void populateDateList() {
    for (int i = 0; i < 30; i++) {
      if (i == 0) {
        continue;
      }
      dateList.add(DateTime.now().subtract(Duration(days: i)));
    }

    for (int i = 0; i < 30; i++) {
      dateList.add(DateTime.now().add(Duration(days: i)));
    }
    dateList.sort((a, b) => a.compareTo(b));
    findInitialIndex();
  }

  void doGetUserMealHistory() async {
    isLoading.value = true;
    final result = await getUserMealHistory(UserMealHistoryParams(
        filter: Filter(startDate: dateList.last, endDate: dateList.first)));
    isLoading.value = false;
    result.fold((failure) {
      Log.error(failure.toString());
    }, (mealHistory) {
      Log.colorGreen(mealHistory.response?.length.toString());
      allMealHistory.value = mealHistory.response ?? [];
      generateMealToShow(dateList[selectedIndex.value]);
    });
  }

  void doGetUserExerciseHistory() async {
    GetActivityHistory getExerciseList = GetActivityHistory.instance();
    final result = await getExerciseList.call(GetActivityHistoryParam(
        type: ['ACTIVE_ENERGY_BURNED', 'STEPS'],
        dateFrom: DateTime(
            dateList[selectedIndex.value].year,
            dateList[selectedIndex.value].month,
            dateList[selectedIndex.value].day,
            0,
            0,
            0),
        dateTo: DateTime(
            dateList[selectedIndex.value].year,
            dateList[selectedIndex.value].month,
            dateList[selectedIndex.value].day,
            23,
            59,
            59)));
    result.fold((l) {}, (r) {
      inspect(r);
      filteredExerciseHistory.value = r
              .where((p0) => p0.type == 'ACTIVE_ENERGY_BURNED')
              .toList()
              .first
              .details ??
          [];
      filteredStepsHistory.value =
          r.where((p0) => p0.type == 'STEPS').toList().first.details ?? [];
      //generateExerciseToShow(dateList[selectedIndex.value]);
    });
  }

  void doGetUserWaterHistory() async {
    GetWaterData instance = GetWaterData.instance();
    final result = await instance.call(NoParams());
    result.fold((l) {
      Log.error(l);
    }, (r) {
      inspect(r);
      allWaterHistory.value = r.response ?? [];
      generateHydrationToShow(dateList[selectedIndex.value]);
    });
  }

  void doGetUserSleepHistory() async {
    GetActivityHistory getSleepList = GetActivityHistory.instance();
    final result = await getSleepList.call(GetActivityHistoryParam(
        type: ['SLEEP_IN_BED', 'LIGHT_SLEEP', 'DEEP_SLEEP'],
        dateFrom: DateTime(
            dateList[selectedIndex.value].year,
            dateList[selectedIndex.value].month,
            dateList[selectedIndex.value].day - 1,
            18,
            0,
            0),
        dateTo: DateTime(
            dateList[selectedIndex.value].year,
            dateList[selectedIndex.value].month,
            dateList[selectedIndex.value].day,
            18,
            0,
            0)));
    result.fold((l) {}, (r) {
      inspect(r);
      filteredSleepHistory.value = r;
      //ToShow(dateList[selectedIndex.value]);
    });
  }

  void doGetMoodHistory() async {
    GetMoodList getMoodList = GetMoodList.instance();
    final result = await getMoodList.call(dateList.length);
    result.fold((l) {}, (r) {
      allMoodHistory.value = r.response ?? [];
      generateMoodToShow(dateList[selectedIndex.value]);
    });
  }

  void findInitialIndex() {
    var index = dateList.indexWhere((element) =>
        element.day == selectedDate.value.day &&
        element.month == selectedDate.value.month &&
        element.year == selectedDate.value.year);
    selectedIndex.value = index;
    Future.delayed(const Duration(milliseconds: 300), () {
      Log.colorGreen('index $index');
      itemScrollController.jumpTo(
        index: index,
        alignment: 0.4,
      );
    });
  }

  void onDeleteTapped(MealTime mealTime, int index) async {
    DeleteMealHistory deleteMealHistory = DeleteMealHistory.instance();
    var lists = filteredMealHistory
        .where(
            (p0) => p0.mealType?.toUpperCase() == mealTime.name.toUpperCase())
        .toList();
    var deletedItem = lists[index];
    filteredMealHistory.remove(deletedItem);
    final result = await deleteMealHistory.call(deletedItem.id ?? 0);
    result.fold((l) => print(l), (r) => print(r));
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().onInit();
    }
    if (Get.isRegistered<FoodController>()) {
      Get.find<FoodController>().onInit();
    }
  }

  void onUpdateTapped(MealTime mealTime, int index, double servingSize) async {
    UpdateFoodHistory deleteMealHistory = UpdateFoodHistory.instance();
    var lists = filteredMealHistory
        .where(
            (p0) => p0.mealType?.toUpperCase() == mealTime.name.toUpperCase())
        .toList();
    var updatedItem = lists[index];
    updatedItem.servingSize = servingSize;
    if (servingSize == 0.0) {
      onDeleteTapped(mealTime, index);
    } else {
      final result = await deleteMealHistory.call(updatedItem);
      result.fold((l) => print(l), (r) {
        doGetUserMealHistory();
        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().onInit();
        }
        if (Get.isRegistered<FoodController>()) {
          Get.find<FoodController>().onInit();
        }
      });
    }
  }

  void onNextTapped() {
    if (selectedIndex.value == dateList.length - 1) {
      return;
    }
    selectedIndex.value += 1;
    itemScrollController.scrollTo(
      index: selectedIndex.value,
      duration: const Duration(milliseconds: 300),
      alignment: 0.4,
    );
    generateMealToShow(dateList[selectedIndex.value]);
    doGetUserExerciseHistory();
    generateHydrationToShow(dateList[selectedIndex.value]);
    doGetUserSleepHistory();
    generateMoodToShow(dateList[selectedIndex.value]);
  }

  void onDateTapped(int index) {
    selectedIndex.value = index;
    itemScrollController.scrollTo(
      index: selectedIndex.value,
      duration: const Duration(milliseconds: 300),
      alignment: 0.4,
    );
    generateMealToShow(dateList[selectedIndex.value]);
    doGetUserExerciseHistory();
    generateHydrationToShow(dateList[selectedIndex.value]);
    doGetUserSleepHistory();
    generateMoodToShow(dateList[selectedIndex.value]);
  }

  void onPreviousTapped() {
    if (selectedIndex.value == 0) {
      return;
    }
    selectedIndex.value -= 1;
    // itemScrollController.jumpTo(
    //   index: selectedIndex.value,
    //   alignment: 0.4,
    // );
    itemScrollController.scrollTo(
        index: selectedIndex.value,
        duration: const Duration(milliseconds: 300),
        alignment: 0.4);
    generateMealToShow(dateList[selectedIndex.value]);
    doGetUserSleepHistory();
    generateHydrationToShow(dateList[selectedIndex.value]);
    doGetUserExerciseHistory();
    generateMoodToShow(dateList[selectedIndex.value]);
  }

  Rx<bool> isDateSelected(int index) {
    return Rx<bool>(selectedDate.value.compareTo(dateList[index]) == 0);
  }

  void generateMealToShow(DateTime date) {
    if (allMealHistory.isEmpty) {
      return;
    }
    filteredMealHistory.value = allMealHistory.where(
      (p0) {
        var mealDate = DateTime.parse(p0.mealAt!);
        return mealDate.day == date.day &&
            mealDate.month == date.month &&
            mealDate.year == date.year;
      },
    ).toList();
    inspect(filteredMealHistory);
  }

  void generateExerciseToShow(DateTime date) {
    if (allActivityHistory.isEmpty) {
      return;
    }
    allExerciseHistory.value = allActivityHistory
            .where((p0) => p0.type == 'ACTIVE_ENERGY_BURNED')
            .toList()
            .first
            .details ??
        [];
    filteredExerciseHistory.value = allExerciseHistory.where((p0) {
      var mealDate = DateTime.parse(p0.dateFrom ?? "");
      return date.day == mealDate.day &&
          date.month == mealDate.month &&
          date.year == mealDate.year;
    }).toList();
    inspect(filteredExerciseHistory);
    allStepsHistory.value = allActivityHistory
            .where((p0) => p0.type == 'STEPS')
            .toList()
            .first
            .details ??
        [];
    filteredStepsHistory.value = allStepsHistory.where((p0) {
      var mealDate = DateTime.parse(p0.dateFrom ?? "");
      return mealDate.day == date.day &&
          mealDate.month == date.month &&
          mealDate.year == date.year;
    }).toList();
  }

  void generateHydrationToShow(DateTime date) {
    if (allWaterHistory.isEmpty) {
      return;
    }
    filteredWaterHistory.value = allWaterHistory.where(
      (p0) {
        var mealDate = DateTime.parse(p0.recordAt ?? "");
        return mealDate.day == date.day &&
            mealDate.month == date.month &&
            mealDate.year == date.year;
      },
    ).toList();
    inspect(filteredWaterHistory);
  }

  void generateSleepToShow(DateTime date) {
    if (allSleepHistory.isEmpty) {
      return;
    }
    filteredSleepHistory.value = allSleepHistory.where(
      (p0) {
        var mealDate = DateTime.parse(p0.dateFrom ?? "");
        return mealDate.day == date.day &&
            mealDate.month == date.month &&
            mealDate.year == date.year;
      },
    ).toList();
  }

  Rx<String> calculateSleepHour(DateTime date) {
    if (filteredSleepHistory.isEmpty) {
      return Rx<String>('');
    }
    var lightSleepValue = filteredSleepHistory
        .where((element) => element.type == 'LIGHT_SLEEP')
        .toList();
    var deepSleepValue = filteredSleepHistory
        .where((element) => element.type == 'DEEP_SLEEP')
        .toList();
    var sleepInBedValue = filteredSleepHistory
        .where((element) => element.type == 'SLEEP_IN_BED')
        .toList();

    var filteredSleepInBedValue = sleepInBedValue.first.details ?? [];
    inspect(filteredSleepInBedValue);
    if (isContainManualInput(filteredSleepHistory)) {
      return Rx<String>(
          calculateManualSleepHour(sleepInBedValue).toStringAsFixed(1));
    } else if (lightSleepValue.first.details != null &&
        deepSleepValue.first.details != null) {
      return Rx<String>(
          "${(calculateDeepSleepHour(deepSleepValue, lightSleepValue) / 60).toStringAsFixed(1)}hours");
    } else if (sleepInBedValue.isNotEmpty &&
        filteredSleepInBedValue.isNotEmpty) {
      if (sleepInBedValue.first.totalValue != 0 &&
          filteredSleepInBedValue.first.value != 0) {
        return Rx<String>(
            '${calculateSleepInbedHour(sleepInBedValue).toStringAsFixed(1)} hours');
      }
    }

    return Rx<String>('');
  }

  bool isContainManualInput(List<ActivityHistoryModel> value) {
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

  double calculateManualSleepHour(List<ActivityHistoryModel> value) {
    // var startSleepValue = DateTime.parse(value.first.details?.first.dateFrom ??
    //     DateTime.now().toIso8601String());
    // var endSleepValue = DateTime.parse(
    //     value.first.details?.first.dateTo ?? DateTime.now().toIso8601String());
    // var duration = endSleepValue.difference(startSleepValue);
    // return duration.inMinutes ~/ 60;

    return value.first.details!.first.value! / 60;
  }

  double calculateSleepInbedHour(List<ActivityHistoryModel> value) {
    num totalValue = value.first.totalValue ?? 0;
    return totalValue.toInt() / 60;
  }

  int calculateDeepSleepHour(List<ActivityHistoryModel> deepsleepValue,
      List<ActivityHistoryModel> lightSleepValue) {
    num totalValue = deepsleepValue.first.totalValue ?? 0;
    num totalValue2 = lightSleepValue.first.totalValue ?? 0;
    return totalValue.toInt() + totalValue2.toInt();
  }

  void generateMoodToShow(DateTime date) {
    if (allMoodHistory.isEmpty) {
      return;
    }
    filteredMoodHistory.value = allMoodHistory.where(
      (p0) {
        var mealDate = DateTime.parse(p0.recordAt ?? "");
        return mealDate.day == date.day &&
            mealDate.month == date.month &&
            mealDate.year == date.year;
      },
    ).toList();
  }

  void onMoodSelected(MoodType type) async {
    EasyLoading.show();
    final result = await postMood.call(PostMoodParams(
        value: type.value(), dateTime: dateList[selectedIndex.value]));
    EasyLoading.dismiss();
    result.fold((l) {
      Log.error(l);
    }, (r) {
      Log.colorGreen(r);
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().getSingleMoodData();
      }
      doGetMoodHistory();
    });
  }

  MoodType? getMoodTypeByValue(int value) {
    switch (value) {
      case 1:
        return MoodType.awful;
      case 2:
        return MoodType.bad;
      case 3:
        return MoodType.meh;
      case 4:
        return MoodType.good;
      case 5:
        return MoodType.great;
      default:
        return null;
    }
  }

  Rx<num> getTotalCal(List<MealHistoryModel> mealHistory) {
    num totalCal = 0;
    for (var element in mealHistory) {
      totalCal += element.caloriesInG!;
    }
    if (totalCal > 0) {
      totalCal = (totalCal * 7.7162).round();
    }
    return Rx<num>(totalCal);
  }
}

enum DiaryType { food, exercise, sleep, hidration }

extension DiaryTypeExtension on DiaryType {
  String get name {
    switch (this) {
      case DiaryType.food:
        return "Food";
      case DiaryType.exercise:
        return "Exercise";
      case DiaryType.sleep:
        return "Sleep";
      case DiaryType.hidration:
        return "Hidration";
    }
  }
}
