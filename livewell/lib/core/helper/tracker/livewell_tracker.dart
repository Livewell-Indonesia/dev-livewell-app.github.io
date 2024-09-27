import 'package:get/get.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class LivewellTrackerService extends GetxService {
  Mixpanel _mixpanel;
  bool isInitialized = false;

  LivewellTrackerService(this._mixpanel);

  @override
  void onInit() async {
    //init();
    super.onInit();
    //_mixpanel = await Mixpanel.init("b95e1ff0a63a8b2d63e10d2b7b0e8757", trackAutomaticEvents: false);
  }

  Future<void> init() async {
    _mixpanel = await Mixpanel.init("b95e1ff0a63a8b2d63e10d2b7b0e8757", trackAutomaticEvents: false);
  }

  void identifyUser(String userId) {
    _mixpanel.identify(userId);
  }

  void trackEvent(String eventName, {Map<String, dynamic>? properties}) {
    _mixpanel.track(eventName, properties: properties);
  }
}

abstract class LivewellEvent {}

class LivewellAuthEvent extends LivewellEvent {
  static const String splashScreen = "Splash Screen";
  static const String landingPage = "Landing Page";
  static const String landingPageGetStarted = "Landing Page - Get Started";
  static const String landingPageSignIn = "Landing Page - Sign In";
  static const String signUpPage = "Sign Up Page";
  static const String signupPageSignUpButton = "Sign Up Page - Sign Up Button";
  static const String signUpPageSignUpGoogle = "Sign Up Page - Sign Up Google Button";
  static const String signUpPageSignUpApple = "Sign Up Page - Sign Up Apple Button";
  static const String signUpPageSignIn = "Sign Up Page - Sign In Button";
  static const String signUpPageBack = "Sign Up Page - Back Button";
  static const String signUpPageTnc = "Sign Up Page - TnC Button";
  static const String signUpPagePrivacyPolicy = "Sign Up Page - Privacy Policy Button";
  static const String signInPage = "Sign In Page";
  static const String signInPageSignInButton = "Sign In Page - Sign In Button";
  static const String signInPageSignInGoogle = "Sign In Page - Sign In Google Button";
  static const String signInPageSignInApple = "Sign In Page - Sign In Apple Button";
  static const String signInPageSignUp = "Sign In Page - Sign Up Button";
  static const String signInPageTnc = "Sign In Page - TnC Button";
  static const String signInPagePrivacyPolicy = "Sign In Page - Privacy Policy Button";
  static const String signInPageBack = "Sign In Page - Back Button";
  static const String tncPage = "TnC Page";
  static const String privacyPolicyPage = "Privacy Policy Page";
  static const String forgotPasswordPage = "Forgot Password Page";
  static const String forgotPasswordSubmit = "Forgot Password Page - Submit Button";
  static const String forgotPasswordBack = "Forgot Password Page - Back Button";
  static const String forgotPasswordChangePassword = "Forgot Password Page - Change Password Page";
  static const String forgotPasswordChangePasswordChange = "Forgot Password Page - Change Password Page - Change Button";
  static const String forgotPasswordChangePasswordDone = "Forgot Password Page - Change Password Page - Done Button";
  static const String onboardingLandingPage = "Onboarding Landing Page";
  static const String onboardingLandingPageNext = "Onboarding Landing Page - Next Button";
  static const String onboardingLandingPagePrev = "Onboarding Landing Page - Prev Button";
  static const String onboardingPageOne = "Onboarding Page 1";
  static const String onboardingPageOneNext = "Onboarding Page 1 - Next Button";
  static const String onboardingPageOnePrev = "Onboarding Page 1 - Prev Button";
  static const String onboardingPageTwo = "Onboarding Page 2";
  static const String onboardingPageTwoNext = "Onboarding Page 2 - Next Button";
  static const String onboardingPageTwoPrev = "Onboarding Page 2 - Prev Button";
  static const String onboardingPageThree = "Onboarding Page 3";
  static const String onboardingPageThreeNext = "Onboarding Page 3 - Next Button";
  static const String onboardingPageThreePrev = "Onboarding Page 3 - Prev Button";
  static const String onboardingThankYouPage = "Onboarding Thank You Page";
  static const String onboardingThankYouPageGetStarted = "Onboarding Thank You Page - Get Started Button";
}

