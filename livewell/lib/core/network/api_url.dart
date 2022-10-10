class Endpoint {
  /// DEV
  static String api = "https://dev-api.livewellindo.com/api/v1/";

  /// Login
  static const String login = "auth/login";
  static const String loginGoogle = "customer/login/google";

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

  /// questionnaire
  static const String questionnaire = "user/onboarding";

  /// diary
  static const String userMealHistory = "user/meal/history";
}
