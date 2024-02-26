import 'package:livewell/feature/food/presentation/pages/food_screen.dart';

MealTime getMealTypeByCurrentTime() {
  var now = DateTime.now();
  var breakfastStart = DateTime(now.year, now.month, now.day, 3, 0);
  var breakfastEnd = DateTime(now.year, now.month, now.day, 10, 29);
  var lunchStart = DateTime(now.year, now.month, now.day, 10, 30);
  var lunchEnd = DateTime(now.year, now.month, now.day, 14, 30);
  var snackStart = DateTime(now.year, now.month, now.day, 14, 30);
  var snackEnd = DateTime(now.year, now.month, now.day, 16, 30);
  var dinnerStart = DateTime(now.year, now.month, now.day, 16, 30);
  var dinnerEnd = DateTime(now.year, now.month, now.day, 2, 59).add(Duration(days: 1));

  if (now.isAfter(breakfastStart) && now.isBefore(breakfastEnd)) {
    return MealTime.breakfast;
  } else if (now.isAfter(lunchStart) && now.isBefore(lunchEnd)) {
    return MealTime.lunch;
  } else if (now.isAfter(snackStart) && now.isBefore(snackEnd)) {
    return MealTime.snack;
  } else if ((now.isAfter(dinnerStart) && now.isBefore(dinnerEnd)) || (now.isAfter(dinnerStart) && now.isBefore(dinnerEnd.add(Duration(days: 1))))) {
    return MealTime.dinner;
  } else {
    return MealTime.snack;
  }
}
