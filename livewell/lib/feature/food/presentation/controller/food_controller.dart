import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:livewell/core/equation/formula.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/domain/usecase/delete_meal_history.dart';

import '../../../diary/domain/entity/user_meal_history_model.dart';
import '../../domain/usecase/update_food_history.dart';
import '../pages/food_screen.dart';
import 'package:livewell/core/base/base_controller.dart';

class FoodController extends BaseController {
  var firstValue = 0.0.obs;
  var secondValue = 0.0.obs;
  var thirdValue = 0.0.obs;
  var dashboardData = Get.find<DashboardController>().dashboard;

  var macroNutValue = 0.obs;
  var microNutValue = 0.obs;
  var totalCalValue = 0.obs;

  GetUserMealHistory getUserMealHistory = GetUserMealHistory.instance();
  RxList<MealHistoryModel> mealHistory = <MealHistoryModel>[].obs;
  Rx<bool> isLoadingHistory = false.obs;

  @override
  void onInit() {
    fetchUserMealHistory();
    Get.find<DashboardController>().getNutriscoreData();
    super.onInit();
  }

  void fetchUserMealHistory() async {
    isLoadingHistory.value = true;
    var currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
    final result = await getUserMealHistory(UserMealHistoryParams(filter: Filter(endDate: currentDate, startDate: currentDate.add(const Duration(seconds: 86399)))));
    isLoadingHistory.value = false;
    result.fold((l) {}, (r) {
      mealHistory.value = r.response ?? [];
    });
  }

  @override
  void onReady() {
    firstValue.value = 50.0;
    secondValue.value = 40.0;
    thirdValue.value = 30.0;
  }

  @override
  void dispose() {
    firstValue.value = 0;
    secondValue.value = 0;
    thirdValue.value = 0;
    super.dispose();
  }

