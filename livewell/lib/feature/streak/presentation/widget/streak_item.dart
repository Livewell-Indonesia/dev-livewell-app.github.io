import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/get_meal_type_by_current_time.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/nutrico/presentation/widget/nutri_score_plus_bottom_sheet.dart';
import 'package:livewell/feature/streak/data/model/wellness_detail_model.dart';
import 'package:livewell/feature/water/presentation/pages/water_custom_input_page.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';

enum StreakItemType {
  hydration,
  sleep,
  mood,
  nutrition,
  activity,
}

extension StreakItemTypeExt on StreakItemType {
  String get title {
    switch (this) {
      case StreakItemType.hydration:
        return 'Hydration';
      case StreakItemType.sleep:
        return 'Sleep';
      case StreakItemType.mood:
        return 'Mood';
      case StreakItemType.nutrition:
        return 'Nutrition';
      case StreakItemType.activity:
        return 'Activity';
    }
  }

  String get wellnessTitle {
    switch (this) {
      case StreakItemType.hydration:
        return 'Water';
      case StreakItemType.sleep:
        return 'Sleep';
      case StreakItemType.mood:
        return 'Mood';
      case StreakItemType.nutrition:
        return 'Nutrition';
      case StreakItemType.activity:
        return 'Exercise';
    }
  }

  String description(Details details) {
    switch (this) {
      case StreakItemType.hydration:
        return 'You drank ${details.hydration?.displayValue ?? '0'} ${details.hydration?.displayUnit ?? 'ml'} of water';
      case StreakItemType.sleep:
        return 'You slept for ${details.sleep?.displayValue ?? '0'} ${details.sleep?.displayUnit ?? 'hours'}';
      case StreakItemType.mood:
        return 'You are feeling ${details.mood?.displayValue ?? '0'}';
      case StreakItemType.nutrition:
        return 'You consumed ${details.calories?.displayValue ?? '0'} ${details.calories?.displayUnit ?? 'calories'}';
      case StreakItemType.activity:
        return 'You burned ${details.activity?.displayValue ?? '0'} ${details.activity?.displayUnit ?? 'calories'}';
    }
  }

  String defaultDescription() {
    switch (this) {
      case StreakItemType.hydration:
        return '0L';
      case StreakItemType.sleep:
        return '0 hrs';
      case StreakItemType.mood:
        return 'meh';
      case StreakItemType.nutrition:
        return '0 cal';
      case StreakItemType.activity:
        return '0 cal';
    }
  }

  void navigate() {
    switch (this) {
      case StreakItemType.hydration:
        AppNavigator.push(routeName: AppPages.waterConsumedPage, arguments: {"waterInputType": WaterInputType.increase});
        break;
      case StreakItemType.sleep:
        AppNavigator.push(routeName: AppPages.sleepScreen);
        break;
      case StreakItemType.mood:
        AppNavigator.push(routeName: AppPages.moodDetailScreen);
        break;
      case StreakItemType.nutrition:
        showModalBottomSheet(
            context: Get.context!,
            shape: shapeBorder(),
            builder: (context) {
              return Obx(() {
                return NutriScorePlusBottomSheet(
                  isAlreadyLimit: Get.find<DashboardController>().featureLimit.value?.isNutricoAlreadyLimit() ?? true,
                  maxRequest: Get.find<DashboardController>().featureLimit.value?.getNutricoCurrentUsage() ?? 30,
                  onSelected: (p0) {
                    Get.back();
                    switch (p0) {
                      case SelectedNutriscorePlusMethod.camera:
                        // AppNavigator.push(routeName: AppPages.camera);
                        break;
                      case SelectedNutriscorePlusMethod.gallery:
                        //AppNavigator.push(routeName: AppPages.gallery);
                        break;
                      case SelectedNutriscorePlusMethod.desc:
                        AppNavigator.push(routeName: AppPages.nutriCoScreen, arguments: {
                          'type': getMealTypeByCurrentTime().name,
                          'date': DateTime.now(),
                        });
                        break;
                    }
                  },
                  onImageSelected: (file) {
                    Get.back();
                    AppNavigator.push(routeName: AppPages.loadingNutricoPlus, arguments: file);
                  },
                );
              });
            });
        break;
      case StreakItemType.activity:
        AppNavigator.push(routeName: AppPages.exerciseScreen);
        break;
    }
  }
}

class StreakItemModel {
  StreakItemType title;
  String description;
  bool isCompleted;

  StreakItemModel({
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}

class StreakItem extends StatelessWidget {
  final StreakItemModel model;

  const StreakItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.textBg,
        border: Border.all(
          color: Theme.of(context).colorScheme.borderColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          model.isCompleted ? const FinishedItem() : const UnfinishedItem(),
          12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title.title,
                style: TextStyle(color: Theme.of(context).colorScheme.textLoEm, fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
              Text(
                model.description,
                style: TextStyle(color: Theme.of(context).colorScheme.disabled, fontWeight: FontWeight.w400, fontSize: 12.sp),
              ),
            ],
          ),
          12.horizontalSpace,
          const Spacer(),
          const Icon(
            Icons.chevron_right_sharp,
            size: 24,
          )
        ],
      ),
    );
  }
}

class FinishedItem extends StatelessWidget {
  const FinishedItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryGreen,
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
      ),
      child: const Icon(
        Icons.check,
        size: 24,
      ),
    );
  }
}

class UnfinishedItem extends StatelessWidget {
  const UnfinishedItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 24,
      height: 24,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.disabled.withOpacity(0.35),
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
      ),
      child: const Icon(
        Icons.maximize,
        size: 24,
      ),
    );
  }
}