class LivewellHomepageEvent extends LivewellEvent {
  static const String homepage = "Homepage";
  static const String profileButton = "Homepage - Profile Button";
  static const String journalButton = "Homepage - Journal Button";
  static const String streakButton = "Homepage - Streak Button";
  static const String wellnessScoreSeeDetailButton = "Homepage - Wellness Score See Detail Button";
  static const String summaryCaloriesButton = "Homepage - Summary Calories Button";
  static const String summaryCarbsButton = "Homepage - Summary Carbs Button";
  static const String summaryProteinButton = "Homepage - Summary Protein Button";
  static const String summaryFatButton = "Homepage - Summary Fat Button";
  static const String summaryExerciseButton = "Homepage - Summary Exercise Button";
  static const String summarySleepButton = "Homepage - Summary Sleep Button";
  static const String summaryWaterButton = "Homepage - Summary Water Button";
  static const String summaryMoodButton = "Homepage - Summary Mood Button";
  static const String nutritionButton = "Homepage - Nutrition Button";
  static const String exerciseButton = "Homepage - Exercise Button";
  static const String sleepButton = "Homepage - Sleep Button";
  static const String waterButton = "Homepage - Water Button";
  static const String moodButton = "Homepage - Mood Button";
  static const String taskListMoodButton = "Homepage - Task List - Mood Button";
  static const String taskListWaterButton = "Homepage - Task List - Water Button";
  static const String taskListBreakfastButton = "Homepage - Task List - Breakfast Button";
  static const String taskListLunchButton = "Homepage - Task List - Lunch Button";
  static const String taskListSnackButton = "Homepage - Task List - Snack Button";
  static const String taskListDinnerButton = "Homepage - Task List - Dinner Button";
  static const String navbarHomeButton = "Homepage - Navbar - Home Button";
  static const String navbarNutricoButton = "Homepage - Navbar - Nutrico Button";
  static const String navbarAccountButton = "Homepage - Navbar - Account Button";
  static const String navbarNutricoDescribeFoodButton = "Homepage - Navbar - Nutrico - Describe Food Button";
  static const String navbarNutricoPickFromGalleryButton = "Homepage - Navbar - Nutrico - Pick From Gallery Button";
  static const String navbarNutricoTakeAPhotoButton = "Homepage - Navbar - Nutrico - Take a Photo Button";
  static const String navbarNutricoInformationButton = "Homepage - Navbar - Nutrico - Information Button";
}

class LivewellNutricoEvent extends LivewellEvent {
  static const String describeFoodPage = "Nutrico Describe Food Page";
  static const String describeFoodPageBackButton = "Nutrico Describe Food Page - Back Button";
  static const String describeFoodPageInformationButton = "Nutrico Describe Food Page - Information Button";
  static const String describeFoodPageSubmitButton = "Nutrico Describe Food Page - Submit Button";
  static const String imageLoadingPage = "Nutrico Image Loading Page";
}

