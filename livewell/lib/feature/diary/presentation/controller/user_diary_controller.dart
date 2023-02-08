import 'dart:developer';

import 'package:get/get.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:livewell/feature/food/domain/usecase/update_food_history.dart';
import 'package:livewell/feature/food/presentation/controller/food_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../core/log.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../food/domain/usecase/delete_meal_history.dart';
import '../../../food/presentation/pages/food_screen.dart';

class UserDiaryController extends GetxController {
  Rx<DiaryType> diaryType = DiaryType.food.obs;
  // create a varaible that contains list of datetime
  RxList<DateTime> dateList = <DateTime>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<int> selectedIndex = 0.obs;
  final ItemScrollController itemScrollController = ItemScrollController();

  GetUserMealHistory getUserMealHistory = GetUserMealHistory.instance();
  RxList<MealHistoryModel> allMealHistory = <MealHistoryModel>[].obs;

  RxList<MealHistoryModel> filteredMealHistory = <MealHistoryModel>[].obs;
  Rx<bool> isLoading = true.obs;

  @override
  void onInit() {
    populateDateList();
    doGetUserMealHistory();
    super.onInit();
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
  }

  void onDateTapped(int index) {
    selectedIndex.value = index;
    itemScrollController.scrollTo(
      index: selectedIndex.value,
      duration: const Duration(milliseconds: 300),
      alignment: 0.4,
    );
    generateMealToShow(dateList[selectedIndex.value]);
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
