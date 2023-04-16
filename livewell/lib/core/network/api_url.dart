import 'package:flutter/foundation.dart';

class Endpoint {
  /// DEV
  static String api = kReleaseMode
      ? "https://api.livewellindo.com/api/v1/"
      : "https://dev-api.livewellindo.com/api/v1/";

  /// Login
  static const String login = "auth/login";
  static const String loginGoogle = "auth/google";
  static const String loginApple = "auth/apple";

  /// Register
  static const String register = "auth/registration";

  /// forgot password
  static const String forgotPassword = "auth/forgot-password";
  static const String changePassword = "auth/verify-forgot-password";
  static const String refreshToken = "auth/refresh";

  static const String user = "user/profile";
  static const String dailyJournal = "user/daily-journal";
  static const String dashboard = "user/dashboard";
  static const String updateWeight = "user/update/weight";
  static const String userHistory = "user/data/history";

  /// food
  static const String foods = "foods";
  static const String addMeal = "user/meal/add";
  static const String deleteMeal = "user/meal/delete";
  static const String updateMeal = "user/meal/update";
  static const String requestFood = "foods/request";
  static const String nutriCo = "foods/estimated-food-info";
  static const String nutriCoAsset = "config/nutrico-assets";

  /// questionnaire
  static const String questionnaire = "user/onboarding";

  /// diary
  static const String userMealHistory = "user/meal/history";

  static const String appConfig = "config/app";
  static const String popupAssets = "config/pop-up-assets";

  ///Exercise
  static const String postBulkActivities = "activities/bulk-create";
  static const String getActivities = "activities/list";
  static const String getActivityHistories = 'activities/lists';

  /// Sleep
  static const String getSleeps = "activities/lists";

  /// water
  static const String postWater = "hydration";

  static const String getWater = "hydration/list";

  /// nutriscore
  static const String getNutriscore = "nutrition-score";
  static const String getNutriscoreDetail = "nutrition-score/last-7-days";
}