class LivewellFoodEvent extends LivewellEvent {
  static const String detailPage = "Food Detail Page";
  static const String detailPageBackButton = "Food Detail Page - Back Button";
  static const String detailPageMealTimeButton = "Food Detail Page - Meal Time Button";
  static const String detailPageEditButton = "Food Detail Page - Edit Button";
  static const String detailPageShareButton = "Food Detail Page - Share Button";
  static const String detailPageSharePickFromGalleryButton = "Food Detail Page - Share - Pick from Gallery Button";
  static const String detailPageShareTakeAPhotoButton = "Food Detail Page - Share - Take a Photo Button";
  static const String detailPageShare16_9RatioButton = "Food Detail Page - Share - 16:9 Ratio Button";
  static const String detailPageShare1_1RatioButton = "Food Detail Page - Share - 1:1 Ratio Button";
  static const String detailPageChooseTemplateBackButton = "Food Detail Page - Choose Template - Back Button";
  static const String detailPageChooseTemplateDoneButton = "Food Detail Page - Choose Template - Done Button";
  static const String detailPageShareBackButton = "Food Detail Page - Share - Back Button";
  static const String detailPageShareShareToInstagramButton = "Food Detail Page - Share - Share to Instagram Button";
  static const String detailPageShareShareToFacebookButton = "Food Detail Page - Share - Share to Facebook Button";
  static const String detailPageShareSaveImageButton = "Food Detail Page - Share - Save Image Button";
  static const String detailPageTimestampButton = "Food Detail Page - Timestamp Button";
  static const String detailPageTimestampCancelButton = "Food Detail Page - Timestamp - Cancel Button";
  static const String detailPageTimestampSaveButton = "Food Detail Page - Timestamp - Save Button";
  static const String detailPageSaveButton = "Food Detail Page - Save Button";
}

class LivewellNutritionEvent extends LivewellEvent {
  static const String nutritionPage = "Nutrition Page";
  static const String nutritionPageBackButton = "Nutrition Page - Back Button";
  static const String nutritionPageNutriscoreButton = "Nutrition Page - Nutriscore Button";
  static const String nutritionPageAddMealLogButton = "Nutrition Page - Add Meal Log Button";
  static const String nutritionPageMealButton = "Nutrition Page - Meal Button";
  static const String nutritionPageUpdateMealButton = "Nutrition Page - Update Meal Button";
  static const String nutritionPageDeleteMealButton = "Nutrition Page - Delete Meal Button";
}

class LivewellNutriscoreEvent extends LivewellEvent {
  static const String nutriscorePage = "Nutriscore Page";
  static const String nutriscorePageBackButton = "Nutriscore Page - Back Button";
  static const String nutriscorePageNutriscoreDetailButton = "Nutriscore Page - Nutriscore Detail Button";
  static const String nutriscorePageEachNutrientButton = "Nutriscore Page - Each Nutrient Button";
  static const String nutriscorePageNutriscoreDetailPage = "Nutriscore Page - Nutriscore Detail Page";
  static const String nutriscorePageNutriscoreDetailPageBackButton = "Nutriscore Page - Nutriscore Detail Page - Back Button";
  static const String nutriscorePageNutrientDetailPage = "Nutriscore Page - Nutrient Detail Page";
  static const String nutriscorePageNutrientDetailPageBackButton = "Nutriscore Page - Nutrient Detail Page - Back Button";
}

class LivewellMealLogEvent extends LivewellEvent {
  static const String mealLogPage = "Meal Log Page";
  static const String mealLogPageBackButton = "Meal Log Page - Back Button";
  static const String mealLogPageNutricoButton = "Meal Log Page - Nutrico Button";
  static const String mealLogPageQuickAddButton = "Meal Log Page - Quick Add Button";
  static const String mealLogPageFoodButton = "Meal Log Page - Food Button";
  static const String mealLogPageNutricoDescribeFoodButton = "Meal Log Page - Nutrico - Describe Food Button";
  static const String mealLogPageNutricoPickFromGalleryButton = "Meal Log Page - Nutrico - Pick from Gallery Button";
  static const String mealLogPageNutricoTakeAPhotoButton = "Meal Log Page - Nutrico - Take a Photo Button";
  static const String mealLogPageNutricoInformationButton = "Meal Log Page - Nutrico - Information Button";
  static const String mealLogPageFoodRecommendationButton = "Meal Log Page - Food Recommendation Button";
  static const String mealLogPageRequestFoodButton = "Meal Log Page - Request Food Button";
  static const String mealLogPageRequestFoodPage = "Meal Log Page - Request Food Page";
  static const String mealLogPageRequestFoodPageBackButton = "Meal Log Page - Request Food Page - Back Button";
  static const String mealLogPageRequestFoodPageSubmitButton = "Meal Log Page - Request Food Page - Submit Button";
  static const String mealLogPageFilterButton = "Meal Log Page - Filter Button";
  static const String mealLogPageFilterDrawerResetFilterButton = "Meal Log Page - Filter Drawer - Reset Filter Button";
  static const String mealLogPageFilterDrawerSubmitButton = "Meal Log Page - Filter Drawer - Submit Button";
  static const String mealLogPageQuickAddPage = "Meal Log Page - Quick Add Page";
  static const String mealLogPageQuickAddPageBackButton = "Meal Log Page - Quick Add Page - Back Button";
  static const String mealLogPageQuickAddPageSubmitButton = "Meal Log Page - Quick Add Page - Submit Button";
}