  Rx<int> percentageOfDailyGoals() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.caloriesTaken == null) {
        return 0.obs;
      }
      if (dashboardData.value.dashboard!.target == null) {
        return 0.obs;
      }
      var result = ((dashboardData.value.dashboard!.caloriesTaken! / dashboardData.value.dashboard!.target!) * 100);
      if (result.isNaN || result.isInfinite) {
        return 0.obs;
      }
      return result > 100 ? 100.obs : result.toInt().obs;
    } else {
      return 0.obs;
    }
  }

  Rx<int> getConsumedProtein() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.totalProteinInG == null) {
        return 0.obs;
      } else {
        return dashboardData.value.dashboard!.totalProteinInG!.round().obs;
      }
    } else {
      return 0.obs;
    }
  }

  Rx<int> getConsumedCarbs() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.totalCarbsInG == null) {
        return 0.obs;
      } else {
        return dashboardData.value.dashboard!.totalCarbsInG!.round().obs;
      }
    } else {
      return 0.obs;
    }
  }

  Rx<int> getConsumedFat() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.totalFatsInG == null) {
        return 0.obs;
      } else {
        return dashboardData.value.dashboard!.totalFatsInG!.round().obs;
      }
    } else {
      return 0.obs;
    }
  }

  Rx<int> getTotalCal() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.caloriesTaken == null) {
        return 0.obs;
      }
      return dashboardData.value.dashboard!.caloriesTaken!.round().obs;
    } else {
      return 0.obs;
    }
  }

  Rx<num> getTotalMacroNut() {
    if (dashboardData.value.dashboard != null) {
      var carbs = dashboardData.value.dashboard!.totalCarbsInG ?? 0;
      var protein = dashboardData.value.dashboard!.totalProteinInG ?? 0;
      var fat = dashboardData.value.dashboard!.totalFatsInG ?? 0;
      return (carbs + protein + fat).obs;
    } else {
      return 0.obs;
    }
  }

  Rx<int> getTargetProtein() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.target == null) {
        return 0.obs;
      }
      return Formula.targetProteinConsumed(dashboardData.value.dashboard!.target! + Get.find<DashboardController>().totalExercise.value).round().obs;
    } else {
      return 0.obs;
    }
  }

  Rx<int> getTargetCarbs() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.target == null) {
        return 0.obs;
      }
      return Formula.targetCarbohydrateConsumed(dashboardData.value.dashboard!.target! + Get.find<DashboardController>().totalExercise.value).round().obs;
    } else {
      return 0.obs;
    }
  }

  Rx<int> getTargetFat() {
    if (dashboardData.value.dashboard != null) {
      if (dashboardData.value.dashboard!.target == null) {
        return 0.obs;
      }
      return Formula.targetFatConsumed(dashboardData.value.dashboard!.target! + Get.find<DashboardController>().totalExercise.value).round().obs;
    } else {
      return 0.obs;
    }
  }

  Rx<double> getPercentageProtein() {
    if (getTargetProtein().value == 0) {
      return 0.0.obs;
    }

    if (getConsumedProtein().value == 0) {
      return 0.0.obs;
    }

    var result = ((getConsumedProtein().value / getTargetProtein().value) * 100);
    return result > 100.0 ? 100.0.obs : result.obs;
  }

  Rx<double> getPercentageCarbs() {
    if (getTargetCarbs().value == 0) {
      return 0.0.obs;
    }

    if (getConsumedCarbs().value == 0) {
      return 0.0.obs;
    }

    var result = ((getConsumedCarbs().value / getTargetCarbs().value) * 100);
    return result > 100.0 ? 100.0.obs : result.obs;
  }

  Rx<double> getPercentageFat() {
    if (getTargetFat().value == 0) {
      return 0.0.obs;
    }

    if (getConsumedFat().value == 0) {
      return 0.0.obs;
    }

    var result = ((getConsumedFat().value / getTargetFat().value) * 100);
    return result > 100.0 ? 100.0.obs : result.obs;
  }

  Rx<double> getPercentMacroNut() {
    if (dashboardData.value.dashboard != null) {
      num carbs = Formula.carbohydratePercentage(dashboardData.value.dashboard!.totalCarbsInG ?? 0, dashboardData.value.dashboard?.target ?? 0);
      num protein = Formula.proteinPercentage(dashboardData.value.dashboard!.totalProteinInG ?? 0, dashboardData.value.dashboard?.target ?? 0);
      num fat = Formula.fatPercentage(dashboardData.value.dashboard!.totalFatsInG ?? 0, dashboardData.value.dashboard?.target ?? 0);
      var average = (carbs + protein + fat) / 3;
      return average >= 1 ? 1.0.obs : average.obs;
    } else {
      return 0.0.obs;
    }
  }

  Rx<double> getPercentMicroNut() {
    if (dashboardData.value.dashboard != null) {
      double? totalVitA = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminAInMcg ?? 0));
      double? totalVitC = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminCInMg ?? 0));

      double? totalVitD = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminDInMcg ?? 0));
      double? totalVitE = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminEInMg ?? 0));
      double? totalVitK = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminKInMcg ?? 0));
      double? totalVitB1 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB1InMg ?? 0));
      double? totalVitB2 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB2InMg ?? 0));
      double? totalVitB3 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB3InMg ?? 0));
      double? totalVitB5 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB5InMg ?? 0));
      double? totalVitB6 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB6InMg ?? 0));
      double? totalVitB7 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB7InMcg ?? 0));
      double? totalVitB9 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB9InMcg ?? 0));

      double? totalVitB12 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB12InMcg ?? 0));
      double? totalCalcium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.calciumInMg ?? 0));
      double? totalPhosphorus = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.phosphorusInMg ?? 0));
      double? totalMagnesium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.magnesiumInMg ?? 0));
      double? totalSodium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.sodiumInMg ?? 0));
      double? totalPotassium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.potassiumInMg ?? 0));
      double? totalChloride = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.chlorideInMg ?? 0));
      double? totalIron = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.ironInMg ?? 0));
      double? totalIodine = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.iodineInMcg ?? 0));
      double? totalZinc = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.zincInMg ?? 0));
      double? totalSelenium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.seleniumInMcg ?? 0));
      double? totalFluoride = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.fluorideInMg ?? 0));
      double? totalChromium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.chromiumInMcg ?? 0));
      double? totalMolybdenum = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.molybdenumInMcg ?? 0));

      final averageEssentialVitamins = Formula.averageEssentialVitamins(
        Formula.vitAPercentage(totalVitA ?? 0),
        Formula.vitCPercentage(totalVitC ?? 0),
        Formula.vitDPercentage(totalVitD ?? 0),
        Formula.vitEPercentage(totalVitE ?? 0),
        Formula.vitKPercentage(totalVitK ?? 0),
        Formula.vitB1Percentage(totalVitB1 ?? 0),
        Formula.vitB2Percentage(totalVitB2 ?? 0),
        Formula.vitB3Percentage(totalVitB3 ?? 0),
        Formula.vitB5Percentage(totalVitB5 ?? 0),
        Formula.vitB6Percentage(totalVitB6 ?? 0),
        Formula.vitB7Percentage(totalVitB7 ?? 0),
        Formula.vitB9Percentage(totalVitB9 ?? 0),
        Formula.vitB12Percentage(totalVitB12 ?? 0),
      );

      final averageMajorMinerals = Formula.averageMajorMineral(
        Formula.calciumPercentage(totalCalcium ?? 0),
        Formula.magnesiumPercentage(totalMagnesium ?? 0),
        Formula.phosphorusPercentage(totalPhosphorus ?? 0),
        Formula.chloridePercentage(totalChloride ?? 0),
        Formula.potassiumPercentage(totalPotassium ?? 0),
        Formula.sodiumPercentage(totalSodium ?? 0),
      );
      final averageMicroMinerals = Formula.averageMinorMineral(
        Formula.ironPercentage(totalIron ?? 0),
        Formula.iodinePercentage(totalIodine ?? 0),
        Formula.zincPercentage(totalZinc ?? 0),
        Formula.seleniumPercentage(totalSelenium ?? 0),
        Formula.fluoridePercentage(totalFluoride ?? 0),
        Formula.chromiumPercentage(totalChromium ?? 0),
        Formula.molybdenumPercentage(totalMolybdenum ?? 0),
      );

      var averageMicroPercent = (averageEssentialVitamins + averageMajorMinerals + averageMicroMinerals) / 3;
      return averageMicroPercent > 1.0 ? 1.0.obs : averageMicroPercent.obs;
    } else {
      return 0.0.obs;
    }
  }

  Rx<int> getTotalMicroNut() {
    if (dashboardData.value.dashboard != null) {
      double? totalVitA = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminAInMcg ?? 0));
      double? totalVitC = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminCInMg ?? 0));

      double? totalVitD = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminDInMcg ?? 0));
      double? totalVitE = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminEInMg ?? 0));
      double? totalVitK = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminKInMcg ?? 0));
      double? totalVitB1 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB1InMg ?? 0));
      double? totalVitB2 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB2InMg ?? 0));
      double? totalVitB3 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB3InMg ?? 0));
      double? totalVitB5 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB5InMg ?? 0));
      double? totalVitB6 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB6InMg ?? 0));
      double? totalVitB7 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB7InMcg ?? 0));
      double? totalVitB9 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB9InMcg ?? 0));

      double? totalVitB12 = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.vitaminB12InMcg ?? 0));
      double? totalCalcium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.calciumInMg ?? 0));
      double? totalPhosphorus = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.phosphorusInMg ?? 0));
      double? totalMagnesium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.magnesiumInMg ?? 0));
      double? totalSodium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.sodiumInMg ?? 0));
      double? totalPotassium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.potassiumInMg ?? 0));
      double? totalChloride = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.chlorideInMg ?? 0));
      double? totalIron = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.ironInMg ?? 0));
      double? totalIodine = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.iodineInMcg ?? 0));
      double? totalZinc = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.zincInMg ?? 0));
      double? totalSelenium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.seleniumInMcg ?? 0));
      double? totalFluoride = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.fluorideInMg ?? 0));
      double? totalChromium = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.chromiumInMcg ?? 0));
      double? totalMolybdenum = dashboardData.value.details?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.molybdenumInMcg ?? 0));

      var totalMicroNuts = (totalVitA ?? 0.0) +
          (totalVitC ?? 0.0) +
          (totalVitD ?? 0.0) +
          (totalVitE ?? 0.0) +
          (totalVitK ?? 0.0) +
          (totalVitB1 ?? 0.0) +
          (totalVitB2 ?? 0.0) +
          (totalVitB3 ?? 0.0) +
          (totalVitB5 ?? 0.0) +
          (totalVitB6 ?? 0.0) +
          (totalVitB7 ?? 0.0) +
          (totalVitB9 ?? 0.0) +
          (totalVitB12 ?? 0.0) +
          (totalCalcium ?? 0.0) +
          (totalPhosphorus ?? 0.0) +
          (totalMagnesium ?? 0.0) +
          (totalSodium ?? 0.0) +
          (totalPotassium ?? 0.0) +
          (totalChloride ?? 0.0) +
          (totalIron ?? 0.0) +
          (totalIodine ?? 0.0) +
          (totalZinc ?? 0.0) +
          (totalSelenium ?? 0.0) +
          (totalFluoride ?? 0.0) +
          (totalChromium ?? 0.0) +
          (totalMolybdenum ?? 0.0);
      return totalMicroNuts.toInt().obs;
    } else {
      return 0.obs;
    }
  }

  void onDeleteHistory(MealTime mealTime, int index) async {
    DeleteMealHistory deleteMealHistory = DeleteMealHistory.instance();
    var lists = mealHistory.where((p0) => p0.mealType?.toUpperCase() == mealTime.name.toUpperCase()).toList();
    var deletedItem = lists[index];
    mealHistory.remove(deletedItem);
    EasyLoading.show();
    final result = await deleteMealHistory.call(deletedItem.id ?? 0);
    result.fold((l) => Log.error(l), (r) => Log.error(r));
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().onInit();
    }
    EasyLoading.dismiss();
  }

  void onUpdateTapped(MealTime mealTime, int index, double servingSize) async {
    UpdateFoodHistory deleteMealHistory = UpdateFoodHistory.instance();
    var lists = mealHistory.where((p0) => p0.mealType?.toUpperCase() == mealTime.name.toUpperCase()).toList();
    var updatedItem = lists[index].toOneServings();
    updatedItem.servingSize = servingSize;
    if (servingSize == 0.0) {
      onDeleteHistory(mealTime, index);
    } else {
      EasyLoading.show();
      final result = await deleteMealHistory.call(updatedItem);
      result.fold((l) => Log.error(l), (r) {
        fetchUserMealHistory();
        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().onInit();
        }
        if (Get.isRegistered<FoodController>()) {
          Get.find<FoodController>().onInit();
        }
      });
      EasyLoading.dismiss();
    }
  }
}
