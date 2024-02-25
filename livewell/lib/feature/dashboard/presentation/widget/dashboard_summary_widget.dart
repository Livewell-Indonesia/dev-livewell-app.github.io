import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livewell/feature/mood/presentation/widget/mood_picker_widget.dart';
import 'package:livewell/feature/nutriscore/presentation/controller/nutriscore_controller.dart';
import 'package:livewell/routes/app_navigator.dart';

class DashboardSummaryWidget extends StatelessWidget {
  final List<DashboardSummaryModel> model;
  const DashboardSummaryWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.w, crossAxisSpacing: 9.w, mainAxisSpacing: 9.h),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              model[index].item.navigate();
            },
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFF1F1F1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            model[index].item.assets(),
                            width: 16.w,
                            height: 16.h,
                          ),
                          8.horizontalSpace,
                          Text(
                            model[index].item.title(),
                            style: TextStyle(color: const Color(0xFF505050), fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      7.verticalSpace,
                      model[index].moodType == null
                          ? RichText(
                              text: TextSpan(text: model[index].currentValue, style: TextStyle(color: const Color(0xFF505050), fontSize: 16.sp, fontWeight: FontWeight.w600), children: [
                                TextSpan(text: "/${model[index].targetValue} ${model[index].unit}", style: TextStyle(color: const Color(0xFF505050), fontSize: 12.sp, fontWeight: FontWeight.w400))
                              ]),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset((model[index].moodType!.assets()), width: 20.w, height: 20.h),
                                8.horizontalSpace,
                                Text(
                                  model[index].moodType!.title(),
                                  style: TextStyle(color: const Color(0xFF505050), fontSize: 14.sp, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                Container(
                  width: 14.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                    color: model[index].moodType != null ? model[index].moodType!.mainColor() : model[index].status.color(),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: model.length,
      ),
    );
  }
}

List<DashboardSummaryModel> generateDefaultModel() {
  return [
    DashboardSummaryModel(item: DashboardSummaryItem.calories, currentValue: '0', targetValue: '0', unit: 'kcal', status: DashboardSummaryStatus.eightyPlus),
    DashboardSummaryModel(item: DashboardSummaryItem.exercise, currentValue: '0', targetValue: '0', unit: 'kCal', status: DashboardSummaryStatus.eightyPlus),
    DashboardSummaryModel(item: DashboardSummaryItem.protein, currentValue: '0', targetValue: '0', unit: 'g', status: DashboardSummaryStatus.eightyPlus),
    DashboardSummaryModel(item: DashboardSummaryItem.carbs, currentValue: '0', targetValue: '0', unit: 'g', status: DashboardSummaryStatus.eightyPlus),
    DashboardSummaryModel(item: DashboardSummaryItem.sleep, currentValue: '0', targetValue: '0', unit: 'hours', status: DashboardSummaryStatus.eightyPlus),
    DashboardSummaryModel(item: DashboardSummaryItem.fat, currentValue: '0', targetValue: '0', unit: 'g', status: DashboardSummaryStatus.eightyPlus),
    DashboardSummaryModel(item: DashboardSummaryItem.water, currentValue: '0', targetValue: '0', unit: 'liters', status: DashboardSummaryStatus.eightyPlus),
    DashboardSummaryModel(item: DashboardSummaryItem.mood, currentValue: '0', targetValue: '0', unit: '', moodType: MoodType.great, status: DashboardSummaryStatus.eightyPlus),
  ];
}

class DashboardSummaryModel {
  final DashboardSummaryItem item;
  final String currentValue;
  final String targetValue;
  final String unit;
  final MoodType? moodType;
  final DashboardSummaryStatus status;

  DashboardSummaryModel({required this.item, required this.currentValue, required this.targetValue, required this.unit, this.moodType, required this.status});

  static DashboardSummaryStatus statusFromValue(double value, bool isFatOrCarbs) {
    if (value >= 0 && value < 0.4) {
      return DashboardSummaryStatus.zeroToFourty;
    } else if (value >= 0.4 && value < 0.8) {
      return DashboardSummaryStatus.fourtyToEighty;
    } else if (value >= 0.8 && !isFatOrCarbs) {
      return DashboardSummaryStatus.eightyPlus;
    } else if (value >= 0.8 && value < 1.1 && isFatOrCarbs) {
      return DashboardSummaryStatus.eightyToHundredTen;
    } else if (value >= 1.1 && value < 1.25 && isFatOrCarbs) {
      return DashboardSummaryStatus.hundredTenToHundredTwentyFive;
    } else {
      return DashboardSummaryStatus.hundredTwentyFivePlus;
    }
  }
}

enum DashboardSummaryItem {
  calories,
  exercise,
  protein,

  carbs,
  sleep,
  fat,
  water,
  mood
}

enum DashboardSummaryStatus { zeroToFourty, fourtyToEighty, eightyPlus, eightyToHundredTen, hundredTenToHundredTwentyFive, hundredTwentyFivePlus }

extension DashboardSummaryExt on DashboardSummaryStatus {
  Color color() {
    switch (this) {
      case DashboardSummaryStatus.zeroToFourty:
        return const Color(0xFFFA6F6F);
      case DashboardSummaryStatus.fourtyToEighty:
        return const Color(0xFFDDF235);
      case DashboardSummaryStatus.eightyPlus:
        return const Color(0xFF34EAB2);
      case DashboardSummaryStatus.eightyToHundredTen:
        return const Color(0xFF34EAB2);
      case DashboardSummaryStatus.hundredTenToHundredTwentyFive:
        return const Color(0xFFDDF235);
      case DashboardSummaryStatus.hundredTwentyFivePlus:
        return const Color(0xFFFA6F6F);
    }
  }
}

extension DashboardSummaryItemExt on DashboardSummaryItem {
  String title() {
    switch (this) {
      case DashboardSummaryItem.calories:
        return 'Calories';
      case DashboardSummaryItem.exercise:
        return 'Exercise';
      case DashboardSummaryItem.protein:
        return 'Protein';
      case DashboardSummaryItem.mood:
        return 'Mood';
      case DashboardSummaryItem.carbs:
        return 'Carbs';
      case DashboardSummaryItem.sleep:
        return 'Sleep';
      case DashboardSummaryItem.fat:
        return 'Fat';
      case DashboardSummaryItem.water:
        return 'Water';
    }
  }

  String assets() {
    switch (this) {
      case DashboardSummaryItem.calories:
        return 'assets/icons/summary_calories.svg';
      case DashboardSummaryItem.exercise:
        return 'assets/icons/summary_exercise.svg';
      case DashboardSummaryItem.protein:
        return 'assets/icons/summary_protein.svg';
      case DashboardSummaryItem.mood:
        return 'assets/icons/summary_mood.svg';
      case DashboardSummaryItem.carbs:
        return 'assets/icons/summary_carbs.svg';
      case DashboardSummaryItem.sleep:
        return 'assets/icons/summary_sleep.svg';
      case DashboardSummaryItem.fat:
        return 'assets/icons/summary_fat.svg';
      case DashboardSummaryItem.water:
        return 'assets/icons/sumary_water.svg';
    }
  }

  void navigate() {
    switch (this) {
      case DashboardSummaryItem.calories:
        // AppNavigator.push(routeName: AppPages.nutritionScreen);
        AppNavigator.push(routeName: AppPages.updateWeight, arguments: true);
        break;
      case DashboardSummaryItem.exercise:
        AppNavigator.push(routeName: AppPages.exerciseScreen);
        break;
      case DashboardSummaryItem.protein:
        AppNavigator.push(routeName: AppPages.nutriScore, arguments: {
          'type': NutrientType.protein,
        });
        break;
      case DashboardSummaryItem.mood:
        AppNavigator.push(routeName: AppPages.moodDetailScreen);
        break;
      case DashboardSummaryItem.carbs:
        AppNavigator.push(routeName: AppPages.nutriScore, arguments: {
          'type': NutrientType.carb,
        });
        break;
      case DashboardSummaryItem.sleep:
        AppNavigator.push(routeName: AppPages.sleepScreen);
        break;
      case DashboardSummaryItem.fat:
        AppNavigator.push(routeName: AppPages.nutriScore, arguments: {
          'type': NutrientType.fat,
        });
        break;
      case DashboardSummaryItem.water:
        AppNavigator.push(routeName: AppPages.waterScreen);
        break;
    }
  }
}
