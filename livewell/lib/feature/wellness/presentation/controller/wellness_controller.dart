import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/streak/domain/usecase/get_wellness_recommendation.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';

class WellnessController extends BaseController {
  GetWellnessRecommendation getWellnessRecommendation = GetWellnessRecommendation.instance();
  Rx<String> recommendation = ''.obs;

  Rx<bool> isLoadingRecommendation = false.obs;

  @override
  void onInit() async {
    //isLoadingRecommendation.value = true;
    if (Get.find<DashboardController>().wellnessScore.value != 0) {
      recommendation.value = Get.find<DashboardController>().taskRecommendationModel.value.response?.recommendation ?? "";
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
        return Get.find<HomeController>().localization.wellnessScorePage?.needImprovement ?? "Need Improvement";
      case WellnessProfileType.balanced:
        return Get.find<HomeController>().localization.wellnessScorePage?.balanced ?? "Balanced Wellness";
      case WellnessProfileType.excellent:
        return Get.find<HomeController>().localization.wellnessScorePage?.excellent ?? "Excellent Wellness";
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

  static WellnessCalculationModel generate(Map<String, String> localization) {
    return WellnessCalculationModel(
      title: localization['how_do_wellness_score_calculated'] ?? 'How do Wellness Score calculated?',
      details: [
        WellnessCalculationModelDetail(
          type: StreakItemType.nutrition,
          title: localization['nutriscore_title'] ?? 'Nutriscore Ranges and Corresponding Scores',
          descriptions: [
            WellnessCalculationModelDetailDescription(
              range: localization['nutriscore_range_0_20'] ?? 'Nutriscore 0-20',
              score: localization["nutriscore_score_0_20"] ?? '4',
              description: localization['nutriscore_category_0_20'] ?? 'Poor Quality',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['nutriscore_range_21_40'] ?? 'Nutriscore 21-40',
              score: localization["nutriscore_score_21_40"] ?? '8',
              description: localization['nutriscore_category_21_40'] ?? 'Fair Quality',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['nutriscore_range_41_60'] ?? 'Nutriscore 41-60',
              score: localization["nutriscore_score_41_60"] ?? '12',
              description: localization['nutriscore_category_41_60'] ?? 'Average Quality',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['nutriscore_range_61_80'] ?? 'Nutriscore 61-80',
              score: localization["nutriscore_score_61_80"] ?? '16',
              description: localization['nutriscore_category_61_80'] ?? 'Good Quality',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['nutriscore_range_81_100'] ?? 'Nutriscore 81-100',
              score: localization["nutriscore_score_81_100"] ?? '20',
              description: localization['nutriscore_category_81_100'] ?? 'Excellent Quality',
            ),
          ],
        ),
        WellnessCalculationModelDetail(
          type: StreakItemType.activity,
          title: localization['physical_activity_title'] ?? 'Scoring for Physical Activity Level: Based on Steps',
          descriptions: [
            WellnessCalculationModelDetailDescription(
              range: localization['physical_activity_range_5000'] ?? '<5000 steps',
              score: localization['physical_activity_score_5000'] ?? '4',
              description: localization['physical_activity_category_5000'] ?? 'Sedentary',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['physical_activity_range_5000_7500'] ?? '5000-7500 steps',
              score: localization['physical_activity_score_5000_7500'] ?? '12',
              description: localization['physical_activity_category_5000_7500'] ?? 'Moderate',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['physical_activity_range_7500'] ?? '>7500 steps',
              score: localization['physical_activity_score_7500'] ?? '20',
              description: localization['physical_activity_category_7500'] ?? 'Active',
            ),
          ],
        ),
        WellnessCalculationModelDetail(
          type: StreakItemType.mood,
          title: localization['mood_title'] ?? 'Scoring for Mood: Based on Daily Mood Logging',
          descriptions: [
            WellnessCalculationModelDetailDescription(
              range: localization['mood_range_awful_bad'] ?? 'Awful, Bad',
              score: localization['mood_score_awful_bad'] ?? '4',
              description: localization['mood_category_awful_bad'] ?? 'Low',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['mood_range_meh'] ?? 'Meh',
              score: localization['mood_score_meh'] ?? '12',
              description: localization['mood_category_meh'] ?? 'Unmotivated',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['mood_range_good_great'] ?? 'Good, Great',
              score: localization['mood_score_good_great'] ?? '20',
              description: localization['mood_category_good_great'] ?? 'Happy, High, Awesome',
            ),
          ],
        ),
        WellnessCalculationModelDetail(
          type: StreakItemType.sleep,
          title: localization['sleep_title'] ?? 'Scoring for Sleep Analysis',
          descriptions: [
            WellnessCalculationModelDetailDescription(
              range: localization['sleep_range_lower_5_hours'] ?? '<5 hours',
              score: localization['sleep_score_lower_5_hours'] ?? '8',
              description: localization['sleep_category_lower_5_hours'] ?? 'Poor',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['sleep_range_5_hours'] ?? '5 hours',
              score: localization['sleep_score_5_hours'] ?? '12',
              description: localization['sleep_category_5_hours'] ?? 'Fair',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['sleep_range_6_hours'] ?? '6 hours',
              score: localization['sleep_score_6_hours'] ?? '16',
              description: localization['sleep_category_6_hours'] ?? 'Good',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['sleep_range_more_7_hours'] ?? '>7 hours',
              score: localization['sleep_score_more_7_hours'] ?? '20',
              description: localization['sleep_category_more_7_hours'] ?? 'Excellent',
            ),
          ],
        ),
        WellnessCalculationModelDetail(
          type: StreakItemType.hydration,
          title: localization['hydration_title'] ?? 'Scoring for Hydration: Based on (ml)',
          descriptions: [
            WellnessCalculationModelDetailDescription(
              range: localization['hydration_range_lower_500'] ?? '<500 ml',
              score: localization['hydration_score_lower_500'] ?? '4',
              description: localization['hydration_category_lower_500'] ?? 'Dehydrated',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['hydration_range_500'] ?? '500 ml',
              score: localization['hydration_score_500'] ?? '8',
              description: localization['hydration_category_500'] ?? 'Thirsty',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['hydration_range_1000'] ?? '1000 ml',
              score: localization['hydration_score_1000'] ?? '12',
              description: localization['hydration_category_1000'] ?? 'Over Halfway',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['hydration_range_1500'] ?? '1500 ml',
              score: localization['hydration_score_1500'] ?? '16',
              description: localization['hydration_category_1500'] ?? 'Hydrated',
            ),
            WellnessCalculationModelDetailDescription(
              range: localization['hydration_range_more_2000'] ?? '>2000 ml',
              score: localization['hydration_score_more_2000'] ?? '20',
              description: localization['hydration_category_more_2000'] ?? 'Supercharged',
            ),
          ],
        ),
      ],
    );
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
