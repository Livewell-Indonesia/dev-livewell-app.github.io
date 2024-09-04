import 'package:livewell/routes/app_navigator.dart';

enum TaskCardType { hydration, nutrition, exercise, sleep, none, mood }

extension TaskCardTypeX on TaskCardType {
  String get name {
    switch (this) {
      case TaskCardType.hydration:
        return 'Hydration';
      case TaskCardType.nutrition:
        return 'Nutrition';
      case TaskCardType.exercise:
        return 'Exercise';
      case TaskCardType.sleep:
        return 'Sleep';
      case TaskCardType.none:
        return 'None';
      case TaskCardType.mood:
        return 'Mood';
    }
  }

  static TaskCardType fromString(String value) {
    switch (value) {
      case 'water':
        return TaskCardType.hydration;
      case 'food':
        return TaskCardType.nutrition;
      case 'exercise':
        return TaskCardType.exercise;
      case 'sleep':
        return TaskCardType.sleep;
      case 'none':
        return TaskCardType.none;
      case 'mood':
        return TaskCardType.mood;
      default:
        return TaskCardType.none;
    }
  }

  void navigation() {
    switch (this) {
      case TaskCardType.hydration:
        AppNavigator.push(routeName: AppPages.waterScreen);
        break;
      case TaskCardType.nutrition:
        AppNavigator.push(routeName: AppPages.nutritionScreen);
        break;
      case TaskCardType.exercise:
        AppNavigator.push(routeName: AppPages.exerciseScreen);
        break;
      case TaskCardType.sleep:
        AppNavigator.push(routeName: AppPages.sleepScreen);
        break;
      case TaskCardType.none:
        // navigate to none screen
        break;
      case TaskCardType.mood:
        AppNavigator.push(routeName: AppPages.moodDetailScreen);
        break;
    }
  }
}
