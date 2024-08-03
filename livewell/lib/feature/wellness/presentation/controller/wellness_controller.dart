import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/streak/domain/usecase/get_wellness_recommendation.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';
import 'package:livewell/feature/wellness/presentation/pages/wellness_score_screen.dart';

class WellnessController extends BaseController {
  GetWellnessRecommendation getWellnessRecommendation = GetWellnessRecommendation.instance();
  Rx<String> recommendation = ''.obs;

  Rx<bool> isLoadingRecommendation = false.obs;

  @override
  void onInit() async {
    isLoadingRecommendation.value = true;
    if (Get.find<DashboardController>().wellnessScore.value != 0) {
      final result = await getWellnessRecommendation(NoParams());
      isLoadingRecommendation.value = false;
      result.fold((l) => null, (r) {
        recommendation.value = r;
        showModalBottomSheet(
            isScrollControlled: true,
            context: Get.context!,
            shape: shapeBorder(),
            builder: (context) {
              return WellnessScoreRecommendationBottomSheet(controller: this);
            });
      });
    }
    super.onInit();
  }

  WellnessProfileType getWellnessProfileByValue(int value) {
    if (value < 60) {
      return WellnessProfileType.needImprovement;
    } else if (value <= 80) {
      return WellnessProfileType.balanced;
    } else {
      return WellnessProfileType.excellent;
    }
  }
}

enum WellnessProfileType {
  needImprovement,
  balanced,
  excellent,
}

extension WellnessProfileTypeExtension on WellnessProfileType {
  String get title {
    switch (this) {
      case WellnessProfileType.needImprovement:
        return 'Need Improvement';
      case WellnessProfileType.balanced:
        return 'Balanced Wellness';
      case WellnessProfileType.excellent:
        return 'Excellent Wellness';
    }
  }

  String get description {
    switch (this) {
      case WellnessProfileType.needImprovement:
        return 'Recognize the opportunity for improvement in your wellness today. Acknowledge areas needing attention—nutrition, physical activity, mindfulness, or sleep. Our app is here to guide and support you on your journey towards enhanced well-being. Tomorrow is another chance for positive change.';
      case WellnessProfileType.balanced:
        return 'Congratulations on achieving balanced wellness today! Your commitment to nutrition, fitness, mindfulness, and quality sleep is commendable. Continue embracing a healthier lifestyle, and let our app be your ongoing guide. Here\'s to your well-deserved success in cultivating a vibrant, balanced life!';
      case WellnessProfileType.excellent:
        return ' Congratulations on reaching excellent wellness today! Your dedication to optimal nutrition, fitness, mindfulness, and rest shines through. Celebrate this achievement and let our app continue to support your journey towards sustained well-being. Here\'s to your remarkable success in living your best life!';
    }
  }
}

class WellnessCalculationModel {
  final String title;
  final List<WellnessCalculationModelDetail> details;

  WellnessCalculationModel({required this.title, required this.details});

  factory WellnessCalculationModel.generate() {
    return WellnessCalculationModel(title: 'How do Wellness Score calculated?', details: [
      WellnessCalculationModelDetail(type: StreakItemType.nutrition, title: 'Nutriscore Ranges and Corresponding Scores', descriptions: [
        WellnessCalculationModelDetailDescription(range: 'Nutriscore 0-20', score: '4', description: 'Poor Quality'),
        WellnessCalculationModelDetailDescription(range: 'Nutriscore 21-40', score: '8', description: 'Fair Quality'),
        WellnessCalculationModelDetailDescription(range: 'Nutriscore 41-60', score: '12', description: 'Average Quality'),
        WellnessCalculationModelDetailDescription(range: 'Nutriscore 61-80', score: '16', description: 'Good Quality'),
        WellnessCalculationModelDetailDescription(range: 'Nutriscore 81-100', score: '20', description: 'Excellent Quality'),
      ]),
      WellnessCalculationModelDetail(type: StreakItemType.activity, title: 'Scoring for Physical Activity Level: Based on Steps', descriptions: [
        WellnessCalculationModelDetailDescription(range: '<5000 steps', score: '4', description: 'Sedentary'),
        WellnessCalculationModelDetailDescription(range: '5000-7500 steps', score: '12', description: 'Moderate'),
        WellnessCalculationModelDetailDescription(range: '>7500 steps', score: '20', description: 'Active'),
      ]),
      WellnessCalculationModelDetail(type: StreakItemType.mood, title: 'Scoring for Mood: Based on Daily Mood Logging', descriptions: [
        WellnessCalculationModelDetailDescription(range: 'Awful, Bad', score: '4', description: 'Low'),
        WellnessCalculationModelDetailDescription(range: 'Meh', score: '12', description: 'Unmotivated'),
        WellnessCalculationModelDetailDescription(range: 'Good, Great', score: '20', description: 'Happy, High, Awesome'),
      ]),
      WellnessCalculationModelDetail(type: StreakItemType.sleep, title: 'Scoring for Sleep Analysis', descriptions: [
        WellnessCalculationModelDetailDescription(range: '<5 hours', score: '8', description: 'Poor'),
        WellnessCalculationModelDetailDescription(range: '5 hours', score: '12', description: 'Fair'),
        WellnessCalculationModelDetailDescription(range: '6 hours', score: '16', description: 'Good'),
        WellnessCalculationModelDetailDescription(range: '>7 hours', score: '20', description: 'Excellent'),
      ]),
      WellnessCalculationModelDetail(type: StreakItemType.hydration, title: 'Scoring for Hydration: Based on (ml)', descriptions: [
        WellnessCalculationModelDetailDescription(range: '<500 ml', score: '4', description: 'Dehydrated'),
        WellnessCalculationModelDetailDescription(range: '500 ml', score: '8', description: 'Thristy'),
        WellnessCalculationModelDetailDescription(range: '1000 ml', score: '12', description: 'Over Halfway'),
        WellnessCalculationModelDetailDescription(range: '1500 ml', score: '16', description: 'Hydrated'),
        WellnessCalculationModelDetailDescription(range: '>2000 ml', score: '20', description: 'Supercharged'),
      ]),
    ]);
  }
}

class WellnessCalculationModelDetail {
  final String title;
  final StreakItemType type;
  final List<WellnessCalculationModelDetailDescription> descriptions;

  WellnessCalculationModelDetail({required this.type, required this.title, required this.descriptions});
}

class WellnessCalculationModelDetailDescription {
  String range;
  String score;
  String description;

  WellnessCalculationModelDetailDescription({required this.range, required this.score, required this.description});
}
