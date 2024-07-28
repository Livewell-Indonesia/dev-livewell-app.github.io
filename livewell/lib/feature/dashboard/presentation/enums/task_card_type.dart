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

  void navigation() {
    switch (this) {
      case TaskCardType.hydration:
        AppNavigator.push(routeName: AppPages.waterScreen);
        break;
      case TaskCardType.nutrition:
        // navigate to nutrition screen
        break;
      case TaskCardType.exercise:
        // navigate to exercise screen
        break;
      case TaskCardType.sleep:
        // navigate to sleep screen
        break;
      case TaskCardType.none:
        // navigate to none screen
        break;
      case TaskCardType.mood:
        // navigate to mood screen
        break;
    }
  }
}