class LivewellStreakEvent extends LivewellEvent {
  static const String streakPage = "Streak Page";
  static const String streakPageBackButton = "Streak Page - Back Button";
  static const String streakPageDateButton = "Streak Page - Date Button";
  static const String streakPageHydrationWaterButton = "Streak Page - Hydration/Water Button";
  static const String streakPageSleepButton = "Streak Page - Sleep Button";
  static const String streakPageMoodButton = "Streak Page - Mood Button";
  static const String streakPageNutritionButton = "Streak Page - Nutrition Button";
  static const String streakPageActivityButton = "Streak Page - Activity Button";
}

class LivewellWellnessScoreEvent extends LivewellEvent {
  static const String wellnessScorePage = "Wellness Score Page";
  static const String wellnessScorePageBackButton = "Wellness Score Page - Back Button";
}

class LivewellWeightEvent extends LivewellEvent {
  static const String weightPage = "Weight Page";
  static const String weightPageBackButton = "Weight Page - Back Button";
  static const String weightPageSettingButton = "Weight Page - Setting Button";
  static const String weightPageUpdateWeightButton = "Weight Page - Update Weight Button";
  static const String weightPageGoalsSettingUpdateButton = "Weight Page - Goals Setting - Update Button";
  static const String weightPageGoalsSettingBackButton = "Weight Page - Goals Setting - Back Button";
  static const String weightPageUpdateWeightUpdateButton = "Weight Page - Update Weight - Update Button";
}

class LivewellExerciseEvent extends LivewellEvent {
  static const String exercisePage = "Exercise Page";
  static const String exercisePageBackButton = "Exercise Page - Back Button";
  static const String exercisePageShareButton = "Exercise Page - Share Button";
  static const String exercisePageInfoButton = "Exercise Page - Info Button";
  static const String exercisePageInputStepsButton = "Exercise Page - Input Steps Button";
  static const String exercisePageSharePickFromGalleryButton = "Exercise Page - Share - Pick from Gallery Button";
  static const String exercisePageShareTakeAPhotoButton = "Exercise Page - Share - Take a Photo Button";
  static const String exercisePageShare169RatioButton = "Exercise Page - Share - 16:9 Ratio Button";
  static const String exercisePageShare11RatioButton = "Exercise Page - Share - 1:1 Ratio Button";
  static const String exercisePageShareShareToInstagramButton = "Exercise Page - Share - Share to Instagram Button";
  static const String exercisePageShareShareToFacebookButton = "Exercise Page - Share - Share to Facebook Button";
  static const String exercisePageShareSaveImageButton = "Exercise Page - Share - Save Image Button";
}

class LivewellSleepEvent extends LivewellEvent {
  static const String sleepPage = "Sleep Page";
  static const String sleepPageBackButton = "Sleep Page - Back Button";
  static const String sleepPageInformationButton = "Sleep Page - Information Button";
  static const String sleepPageInputSleepButton = "Sleep Page - Input Sleep Button";
}

