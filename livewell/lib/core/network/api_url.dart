import 'package:flutter/foundation.dart';

class Endpoint {
  /// DEV
  static String api = kReleaseMode
      ? "https://api.livewellindo.com/api/v1/"
      : "https://dev-api.livewellindo.com/api/v1/";

  /// Login
  static const String login = "auth/login";
  static const String loginGoogle = "auth/google";

  /// Register
  static const String register = "auth/registration";

  /// forgot password
  static const String forgotPassword = "auth/forgot-password";
  static const String changePassword = "auth/verify-forgot-password";
  static const String refreshToken = "auth/refresh";

  static const String user = "user/profile";
  static const String dailyJournal = "user/daily-journal";
  static const String dashboard = "user/dashboard";

  /// food
  static const String foods = "foods";
  static const String addMeal = "user/meal/add";
  static const String deleteMeal = "user/meal/delete";
  static const String updateMeal = "user/meal/update";
  static const String requestFood = "foods/request";

  /// questionnaire
  static const String questionnaire = "user/onboarding";

  /// diary
  static const String userMealHistory = "user/meal/history";

  static const String appConfig = "config/app";
}
