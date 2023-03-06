import 'package:get/get.dart';
import 'package:livewell/feature/auth/presentation/page/change_pasword/change_password_screen.dart';
import 'package:livewell/feature/auth/presentation/page/forgot_password/forgot_password_screen.dart';
import 'package:livewell/feature/auth/presentation/page/landing/landing_auth_screen.dart';
import 'package:livewell/feature/auth/presentation/page/login/login_screen.dart';
import 'package:livewell/feature/auth/presentation/page/signup/signup_screen.dart';
import 'package:livewell/feature/daily_journal/presentation/page/daily_journal_screen.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_kyc_screen.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/request_food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/scan_barcode_screen.dart';
import 'package:livewell/feature/food/presentation/pages/success_request_food_screen.dart';
import 'package:livewell/feature/home/presentation/home_screen.dart';
import 'package:livewell/feature/nutriscore/presentation/pages/nutriscore_detail_screen.dart';
import 'package:livewell/feature/nutriscore/presentation/pages/nutriscore_screen.dart';
import 'package:livewell/feature/profile/presentation/page/account_settings_screen.dart';
import 'package:livewell/feature/profile/presentation/page/user_settings_screen.dart';
import 'package:livewell/feature/questionnaire/presentation/page/finish_questionnaire_screen.dart';
import 'package:livewell/feature/questionnaire/presentation/page/questionnaire_screen.dart';
import 'package:livewell/feature/splash/presentation/splash_screen.dart';
import 'package:livewell/feature/update_weight/presentation/page/update_weight_screen.dart';
import 'package:livewell/feature/water/presentation/pages/water_consumed_page.dart';
import 'package:livewell/feature/water/presentation/pages/water_custom_input_page.dart';

class AppNavigator {
  static var initialRoute = AppPages.splash;
  static var pages = [
    GetPage(
        name: AppPages.splash,
        page: () => SplashScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.home,
        page: () => HomeScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.landingLogin,
        page: () => const LandingAuthScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.login,
        page: () => LoginScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.signup,
        page: () => const SignUpScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.questionnaire,
        page: () => const QuestionnaireScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.finishQuestionnaire,
        page: () => const FinishQuestionnaireScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.forgotPassword,
        page: () => ForgotPasswordScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.food,
        page: () => const FoodScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.addMeal,
        page: () => const AddMealScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.profile,
        page: () => UserSettingsScreen(),
        transition: Transition.cupertino),
    GetPage(
      name: AppPages.dailyJournal,
      page: () => const DailyJournalScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
        name: AppPages.changePassword,
        page: () => ChangePasswordScreen(),
        transition: Transition.cupertino),
    GetPage(
      name: "${AppPages.scanFood}/:type",
      page: () => const ScanBarcodeScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
        name: AppPages.accountSetting,
        page: () => AccountSettingsScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.requestFood,
        page: () => RequestFoodScreen(),
        transition: Transition.cupertino),
    GetPage(
      name: AppPages.requestFoodSuccess,
      page: () => const SuccessRequestFoodScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
        name: AppPages.updateWeight,
        page: () => UpdateWeightScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.exerciseKYC,
        page: () => ExerciseKYCScreen(),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: AppPages.waterConsumedPage,
        page: () => WaterConsumedPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.waterCustomInputPage,
        page: () => WaterCustomInputPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.nutriScore,
        page: () => NutriScoreScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: AppPages.nutriScoreDetail,
        page: () => NutriScoreDetailsScreen(),
        transition: Transition.cupertino)
  ];

  static void push({required String routeName, dynamic arguments}) {
    Get.toNamed(routeName, arguments: arguments);
  }

  static void pushAndRemove({required String routeName, dynamic arguments}) {
    Get.offAllNamed(routeName, arguments: arguments);
  }

  /// Get.offNamed() is used to remove the previous routes and push the new route.
  static void pushReplacement({required String routeName, dynamic arguments}) {
    Get.offNamed(routeName, arguments: arguments);
  }

  static void pop() {
    Get.back();
  }

  static void popUntil({required String routeName}) {
    Get.until((route) => route.settings.name == routeName);
  }

  static void popUntilRoot() {
    Get.until((route) => route.isFirst);
  }
}

class AppPages {
  static String splash = '/';
  static String home = '/home';
  static String landingLogin = '/landingLogin';
  static String login = '/login';
  static String signup = '/signup';
  static String questionnaire = '/questionnaire';
  static String finishQuestionnaire = '/finishQuestionnaire';
  static String forgotPassword = '/forgotPassword';
  static String food = '/food';
  static String addMeal = '/addMeal';
  static String profile = '/profile';
  static String dailyJournal = '/dailyJournal';
  static String changePassword = '/changePasword';
  static String scanFood = '/scanFood';
  static String accountSetting = '/accountSetting';
  static String requestFood = '/requestFood';
  static String requestFoodSuccess = '/requestFoodSuccess';
  static String updateWeight = '/updateWeight';
  static String exerciseKYC = '/exerciseKYC';
  static String waterConsumedPage = '/waterConsumedPage';
  static String waterCustomInputPage = '/waterCustomInputPage';
  static String nutriScore = '/nutriScorePage';
  static String nutriScoreDetail = '/nutriScoreDetailPage';
}