class LivewellWaterEvent extends LivewellEvent {
  static const String waterPage = "Water Page";
  static const String waterPageBackButton = "Water Page - Back Button";
  static const String waterPageInformationButton = "Water Page - Information Button";
  static const String waterPageAddDrinkButton = "Water Page - Add Drink Button";
  static const String waterPageReduceWaterButton = "Water Page - Reduce Water Button";
  static const String waterPageAddDrinkAddDrinkButton = "Water Page - Add Drink - Add Drink Button";
  static const String waterPageAddDrinkBackButton = "Water Page - Add Drink - Back Button";
  static const String waterPageAddDrinkCustomButton = "Water Page - Add Drink - Custom Button";
  static const String waterPageAddDrinkCustomAddDrinkButton = "Water Page - Add Drink - Custom - Add Drink Button";
  static const String waterPageAddDrinkCustomCancelButton = "Water Page - Add Drink - Custom - Cancel Button";
  static const String waterPageReduceWaterBackButton = "Water Page - Reduce Water - Back Button";
  static const String waterPageReduceWaterCustomButton = "Water Page - Reduce Water - Custom Button";
  static const String waterPageReduceWaterCustomReduceWaterButton = "Water Page - Reduce Water - Custom - Reduce Water Button";
  static const String waterPageReduceWaterCustomCancelButton = "Water Page - Reduce Water - Custom - Cancel Button";
}

class LivewellMoodEvent extends LivewellEvent {
  static const String moodPage = "Mood Page";
  static const String moodPageBackButton = "Mood Page - Back Button";
  static const String moodPageMoodButton = "Mood Page - Mood Button";
}

class LivewellJournalEvent extends LivewellEvent {
  static const String journalPage = "Journal Page";
  static const String journalPageAddFoodButton = "Journal Page - Add Food Button";
  static const String journalPageEditButton = "Journal Page - Edit Button";
  static const String journalPageEditPortionButton = "Journal Page - Edit Portion Button";
  static const String journalPageEditPortionDrawerUpdateButton = "Journal Page - Edit Portion Drawer - Update Button";
  static const String journalPageEditPortionDrawerCancelButton = "Journal Page - Edit Portion Drawer - Cancel Button";
  static const String journalPageDeleteButton = "Journal Page - Delete Button";
  static const String journalPageMoodButton = "Journal Page - Mood Button";
  static const String journalPageDateButton = "Journal Page - Date Button";
  static const String journalPageNextDateButton = "Journal Page - Next Date Button";
  static const String journalPagePreviousDateButton = "Journal Page - Previous Date Button";
  static const String journalPageBackButton = "Journal Page - Back Button";
}

