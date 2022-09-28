class Endpoint {
  /// DEV
  static String api = "http://159.223.36.228:4000/api/v1/";

  /// Login
  static const String login = "auth/login";
  static const String loginGoogle = "customer/login/google";

  /// Register
  static const String register = "auth/registration";

  /// forgot password
  static const String forgotPassword = "auth/forgot-password";

  static const String refreshToken = "auth/refresh";

  static const String user = "user/profile";

  /// food
  static const String foods = "foods";
  static const String addMeal = "user/meal/add";

  /// questionnaire
  static const String questionnaire = "user/onboarding";
}