class LivewellProfileEvent extends LivewellEvent {
  static const String profilePage = "Profile Page";
  static const String profilePageChangePictureButton = "Profile Page - Change Picture Button";
  static const String profilePageChangePictureButtonPickFromGalleryPage = "Profile Page - Change Picture Button - Pick from Gallery Page";
  static const String profilePageChangePictureButtonTakeAPhotoPage = "Profile Page - Change Picture Button - Take a Photo Page";
  static const String profilePageAccountSettingsButton = "Profile Page - Account Settings Button";
  static const String profilePageDailyJournalButton = "Profile Page - Daily Journal Button";
  static const String profilePagePhysicalInformationButton = "Profile Page - Physical Information Button";
  static const String profilePageMyGoalsButton = "Profile Page - My Goals Button";
  static const String profilePageLanguageButton = "Profile Page - Language Button";
  static const String profilePageLanguagePopupSaveChangesButton = "Profile Page - Language Popup - Save Changes Button";
  static const String profilePagePrivacyPolicyButton = "Profile Page - Privacy Policy Button";
  static const String profilePageLogoutButton = "Profile Page - Logout Button";
  static const String accountSettingsPage = "Account Settings Page";
  static const String accountSettingsPageChangePictureButton = "Account Settings Page - Change Picture Button";
  static const String accountSettingsPageChangePictureButtonPickFromGalleryPage = "Account Settings Page - Change Picture Button - Pick from Gallery Page";
  static const String accountSettingsPageChangePictureButtonTakeAPhotoPage = "Account Settings Page - Change Picture Button - Take a Photo Page";
  static const String accountSettingsPageChangePasswordButton = "Account Settings Page - Change Password Button";
  static const String accountSettingsPageDeleteAccountButton = "Account Settings Page - Delete Account Button";
  static const String accountSettingsPageUpdateButton = "Account Settings Page - Update Button";
  static const String changePasswordPage = "Change Password Page";
  static const String changePasswordPageChangeButton = "Change Password Page - Change Button";
  static const String changePasswordPageLoginButton = "Change Password Page - Login Button";
  static const String deleteAccountCancelButton = "Delete Account - Cancel Button";
  static const String deleteAccountConfirmButton = "Delete Account - Confirm Button";
  static const String dailyJournalPage = "Daily Journal Page";
  static const String dailyJournalPageBreakfastButton = "Daily Journal Page - Breakfast Button";
  static const String dailyJournalPageLunchButton = "Daily Journal Page - Lunch Button";
  static const String dailyJournalPageDinnerButton = "Daily Journal Page - Dinner Button";
  static const String dailyJournalPageSnackButton = "Daily Journal Page - Snack Button";
  static const String dailyJournalPageTimePopupCancelButton = "Daily Journal Page - Time Popup - Cancel Button";
  static const String dailyJournalPageTimePopupSaveButton = "Daily Journal Page - Time Popup - Save Button";
  static const String dailyJournalPageSaveButton = "Daily Journal Page - Save Button";
  static const String physicalInformationPage = "Physical Information Page";
  static const String physicalInformationPageSaveButton = "Physical Information Page - Save Button";
  static const String myGoalsPage = "My Goals Page";
  static const String myGoalsPageSaveButton = "My Goals Page - Save Button";
}

// enum LivewellEvent {
//   splashScreen,
//   landingPage,
//   landingPageGetStarted,
//   landingPageSignIn,
//   signUpPage,
//   signupPageSignUpButton,
//   signUpPageSignUpGoogle,
//   signUpPageSignUpApple,
//   signUpPageSignIn,
//   signUpPageTnc,
//   signUpPagePrivacyPolicy,
//   signInPage,
//   signInPageSignInButton,
//   signInPageSignInGoogle,
//   signInPageSignInApple,
//   signInPageSignUp,
//   signInPageTnc,
//   signInPagePrivacyPolicy,
//   signInPageBack,
//   tncPage,
//   privacyPolicyPage,
//   forgotPasswordPage,
//   forgotPasswordSubmit,
//   forgotPasswordBack,
//   forgotPasswordChangePassword,
//   forgotPasswordChangePasswordChange,
//   forgotPasswordChangePasswordDone,
//   onboardingLandingPage,
//   onboardingLandingPageNext,
//   onboardingLandingPagePrev,
//   onboardingPageOne,
//   onboardingPageOneNext,
//   onboardingPageOnePrev,
//   onboardingPageTwo,
//   onboardingPageTwoNext,
//   onboardingPageTwoPrev,
//   onboardingPageThree,
//   onboardingPageThreeNext,
//   onboardingPageThreePrev,
//   onboardingThankYouPage,
//   onboardingThankYouPageGetStarted,
// }

// extension LivewellEventExt on LivewellEvent {
//   String get name {
//     switch (this) {
//       case LivewellEvent.splashScreen:
//         return "Splash Screen";
//       case LivewellEvent.landingPage:
//         return "Landing Page";
//       case LivewellEvent.landingPageGetStarted:
//         return "Landing Page Get Started";
//       case LivewellEvent.landingPageSignIn:
//         return "Landing Page Sign In";
//       case LivewellEvent.signUpPage:
//         return "Sign Up Page";
//       case LivewellEvent.signupPageSignUpButton:
//         return "Sign Up Page - Sign Up Button";
//       case LivewellEvent.signUpPageSignUpGoogle:
//         return "Sign Up Page - Sign Up Google Button";
//       case LivewellEvent.signUpPageSignUpApple:
//         return "Sign Up Page - Sign Up Apple Button";
//       case LivewellEvent.signUpPageSignIn:
//         return "Sign Up Page - Sign In Button";
//       case LivewellEvent.signUpPageTnc:
//         return "Sign Up Page - TnC Button";
//       case LivewellEvent.signUpPagePrivacyPolicy:
//         return "Sign Up Page - Privacy Policy Button";
//       case LivewellEvent.signInPage:
//         return "Sign In Page";
//       case LivewellEvent.signInPageSignInButton:
//         return "Sign In Page - Sign In Button";
//       case LivewellEvent.signInPageSignInGoogle:
//         return "Sign In Page - Sign In Google Button";
//       case LivewellEvent.signInPageSignInApple:
//         return "Sign In Page - Sign In Apple Button";
//       case LivewellEvent.signInPageSignUp:
//         return "Sign In Page - Sign Up Button";
//       case LivewellEvent.signInPageTnc:
//         return "Sign In Page - TnC Button";
//       case LivewellEvent.signInPagePrivacyPolicy:
//         return "Sign In Page - Privacy Policy Button";
//       case LivewellEvent.signInPageBack:
//         return "Sign In Page - Back Button";
//       case LivewellEvent.tncPage:
//         return "TnC Page";
//       case LivewellEvent.privacyPolicyPage:
//         return "Privacy Policy Page";
//       case LivewellEvent.forgotPasswordPage:
//         return "Forgot Password Page";
//       case LivewellEvent.forgotPasswordSubmit:
//         return "Forgot Password Page - Submit Button";
//       case LivewellEvent.forgotPasswordBack:
//         return "Forgot Password Page - Back Button";
//       case LivewellEvent.forgotPasswordChangePassword:
//         return "Forgot Password Page - Change Password Page";
//       case LivewellEvent.forgotPasswordChangePasswordChange:
//         return "Forgot Password Page - Change Password Page - Change Button";
//       case LivewellEvent.forgotPasswordChangePasswordDone:
//         return "Forgot Password Page - Change Password Page - Done Button";
//       case LivewellEvent.onboardingLandingPage:
//         return "Onboarding Landing Page";
//       case LivewellEvent.onboardingLandingPageNext:
//         return "Onboarding Landing Page - Next Button";
//       case LivewellEvent.onboardingLandingPagePrev:
//         return "Onboarding Landing Page - Prev Button";
//       case LivewellEvent.onboardingPageOne:
//         return "Onboarding Page 1";
//       case LivewellEvent.onboardingPageOneNext:
//         return "Onboarding Page 1 - Next Button";
//       case LivewellEvent.onboardingPageOnePrev:
//         return "Onboarding Page 1 - Prev Button";
//       case LivewellEvent.onboardingPageTwo:
//         return "Onboarding Page 2";
//       case LivewellEvent.onboardingPageTwoNext:
//         return "Onboarding Page 2 - Next Button";
//       case LivewellEvent.onboardingPageTwoPrev:
//         return "Onboarding Page 2 - Prev Button";
//       case LivewellEvent.onboardingPageThree:
//         return "Onboarding Page 3";
//       case LivewellEvent.onboardingPageThreeNext:
//         return "Onboarding Page 3 - Next Button";
//       case LivewellEvent.onboardingPageThreePrev:
//         return "Onboarding Page 3 - Prev Button";
//       case LivewellEvent.onboardingThankYouPage:
//         return "Onboarding Thank You Page";
//       case LivewellEvent.onboardingThankYouPageGetStarted:
//         return "Onboarding Thank You Page - Get Started Button";
//     }
//   }
// }
