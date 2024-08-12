// To parse this JSON data, do
//
//     final localizationModelV2 = localizationModelV2FromJson(jsonString);

import 'dart:convert';

LocalizationModelV2 localizationModelV2FromJson(String str) => LocalizationModelV2.fromJson(json.decode(str));

String localizationModelV2ToJson(LocalizationModelV2 data) => json.encode(data.toJson());

class LocalizationModelV2 {
  LocalizationKeyV2? enUs;
  LocalizationKeyV2? idId;

  LocalizationModelV2({
    this.enUs,
    this.idId,
  });

  factory LocalizationModelV2.fromJson(Map<String, dynamic> json) => LocalizationModelV2(
        enUs: json["en_US"] == null ? null : LocalizationKeyV2.fromJson(json["en_US"]),
        idId: json["id_ID"] == null ? null : LocalizationKeyV2.fromJson(json["id_ID"]),
      );

  Map<String, dynamic> toJson() => {
        "en_US": enUs?.toJson(),
        "id_ID": idId?.toJson(),
      };
}

class LocalizationKeyV2 {
  AccountPage? accountPage;
  AccountSettingsPage? accountSettingsPage;
  AddFoodPage? addFoodPage;
  AddMealPage? addMealPage;
  ChangePasswordPage? changePasswordPage;
  DailyJournalPage? dailyJournalPage;
  DeleteAccountDialog? deleteAccountDialog;
  ExercisePage? exercisePage;
  ForgotPasswordPage? forgotPasswordPage;
  HomePage? homePage;
  LandingPage? landingPage;
  LanguagesDialog? languagesDialog;
  MoodPage? moodPage;
  MyGoalsPage? myGoalsPage;
  NutrientFactPage? nutrientFactPage;
  NutriscoreDetailPage? nutriscoreDetailPage;
  NutritionPage? nutritionPage;
  OnboardingPage? onboardingPage;
  PhysicalInformationPage? physicalInformationPage;
  RequestFoodPage? requestFoodPage;
  RequestFoodSuccessPage? requestFoodSuccessPage;
  SignInPage? signInPage;
  SignUpPage? signUpPage;
  SleepPage? sleepPage;
  StreakPage? streakPage;
  UpdatePasswordPage? updatePasswordPage;
  UserDiaryPage? userDiaryPage;
  WaterPage? waterPage;
  WeightPage? weightPage;
  Map<String, String>? wellnessCalculation;
  WellnessScorePage? wellnessScorePage;
  NutricoPlusBottomSheet? nutricoPlusBottomSheet;
  TooltipHomePage? tooltipHomePage;

  LocalizationKeyV2({
    this.accountPage,
    this.accountSettingsPage,
    this.addFoodPage,
    this.addMealPage,
    this.changePasswordPage,
    this.dailyJournalPage,
    this.deleteAccountDialog,
    this.exercisePage,
    this.forgotPasswordPage,
    this.homePage,
    this.landingPage,
    this.languagesDialog,
    this.moodPage,
    this.myGoalsPage,
    this.nutrientFactPage,
    this.nutriscoreDetailPage,
    this.nutritionPage,
    this.onboardingPage,
    this.physicalInformationPage,
    this.requestFoodPage,
    this.requestFoodSuccessPage,
    this.signInPage,
    this.signUpPage,
    this.sleepPage,
    this.streakPage,
    this.updatePasswordPage,
    this.userDiaryPage,
    this.waterPage,
    this.weightPage,
    this.wellnessCalculation,
    this.wellnessScorePage,
    this.nutricoPlusBottomSheet,
    this.tooltipHomePage,
  });

  factory LocalizationKeyV2.fromJson(Map<String, dynamic> json) => LocalizationKeyV2(
        accountPage: json["account_page"] == null ? null : AccountPage.fromJson(json["account_page"]),
        accountSettingsPage: json["account_settings_page"] == null ? null : AccountSettingsPage.fromJson(json["account_settings_page"]),
        addFoodPage: json["add_food_page"] == null ? null : AddFoodPage.fromJson(json["add_food_page"]),
        addMealPage: json["add_meal_page"] == null ? null : AddMealPage.fromJson(json["add_meal_page"]),
        changePasswordPage: json["change_password_page"] == null ? null : ChangePasswordPage.fromJson(json["change_password_page"]),
        dailyJournalPage: json["daily_journal_page"] == null ? null : DailyJournalPage.fromJson(json["daily_journal_page"]),
        deleteAccountDialog: json["delete_account_dialog"] == null ? null : DeleteAccountDialog.fromJson(json["delete_account_dialog"]),
        exercisePage: json["exercise_page"] == null ? null : ExercisePage.fromJson(json["exercise_page"]),
        forgotPasswordPage: json["forgot_password_page"] == null ? null : ForgotPasswordPage.fromJson(json["forgot_password_page"]),
        homePage: json["home_page"] == null ? null : HomePage.fromJson(json["home_page"]),
        landingPage: json["landing_page"] == null ? null : LandingPage.fromJson(json["landing_page"]),
        languagesDialog: json["languages_dialog"] == null ? null : LanguagesDialog.fromJson(json["languages_dialog"]),
        moodPage: json["mood_page"] == null ? null : MoodPage.fromJson(json["mood_page"]),
        myGoalsPage: json["my_goals_page"] == null ? null : MyGoalsPage.fromJson(json["my_goals_page"]),
        nutrientFactPage: json["nutrient_fact_page"] == null ? null : NutrientFactPage.fromJson(json["nutrient_fact_page"]),
        nutriscoreDetailPage: json["nutriscore_detail_page"] == null ? null : NutriscoreDetailPage.fromJson(json["nutriscore_detail_page"]),
        nutritionPage: json["nutrition_page"] == null ? null : NutritionPage.fromJson(json["nutrition_page"]),
        onboardingPage: json["onboarding_page"] == null ? null : OnboardingPage.fromJson(json["onboarding_page"]),
        physicalInformationPage: json["physical_information_page"] == null ? null : PhysicalInformationPage.fromJson(json["physical_information_page"]),
        requestFoodPage: json["request_food_page"] == null ? null : RequestFoodPage.fromJson(json["request_food_page"]),
        requestFoodSuccessPage: json["request_food_success_page"] == null ? null : RequestFoodSuccessPage.fromJson(json["request_food_success_page"]),
        signInPage: json["sign_in_page"] == null ? null : SignInPage.fromJson(json["sign_in_page"]),
        signUpPage: json["sign_up_page"] == null ? null : SignUpPage.fromJson(json["sign_up_page"]),
        sleepPage: json["sleep_page"] == null ? null : SleepPage.fromJson(json["sleep_page"]),
        streakPage: json["streak_page"] == null ? null : StreakPage.fromJson(json["streak_page"]),
        updatePasswordPage: json["update_password_page"] == null ? null : UpdatePasswordPage.fromJson(json["update_password_page"]),
        userDiaryPage: json["user_diary_page"] == null ? null : UserDiaryPage.fromJson(json["user_diary_page"]),
        waterPage: json["water_page"] == null ? null : WaterPage.fromJson(json["water_page"]),
        weightPage: json["weight_page"] == null ? null : WeightPage.fromJson(json["weight_page"]),
        wellnessCalculation: Map.from(json["wellness_calculation"]!).map((k, v) => MapEntry<String, String>(k, v)),
        wellnessScorePage: json["wellness_score_page"] == null ? null : WellnessScorePage.fromJson(json["wellness_score_page"]),
        nutricoPlusBottomSheet: json["nutrico_plus_bottom_sheet"] == null ? null : NutricoPlusBottomSheet.fromJson(json["nutrico_plus_bottom_sheet"]),
        tooltipHomePage: json["tooltip_home_page"] == null ? null : TooltipHomePage.fromJson(json["tooltip_home_page"]),
      );

  Map<String, dynamic> toJson() => {
        "account_page": accountPage?.toJson(),
        "account_settings_page": accountSettingsPage?.toJson(),
        "add_food_page": addFoodPage?.toJson(),
        "add_meal_page": addMealPage?.toJson(),
        "change_password_page": changePasswordPage?.toJson(),
        "daily_journal_page": dailyJournalPage?.toJson(),
        "delete_account_dialog": deleteAccountDialog?.toJson(),
        "exercise_page": exercisePage?.toJson(),
        "forgot_password_page": forgotPasswordPage?.toJson(),
        "home_page": homePage?.toJson(),
        "landing_page": landingPage?.toJson(),
        "languages_dialog": languagesDialog?.toJson(),
        "mood_page": moodPage?.toJson(),
        "my_goals_page": myGoalsPage?.toJson(),
        "nutrient_fact_page": nutrientFactPage?.toJson(),
        "nutriscore_detail_page": nutriscoreDetailPage?.toJson(),
        "nutrition_page": nutritionPage?.toJson(),
        "onboarding_page": onboardingPage?.toJson(),
        "physical_information_page": physicalInformationPage?.toJson(),
        "request_food_page": requestFoodPage?.toJson(),
        "request_food_success_page": requestFoodSuccessPage?.toJson(),
        "sign_in_page": signInPage?.toJson(),
        "sign_up_page": signUpPage?.toJson(),
        "sleep_page": sleepPage?.toJson(),
        "streak_page": streakPage?.toJson(),
        "update_password_page": updatePasswordPage?.toJson(),
        "user_diary_page": userDiaryPage?.toJson(),
        "water_page": waterPage?.toJson(),
        "weight_page": weightPage?.toJson(),
        "wellness_calculation": Map.from(wellnessCalculation!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "wellness_score_page": wellnessScorePage?.toJson(),
        "nutrico_plus_bottom_sheet": nutricoPlusBottomSheet?.toJson(),
        "tooltip_home_page": tooltipHomePage?.toJson(),
      };
}

class AccountPage {
  String? accountSettings;
  String? dailyJournal;
  String? languages;
  String? logout;
  String? myGoals;
  String? physicalInformation;
  String? privacyPolicy;
  String? saveChanges;

  AccountPage({
    this.accountSettings,
    this.dailyJournal,
    this.languages,
    this.logout,
    this.myGoals,
    this.physicalInformation,
    this.privacyPolicy,
    this.saveChanges,
  });

  factory AccountPage.fromJson(Map<String, dynamic> json) => AccountPage(
        accountSettings: json["account_settings"],
        dailyJournal: json["daily_journal"],
        languages: json["languages"],
        logout: json["logout"],
        myGoals: json["my_goals"],
        physicalInformation: json["physical_information"],
        privacyPolicy: json["privacy_policy"],
        saveChanges: json["save_changes"],
      );

  Map<String, dynamic> toJson() => {
        "account_settings": accountSettings,
        "daily_journal": dailyJournal,
        "languages": languages,
        "logout": logout,
        "my_goals": myGoals,
        "physical_information": physicalInformation,
        "privacy_policy": privacyPolicy,
        "save_changes": saveChanges,
      };
}

class AccountSettingsPage {
  String? accountSettings;
  String? changeYourPassword;
  String? changeYourPasswordAnytime;
  String? deleteAccount;
  String? emailAddress;
  String? firstName;
  String? lastName;
  String? personalInformation;
  String? update;

  AccountSettingsPage({
    this.accountSettings,
    this.changeYourPassword,
    this.changeYourPasswordAnytime,
    this.deleteAccount,
    this.emailAddress,
    this.firstName,
    this.lastName,
    this.personalInformation,
    this.update,
  });

  factory AccountSettingsPage.fromJson(Map<String, dynamic> json) => AccountSettingsPage(
        accountSettings: json["account_settings"],
        changeYourPassword: json["change_your_password"],
        changeYourPasswordAnytime: json["change_your_password_anytime"],
        deleteAccount: json["delete_account"],
        emailAddress: json["email_address"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        personalInformation: json["personal_information"],
        update: json["update"],
      );

  Map<String, dynamic> toJson() => {
        "account_settings": accountSettings,
        "change_your_password": changeYourPassword,
        "change_your_password_anytime": changeYourPasswordAnytime,
        "delete_account": deleteAccount,
        "email_address": emailAddress,
        "first_name": firstName,
        "last_name": lastName,
        "personal_information": personalInformation,
        "update": update,
      };
}

class AddFoodPage {
  String? add;
  String? cancel;
  String? numberOfServing;
  String? ofYourGoal;
  String? save;
  String? submit;
  String? time;

  AddFoodPage({
    this.add,
    this.cancel,
    this.numberOfServing,
    this.ofYourGoal,
    this.save,
    this.submit,
    this.time,
  });

  factory AddFoodPage.fromJson(Map<String, dynamic> json) => AddFoodPage(
        add: json["add"],
        cancel: json["cancel"],
        numberOfServing: json["number_of_serving"],
        ofYourGoal: json["of_your_goal"],
        save: json["save"],
        submit: json["submit"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "add": add,
        "cancel": cancel,
        "number_of_serving": numberOfServing,
        "of_your_goal": ofYourGoal,
        "save": save,
        "submit": submit,
        "time": time,
      };
}

class AddMealPage {
  String? amount;
  String? basedOnYourNutritionalNeeds;
  String? done;
  String? filter;
  String? foodRecommendation;
  String? pickedBasedOnYourNutritionalNeed;
  String? resetFilter;
  String? search;
  String? searchHere;
  String? searchResult;
  String? submit;
  String? yourRecommendedFoods;

  AddMealPage({
    this.amount,
    this.basedOnYourNutritionalNeeds,
    this.done,
    this.filter,
    this.foodRecommendation,
    this.pickedBasedOnYourNutritionalNeed,
    this.resetFilter,
    this.search,
    this.searchHere,
    this.searchResult,
    this.submit,
    this.yourRecommendedFoods,
  });

  factory AddMealPage.fromJson(Map<String, dynamic> json) => AddMealPage(
        amount: json["amount"],
        basedOnYourNutritionalNeeds: json["based_on_your_nutritional_needs"],
        done: json["done"],
        filter: json["filter"],
        foodRecommendation: json["food_recommendation"],
        pickedBasedOnYourNutritionalNeed: json["picked_based_on_your_nutritional_need"],
        resetFilter: json["reset_filter"],
        search: json["search"],
        searchHere: json["search_here"],
        searchResult: json["search_result"],
        submit: json["submit"],
        yourRecommendedFoods: json["your_recommended_foods"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "based_on_your_nutritional_needs": basedOnYourNutritionalNeeds,
        "done": done,
        "filter": filter,
        "food_recommendation": foodRecommendation,
        "picked_based_on_your_nutritional_need": pickedBasedOnYourNutritionalNeed,
        "reset_filter": resetFilter,
        "search": search,
        "search_here": searchHere,
        "search_result": searchResult,
        "submit": submit,
        "your_recommended_foods": yourRecommendedFoods,
      };
}

class ChangePasswordPage {
  String? change;
  String? changePassword;
  String? confirmPassword;
  String? enterNewPassword;
  String? enterYourOtp;

  ChangePasswordPage({
    this.change,
    this.changePassword,
    this.confirmPassword,
    this.enterNewPassword,
    this.enterYourOtp,
  });

  factory ChangePasswordPage.fromJson(Map<String, dynamic> json) => ChangePasswordPage(
        change: json["change"],
        changePassword: json["change_password"],
        confirmPassword: json["confirm_password"],
        enterNewPassword: json["enter_new_password"],
        enterYourOtp: json["enter_your_otp"],
      );

  Map<String, dynamic> toJson() => {
        "change": change,
        "change_password": changePassword,
        "confirm_password": confirmPassword,
        "enter_new_password": enterNewPassword,
        "enter_your_otp": enterYourOtp,
      };
}

class DailyJournalPage {
  String? breakfast;
  String? cancel;
  String? dailyJournal;
  String? dinner;
  String? eating;
  String? lunch;
  String? save;
  String? setYourMealTime;
  String? snack;
  String? time;

  DailyJournalPage({
    this.breakfast,
    this.cancel,
    this.dailyJournal,
    this.dinner,
    this.eating,
    this.lunch,
    this.save,
    this.setYourMealTime,
    this.snack,
    this.time,
  });

  factory DailyJournalPage.fromJson(Map<String, dynamic> json) => DailyJournalPage(
        breakfast: json["breakfast"],
        cancel: json["cancel"],
        dailyJournal: json["daily_journal"],
        dinner: json["dinner"],
        eating: json["eating"],
        lunch: json["lunch"],
        save: json["save"],
        setYourMealTime: json["set_your_meal_time"],
        snack: json["snack"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "breakfast": breakfast,
        "cancel": cancel,
        "daily_journal": dailyJournal,
        "dinner": dinner,
        "eating": eating,
        "lunch": lunch,
        "save": save,
        "set_your_meal_time": setYourMealTime,
        "snack": snack,
        "time": time,
      };
}

class DeleteAccountDialog {
  String? cancel;
  String? confirm;
  String? dialogSubtitle;
  String? dialogTitle;

  DeleteAccountDialog({
    this.cancel,
    this.confirm,
    this.dialogSubtitle,
    this.dialogTitle,
  });

  factory DeleteAccountDialog.fromJson(Map<String, dynamic> json) => DeleteAccountDialog(
        cancel: json["cancel"],
        confirm: json["confirm"],
        dialogSubtitle: json["dialog_subtitle"],
        dialogTitle: json["dialog_title"],
      );

  Map<String, dynamic> toJson() => {
        "cancel": cancel,
        "confirm": confirm,
        "dialog_subtitle": dialogSubtitle,
        "dialog_title": dialogTitle,
      };
}

class ExercisePage {
  String? addSteps;
  String? caloriesBurnt;
  String? exercise;
  String? exerciseHabit;
  String? inputSteps;
  String? kcal;
  String? last7Days;
  String? ofYourGoal;
  String? save;
  String? stepCount;
  String? steps;
  String? syncedVia;
  String? youHaveReached;

  ExercisePage({
    this.addSteps,
    this.caloriesBurnt,
    this.exercise,
    this.exerciseHabit,
    this.inputSteps,
    this.kcal,
    this.last7Days,
    this.ofYourGoal,
    this.save,
    this.stepCount,
    this.steps,
    this.syncedVia,
    this.youHaveReached,
  });

  factory ExercisePage.fromJson(Map<String, dynamic> json) => ExercisePage(
        addSteps: json["add_steps"],
        caloriesBurnt: json["calories_burnt"],
        exercise: json["exercise"],
        exerciseHabit: json["exercise_habit"],
        inputSteps: json["input_steps"],
        kcal: json["kcal"],
        last7Days: json["last_7_days"],
        ofYourGoal: json["of_your_goal"],
        save: json["save"],
        stepCount: json["step_count"],
        steps: json["steps"],
        syncedVia: json["synced_via"],
        youHaveReached: json["you_have_reached"],
      );

  Map<String, dynamic> toJson() => {
        "add_steps": addSteps,
        "calories_burnt": caloriesBurnt,
        "exercise": exercise,
        "exercise_habit": exerciseHabit,
        "input_steps": inputSteps,
        "kcal": kcal,
        "last_7_days": last7Days,
        "of_your_goal": ofYourGoal,
        "save": save,
        "step_count": stepCount,
        "steps": steps,
        "synced_via": syncedVia,
        "you_have_reached": youHaveReached,
      };
}

class ForgotPasswordPage {
  String? emailAddress;
  String? forgotPassword;
  String? pleaseEnterEmailToResetPassword;
  String? submit;

  ForgotPasswordPage({
    this.emailAddress,
    this.forgotPassword,
    this.pleaseEnterEmailToResetPassword,
    this.submit,
  });

  factory ForgotPasswordPage.fromJson(Map<String, dynamic> json) => ForgotPasswordPage(
        emailAddress: json["email_address"],
        forgotPassword: json["forgot_password"],
        pleaseEnterEmailToResetPassword: json["please_enter_email_to_reset_password"],
        submit: json["submit"],
      );

  Map<String, dynamic> toJson() => {
        "email_address": emailAddress,
        "forgot_password": forgotPassword,
        "please_enter_email_to_reset_password": pleaseEnterEmailToResetPassword,
        "submit": submit,
      };
}

class HomePage {
  String? account;
  String? calories;
  String? carbs;
  String? dayStreak;
  String? dinnerTask;
  String? exerciseBurnt;
  String? exerciseButton;
  String? fat;
  String? goodAfternoon;
  String? goodEvening;
  String? goodMorning;
  String? hi;
  String? home;
  String? howAreYou;
  String? lunchTask;
  String? mood;
  String? moodButton;
  String? nutricoPlus;
  String? nutritionButton;
  String? protein;
  String? sleep;
  String? sleepButton;
  String? snackTask;
  String? startYourStreak;
  String? taskList;
  String? water;
  String? waterButton;
  String? waterTask;
  String? of;
  String? insights;
  String? next;
  String? prev;
  String? preparingRecommendationForYou;
  String? done;
  String? youreAllSet;
  String? curiousAboutFullPicture;
  String? here;
  String? wellness;
  String? viewInsights;
  String? checkTheAppToSeeWhatYouNeedToImprove;
  String? seeTheAppForAreasToImprove;
  String? greatJobKeepUpTheGoodWork;
  String? exercise;
  String? nutrition;

  HomePage({
    this.account,
    this.calories,
    this.carbs,
    this.dayStreak,
    this.dinnerTask,
    this.exerciseBurnt,
    this.exerciseButton,
    this.fat,
    this.goodAfternoon,
    this.goodEvening,
    this.goodMorning,
    this.hi,
    this.home,
    this.howAreYou,
    this.lunchTask,
    this.mood,
    this.moodButton,
    this.nutricoPlus,
    this.nutritionButton,
    this.protein,
    this.sleep,
    this.sleepButton,
    this.snackTask,
    this.startYourStreak,
    this.taskList,
    this.water,
    this.waterButton,
    this.waterTask,
    this.of,
    this.insights,
    this.next,
    this.prev,
    this.preparingRecommendationForYou,
    this.done,
    this.youreAllSet,
    this.curiousAboutFullPicture,
    this.here,
    this.wellness,
    this.viewInsights,
    this.checkTheAppToSeeWhatYouNeedToImprove,
    this.seeTheAppForAreasToImprove,
    this.greatJobKeepUpTheGoodWork,
    this.exercise,
    this.nutrition,
  });

  factory HomePage.fromJson(Map<String, dynamic> json) => HomePage(
        account: json["account"],
        calories: json["calories"],
        carbs: json["carbs"],
        dayStreak: json["day_streak"],
        dinnerTask: json["dinner_task"],
        exerciseBurnt: json["exercise_burnt"],
        exerciseButton: json["exercise_button"],
        fat: json["fat"],
        goodAfternoon: json["good_afternoon"],
        goodEvening: json["good_evening"],
        goodMorning: json["good_morning"],
        hi: json["hi"],
        home: json["home"],
        howAreYou: json["how_are_you"],
        lunchTask: json["lunch_task"],
        mood: json["mood"],
        moodButton: json["mood_button"],
        nutricoPlus: json["nutrico_plus"],
        nutritionButton: json["nutrition_button"],
        protein: json["protein"],
        sleep: json["sleep"],
        sleepButton: json["sleep_button"],
        snackTask: json["snack_task"],
        startYourStreak: json["start_your_streak"],
        taskList: json["task_list"],
        water: json["water"],
        waterButton: json["water_button"],
        waterTask: json["water_task"],
        of: json["of"],
        insights: json["insights"],
        next: json["next"],
        prev: json["prev"],
        preparingRecommendationForYou: json["preparing_recommendation_for_you"],
        done: json["done"],
        youreAllSet: json["youre_all_set"],
        curiousAboutFullPicture: json["curious_about_full_picture"],
        here: json["here"],
        wellness: json["wellness"],
        viewInsights: json["view_insights"],
        checkTheAppToSeeWhatYouNeedToImprove: json["check_the_app_to_see_what_you_need_to_improve"],
        seeTheAppForAreasToImprove: json["see_the_app_for_areas_to_improve"],
        greatJobKeepUpTheGoodWork: json["great_job_keep_up_the_good_work"],
        exercise: json["exercise"],
        nutrition: json["nutrition"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "calories": calories,
        "carbs": carbs,
        "day_streak": dayStreak,
        "dinner_task": dinnerTask,
        "exercise_burnt": exerciseBurnt,
        "exercise_button": exerciseButton,
        "fat": fat,
        "good_afternoon": goodAfternoon,
        "good_evening": goodEvening,
        "good_morning": goodMorning,
        "hi": hi,
        "home": home,
        "how_are_you": howAreYou,
        "lunch_task": lunchTask,
        "mood": mood,
        "mood_button": moodButton,
        "nutrico_plus": nutricoPlus,
        "nutrition_button": nutritionButton,
        "protein": protein,
        "sleep": sleep,
        "sleep_button": sleepButton,
        "snack_task": snackTask,
        "start_your_streak": startYourStreak,
        "task_list": taskList,
        "water": water,
        "water_button": waterButton,
        "water_task": waterTask,
        "of": of,
        "insights": insights,
        "next": next,
        "prev": prev,
        "preparing_recommendation_for_you": preparingRecommendationForYou,
        "done": done,
        "youre_all_set": youreAllSet,
        "curious_about_full_picture": curiousAboutFullPicture,
        "here": here,
        "wellness": wellness,
        "view_insights": viewInsights,
        "check_the_app_to_see_what_you_need_to_improve": checkTheAppToSeeWhatYouNeedToImprove,
        "see_the_app_for_areas_to_improve": seeTheAppForAreasToImprove,
        "great_job_keep_up_the_good_work": greatJobKeepUpTheGoodWork,
        "exercise": exercise,
        "nutrition": nutrition,
      };
}

class LandingPage {
  String? alreadyHaveAccount;
  String? betterHealthThroughBetterLiving;
  String? getStarted;
  String? signIn;
  String? welcomeToLivewell;

  LandingPage({
    this.alreadyHaveAccount,
    this.betterHealthThroughBetterLiving,
    this.getStarted,
    this.signIn,
    this.welcomeToLivewell,
  });

  factory LandingPage.fromJson(Map<String, dynamic> json) => LandingPage(
        alreadyHaveAccount: json["already_have_account"],
        betterHealthThroughBetterLiving: json["better_health_through_better_living"],
        getStarted: json["get_started"],
        signIn: json["sign_in"],
        welcomeToLivewell: json["welcome_to_livewell"],
      );

  Map<String, dynamic> toJson() => {
        "already_have_account": alreadyHaveAccount,
        "better_health_through_better_living": betterHealthThroughBetterLiving,
        "get_started": getStarted,
        "sign_in": signIn,
        "welcome_to_livewell": welcomeToLivewell,
      };
}

class LanguagesDialog {
  String? english;
  String? indonesian;
  String? saveChanges;

  LanguagesDialog({
    this.english,
    this.indonesian,
    this.saveChanges,
  });

  factory LanguagesDialog.fromJson(Map<String, dynamic> json) => LanguagesDialog(
        english: json["english"],
        indonesian: json["indonesian"],
        saveChanges: json["save_changes"],
      );

  Map<String, dynamic> toJson() => {
        "english": english,
        "indonesian": indonesian,
        "save_changes": saveChanges,
      };
}

class MoodPage {
  String? awful;
  String? bad;
  String? good;
  String? great;
  String? howAreYou;
  String? last14Days;
  String? meh;
  String? moodChart;
  String? moodCount;
  String? moodTracker;

  MoodPage({
    this.awful,
    this.bad,
    this.good,
    this.great,
    this.howAreYou,
    this.last14Days,
    this.meh,
    this.moodChart,
    this.moodCount,
    this.moodTracker,
  });

  factory MoodPage.fromJson(Map<String, dynamic> json) => MoodPage(
        awful: json["awful"],
        bad: json["bad"],
        good: json["good"],
        great: json["great"],
        howAreYou: json["how_are_you"],
        last14Days: json["last_14_days"],
        meh: json["meh"],
        moodChart: json["mood_chart"],
        moodCount: json["mood_count"],
        moodTracker: json["mood_tracker"],
      );

  Map<String, dynamic> toJson() => {
        "awful": awful,
        "bad": bad,
        "good": good,
        "great": great,
        "how_are_you": howAreYou,
        "last_14_days": last14Days,
        "meh": meh,
        "mood_chart": moodChart,
        "mood_count": moodCount,
        "mood_tracker": moodTracker,
      };
}

class MyGoalsPage {
  String? caloriesKcal;
  String? drink;
  String? glass;
  String? goalsSetting;
  String? save;
  String? setYourFitnessGoals;
  String? sleepHours;
  String? specificGoal;
  String? targetWeightKg;

  MyGoalsPage({
    this.caloriesKcal,
    this.drink,
    this.glass,
    this.goalsSetting,
    this.save,
    this.setYourFitnessGoals,
    this.sleepHours,
    this.specificGoal,
    this.targetWeightKg,
  });

  factory MyGoalsPage.fromJson(Map<String, dynamic> json) => MyGoalsPage(
        caloriesKcal: json["calories_kcal"],
        drink: json["drink"],
        glass: json["glass"],
        goalsSetting: json["goals_setting"],
        save: json["save"],
        setYourFitnessGoals: json["set_your_fitness_goals"],
        sleepHours: json["sleep_hours"],
        specificGoal: json["specific_goal"],
        targetWeightKg: json["target_weight_kg"],
      );

  Map<String, dynamic> toJson() => {
        "calories_kcal": caloriesKcal,
        "drink": drink,
        "glass": glass,
        "goals_setting": goalsSetting,
        "save": save,
        "set_your_fitness_goals": setYourFitnessGoals,
        "sleep_hours": sleepHours,
        "specific_goal": specificGoal,
        "target_weight_kg": targetWeightKg,
      };
}

class NutricoPlusBottomSheet {
  String? manualDescribeYourFood;
  String? describeFood;
  String? generateFromImage;
  String? maximumGenerateOf;
  String? imagesPerMonth;
  String? pickFromGallery;
  String? takeAPhoto;
  String? maxRequestReached;

  NutricoPlusBottomSheet({
    this.manualDescribeYourFood,
    this.describeFood,
    this.generateFromImage,
    this.maximumGenerateOf,
    this.imagesPerMonth,
    this.pickFromGallery,
    this.takeAPhoto,
    this.maxRequestReached,
  });

  factory NutricoPlusBottomSheet.fromJson(Map<String, dynamic> json) => NutricoPlusBottomSheet(
        manualDescribeYourFood: json["manual_describe_your_food"],
        describeFood: json["describe_food"],
        generateFromImage: json["generate_from_image"],
        maximumGenerateOf: json["maximum_generate_of"],
        imagesPerMonth: json["images_per_month"],
        pickFromGallery: json["pick_from_gallery"],
        takeAPhoto: json["take_a_photo"],
        maxRequestReached: json["max_request_reached"],
      );

  Map<String, dynamic> toJson() => {
        "manual_describe_your_food": manualDescribeYourFood,
        "describe_food": describeFood,
        "generate_from_image": generateFromImage,
        "maximum_generate_of": maximumGenerateOf,
        "images_per_month": imagesPerMonth,
        "pick_from_gallery": pickFromGallery,
        "take_a_photo": takeAPhoto,
        "max_request_reached": maxRequestReached,
      };
}

class NutrientFactPage {
  String? calcium;
  String? carbs;
  String? cholesterol;
  String? fiber;
  String? iron;
  String? monounsaturated;
  String? nutrientFact;
  String? polyunsaturated;
  String? potassium;
  String? protein;
  String? saturated;
  String? sodium;
  String? sugar;
  String? totalFat;
  String? transFat;
  String? vitaminA;
  String? vitaminC;

  NutrientFactPage({
    this.calcium,
    this.carbs,
    this.cholesterol,
    this.fiber,
    this.iron,
    this.monounsaturated,
    this.nutrientFact,
    this.polyunsaturated,
    this.potassium,
    this.protein,
    this.saturated,
    this.sodium,
    this.sugar,
    this.totalFat,
    this.transFat,
    this.vitaminA,
    this.vitaminC,
  });

  factory NutrientFactPage.fromJson(Map<String, dynamic> json) => NutrientFactPage(
        calcium: json["calcium"],
        carbs: json["carbs"],
        cholesterol: json["cholesterol"],
        fiber: json["fiber"],
        iron: json["iron"],
        monounsaturated: json["monounsaturated"],
        nutrientFact: json["nutrient_fact"],
        polyunsaturated: json["polyunsaturated"],
        potassium: json["potassium"],
        protein: json["protein"],
        saturated: json["saturated"],
        sodium: json["sodium"],
        sugar: json["sugar"],
        totalFat: json["total_fat"],
        transFat: json["trans_fat"],
        vitaminA: json["vitamin_a"],
        vitaminC: json["vitamin_c"],
      );

  Map<String, dynamic> toJson() => {
        "calcium": calcium,
        "carbs": carbs,
        "cholesterol": cholesterol,
        "fiber": fiber,
        "iron": iron,
        "monounsaturated": monounsaturated,
        "nutrient_fact": nutrientFact,
        "polyunsaturated": polyunsaturated,
        "potassium": potassium,
        "protein": protein,
        "saturated": saturated,
        "sodium": sodium,
        "sugar": sugar,
        "total_fat": totalFat,
        "trans_fat": transFat,
        "vitamin_a": vitaminA,
        "vitamin_c": vitaminC,
      };
}

class NutriscoreDetailPage {
  String? belowTarget;
  String? calcium;
  String? carbohydrate;
  String? cholesterol;
  String? disclaimer;
  String? disclaimerDescription;
  String? dontWorryWeCanImproveNutritionTogether;
  String? excellent;
  String? fat;
  String? fiber;
  String? greatJobNutritionOnPoint;
  String? high;
  String? last7Days;
  String? letsMakeTodayCount;
  String? low;
  String? mid;
  String? monounsaturatedFat;
  String? nutriscore;
  String? nutriscoreDetail;
  String? onTrack;
  String? optimal;
  String? polyunsaturatedFat;
  String? potassium;
  String? protein;
  String? saturatedFat;
  String? score;
  String? sodium;
  String? sugar;
  String? todaysAmount;
  String? transFat;
  String? vitaminA;
  String? vitaminC;
  String? water;
  String? weeklyAverage;
  String? yourValue;
  String? youreDoingGreat;

  NutriscoreDetailPage({
    this.belowTarget,
    this.calcium,
    this.carbohydrate,
    this.cholesterol,
    this.disclaimer,
    this.disclaimerDescription,
    this.dontWorryWeCanImproveNutritionTogether,
    this.excellent,
    this.fat,
    this.fiber,
    this.greatJobNutritionOnPoint,
    this.high,
    this.last7Days,
    this.letsMakeTodayCount,
    this.low,
    this.mid,
    this.monounsaturatedFat,
    this.nutriscore,
    this.nutriscoreDetail,
    this.onTrack,
    this.optimal,
    this.polyunsaturatedFat,
    this.potassium,
    this.protein,
    this.saturatedFat,
    this.score,
    this.sodium,
    this.sugar,
    this.todaysAmount,
    this.transFat,
    this.vitaminA,
    this.vitaminC,
    this.water,
    this.weeklyAverage,
    this.yourValue,
    this.youreDoingGreat,
  });

  factory NutriscoreDetailPage.fromJson(Map<String, dynamic> json) => NutriscoreDetailPage(
        belowTarget: json["below_target"],
        calcium: json["calcium"],
        carbohydrate: json["carbohydrate"],
        cholesterol: json["cholesterol"],
        disclaimer: json["disclaimer"],
        disclaimerDescription: json["disclaimer_description"],
        dontWorryWeCanImproveNutritionTogether: json["dont_worry_we_can_improve_nutrition_together"],
        excellent: json["excellent"],
        fat: json["fat"],
        fiber: json["fiber"],
        greatJobNutritionOnPoint: json["great_job_nutrition_on_point"],
        high: json["high"],
        last7Days: json["last_7_days"],
        letsMakeTodayCount: json["lets_make_today_count"],
        low: json["low"],
        mid: json["mid"],
        monounsaturatedFat: json["monounsaturated_fat"],
        nutriscore: json["nutriscore"],
        nutriscoreDetail: json["nutriscore_detail"],
        onTrack: json["on_track"],
        optimal: json["optimal"],
        polyunsaturatedFat: json["polyunsaturated_fat"],
        potassium: json["potassium"],
        protein: json["protein"],
        saturatedFat: json["saturated_fat"],
        score: json["score"],
        sodium: json["sodium"],
        sugar: json["sugar"],
        todaysAmount: json["todays_amount"],
        transFat: json["trans_fat"],
        vitaminA: json["vitamin_a"],
        vitaminC: json["vitamin_c"],
        water: json["water"],
        weeklyAverage: json["weekly_average"],
        yourValue: json["your_value"],
        youreDoingGreat: json["youre_doing_great"],
      );

  Map<String, dynamic> toJson() => {
        "below_target": belowTarget,
        "calcium": calcium,
        "carbohydrate": carbohydrate,
        "cholesterol": cholesterol,
        "disclaimer": disclaimer,
        "disclaimer_description": disclaimerDescription,
        "dont_worry_we_can_improve_nutrition_together": dontWorryWeCanImproveNutritionTogether,
        "excellent": excellent,
        "fat": fat,
        "fiber": fiber,
        "great_job_nutrition_on_point": greatJobNutritionOnPoint,
        "high": high,
        "last_7_days": last7Days,
        "lets_make_today_count": letsMakeTodayCount,
        "low": low,
        "mid": mid,
        "monounsaturated_fat": monounsaturatedFat,
        "nutriscore": nutriscore,
        "nutriscore_detail": nutriscoreDetail,
        "on_track": onTrack,
        "optimal": optimal,
        "polyunsaturated_fat": polyunsaturatedFat,
        "potassium": potassium,
        "protein": protein,
        "saturated_fat": saturatedFat,
        "score": score,
        "sodium": sodium,
        "sugar": sugar,
        "todays_amount": todaysAmount,
        "trans_fat": transFat,
        "vitamin_a": vitaminA,
        "vitamin_c": vitaminC,
        "water": water,
        "weekly_average": weeklyAverage,
        "your_value": yourValue,
        "youre_doing_great": youreDoingGreat,
      };
}

class NutritionPage {
  String? breakfast;
  String? carbs;
  String? dinner;
  String? fat;
  String? lunch;
  String? macroNut;
  String? microNut;
  String? nutriscore;
  String? nutrition;
  String? of;
  String? protein;
  String? seeDetails;
  String? showNutrientFacts;
  String? snack;
  String? todayYouHaveConsumed;
  String? totalCal;

  NutritionPage({
    this.breakfast,
    this.carbs,
    this.dinner,
    this.fat,
    this.lunch,
    this.macroNut,
    this.microNut,
    this.nutriscore,
    this.nutrition,
    this.of,
    this.protein,
    this.seeDetails,
    this.showNutrientFacts,
    this.snack,
    this.todayYouHaveConsumed,
    this.totalCal,
  });

  factory NutritionPage.fromJson(Map<String, dynamic> json) => NutritionPage(
        breakfast: json["breakfast"],
        carbs: json["carbs"],
        dinner: json["dinner"],
        fat: json["fat"],
        lunch: json["lunch"],
        macroNut: json["macro_nut"],
        microNut: json["micro_nut"],
        nutriscore: json["nutriscore"],
        nutrition: json["nutrition"],
        of: json["of"],
        protein: json["protein"],
        seeDetails: json["see_details"],
        showNutrientFacts: json["show_nutrient_facts"],
        snack: json["snack"],
        todayYouHaveConsumed: json["today_you_have_consumed"],
        totalCal: json["total_cal"],
      );

  Map<String, dynamic> toJson() => {
        "breakfast": breakfast,
        "carbs": carbs,
        "dinner": dinner,
        "fat": fat,
        "lunch": lunch,
        "macro_nut": macroNut,
        "micro_nut": microNut,
        "nutriscore": nutriscore,
        "nutrition": nutrition,
        "of": of,
        "protein": protein,
        "see_details": seeDetails,
        "show_nutrient_facts": showNutrientFacts,
        "snack": snack,
        "today_you_have_consumed": todayYouHaveConsumed,
        "total_cal": totalCal,
      };
}

class OnboardingPage {
  String? active;
  String? active400Kcal;
  String? activeDescription;
  String? asYourBodyChangesWithAge;
  String? confirm;
  String? doYouHaveAnyAllergies;
  String? example;
  String? firstName;
  String? firstWhatsYourName;
  String? genderDescription;
  String? getStarted;
  String? healthProfile;
  String? height;
  String? helpUsCalculateYourDailyCalorieNeeds;
  String? itsEssentialForCalculating;
  String? lastName;
  String? letsStartByCompletingYourProfile;
  String? light;
  String? light100Kcal;
  String? lightDescription;
  String? moderate;
  String? moderate250Kcal;
  String? moderateDescription;
  String? next;
  String? personalizedPlanWillBeCraftedBasedOnYourCurrentCondition;
  String? startNow;
  String? submit;
  String? tellUsYourBirthDate;
  String? tellUsYourNameToUnlockPersonalizedExperience;
  String? whatIsYourGender;
  String? whatsYourCurrentWeightHeight;
  String? youCanAnswerNo;
  String? yourCurrentCondition;
  String? yourPersonalizedPlanIsReady;
  String? youreAllSet;

  OnboardingPage({
    this.active,
    this.active400Kcal,
    this.activeDescription,
    this.asYourBodyChangesWithAge,
    this.confirm,
    this.doYouHaveAnyAllergies,
    this.example,
    this.firstName,
    this.firstWhatsYourName,
    this.genderDescription,
    this.getStarted,
    this.healthProfile,
    this.height,
    this.helpUsCalculateYourDailyCalorieNeeds,
    this.itsEssentialForCalculating,
    this.lastName,
    this.letsStartByCompletingYourProfile,
    this.light,
    this.light100Kcal,
    this.lightDescription,
    this.moderate,
    this.moderate250Kcal,
    this.moderateDescription,
    this.next,
    this.personalizedPlanWillBeCraftedBasedOnYourCurrentCondition,
    this.startNow,
    this.submit,
    this.tellUsYourBirthDate,
    this.tellUsYourNameToUnlockPersonalizedExperience,
    this.whatIsYourGender,
    this.whatsYourCurrentWeightHeight,
    this.youCanAnswerNo,
    this.yourCurrentCondition,
    this.yourPersonalizedPlanIsReady,
    this.youreAllSet,
  });

  factory OnboardingPage.fromJson(Map<String, dynamic> json) => OnboardingPage(
        active: json["active"],
        active400Kcal: json["active_400kcal"],
        activeDescription: json["active_description"],
        asYourBodyChangesWithAge: json["as_your_body_changes_with_age"],
        confirm: json["confirm"],
        doYouHaveAnyAllergies: json["do_you_have_any_allergies"],
        example: json["example"],
        firstName: json["first_name"],
        firstWhatsYourName: json["first_whats_your_name"],
        genderDescription: json["gender_description"],
        getStarted: json["get_started"],
        healthProfile: json["health_profile"],
        height: json["height"],
        helpUsCalculateYourDailyCalorieNeeds: json["help_us_calculate_your_daily_calorie_needs"],
        itsEssentialForCalculating: json["its_essential_for_calculating"],
        lastName: json["last_name"],
        letsStartByCompletingYourProfile: json["lets_start_by_completing_your_profile"],
        light: json["light"],
        light100Kcal: json["light_100kcal"],
        lightDescription: json["light_description"],
        moderate: json["moderate"],
        moderate250Kcal: json["moderate_250kcal"],
        moderateDescription: json["moderate_description"],
        next: json["next"],
        personalizedPlanWillBeCraftedBasedOnYourCurrentCondition: json["personalized_plan_will_be_crafted_based_on_your_current_condition"],
        startNow: json["start_now"],
        submit: json["submit"],
        tellUsYourBirthDate: json["tell_us_your_birth_date"],
        tellUsYourNameToUnlockPersonalizedExperience: json["tell_us_your_name_to_unlock_personalized_experience"],
        whatIsYourGender: json["what_is_your_gender"],
        whatsYourCurrentWeightHeight: json["whats_your_current_weight_height"],
        youCanAnswerNo: json["you_can_answer_no"],
        yourCurrentCondition: json["your_current_condition"],
        yourPersonalizedPlanIsReady: json["your_personalized_plan_is_ready"],
        youreAllSet: json["youre_all_set"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "active_400kcal": active400Kcal,
        "active_description": activeDescription,
        "as_your_body_changes_with_age": asYourBodyChangesWithAge,
        "confirm": confirm,
        "do_you_have_any_allergies": doYouHaveAnyAllergies,
        "example": example,
        "first_name": firstName,
        "first_whats_your_name": firstWhatsYourName,
        "gender_description": genderDescription,
        "get_started": getStarted,
        "health_profile": healthProfile,
        "height": height,
        "help_us_calculate_your_daily_calorie_needs": helpUsCalculateYourDailyCalorieNeeds,
        "its_essential_for_calculating": itsEssentialForCalculating,
        "last_name": lastName,
        "lets_start_by_completing_your_profile": letsStartByCompletingYourProfile,
        "light": light,
        "light_100kcal": light100Kcal,
        "light_description": lightDescription,
        "moderate": moderate,
        "moderate_250kcal": moderate250Kcal,
        "moderate_description": moderateDescription,
        "next": next,
        "personalized_plan_will_be_crafted_based_on_your_current_condition": personalizedPlanWillBeCraftedBasedOnYourCurrentCondition,
        "start_now": startNow,
        "submit": submit,
        "tell_us_your_birth_date": tellUsYourBirthDate,
        "tell_us_your_name_to_unlock_personalized_experience": tellUsYourNameToUnlockPersonalizedExperience,
        "what_is_your_gender": whatIsYourGender,
        "whats_your_current_weight_height": whatsYourCurrentWeightHeight,
        "you_can_answer_no": youCanAnswerNo,
        "your_current_condition": yourCurrentCondition,
        "your_personalized_plan_is_ready": yourPersonalizedPlanIsReady,
        "youre_all_set": youreAllSet,
      };
}

class PhysicalInformationPage {
  String? age;
  String? dietaryRestriction;
  String? female;
  String? gender;
  String? heightCm;
  String? male;
  String? physicalInformation;
  String? save;
  String? weightKg;

  PhysicalInformationPage({
    this.age,
    this.dietaryRestriction,
    this.female,
    this.gender,
    this.heightCm,
    this.male,
    this.physicalInformation,
    this.save,
    this.weightKg,
  });

  factory PhysicalInformationPage.fromJson(Map<String, dynamic> json) => PhysicalInformationPage(
        age: json["age"],
        dietaryRestriction: json["dietary_restriction"],
        female: json["female"],
        gender: json["gender"],
        heightCm: json["height_cm"],
        male: json["male"],
        physicalInformation: json["physical_information"],
        save: json["save"],
        weightKg: json["weight_kg"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "dietary_restriction": dietaryRestriction,
        "female": female,
        "gender": gender,
        "height_cm": heightCm,
        "male": male,
        "physical_information": physicalInformation,
        "save": save,
        "weight_kg": weightKg,
      };
}

class RequestFoodPage {
  String? foodName;
  String? requestFood;
  String? submit;

  RequestFoodPage({
    this.foodName,
    this.requestFood,
    this.submit,
  });

  factory RequestFoodPage.fromJson(Map<String, dynamic> json) => RequestFoodPage(
        foodName: json["food_name"],
        requestFood: json["request_food"],
        submit: json["submit"],
      );

  Map<String, dynamic> toJson() => {
        "food_name": foodName,
        "request_food": requestFood,
        "submit": submit,
      };
}

class RequestFoodSuccessPage {
  String? backToDashboard;
  String? foodRequestCompleted;
  String? ourTeamWorkingOnYourRequest;
  String? thankYou;

  RequestFoodSuccessPage({
    this.backToDashboard,
    this.foodRequestCompleted,
    this.ourTeamWorkingOnYourRequest,
    this.thankYou,
  });

  factory RequestFoodSuccessPage.fromJson(Map<String, dynamic> json) => RequestFoodSuccessPage(
        backToDashboard: json["back_to_dashboard"],
        foodRequestCompleted: json["food_request_completed"],
        ourTeamWorkingOnYourRequest: json["our_team_working_on_your_request"],
        thankYou: json["thank_you"],
      );

  Map<String, dynamic> toJson() => {
        "back_to_dashboard": backToDashboard,
        "food_request_completed": foodRequestCompleted,
        "our_team_working_on_your_request": ourTeamWorkingOnYourRequest,
        "thank_you": thankYou,
      };
}

class SignInPage {
  String? and;
  String? bySigningInAgreeToTermsAndConditions;
  String? dontHaveAccount;
  String? emailAddress;
  String? forgotPassword;
  String? orSignInWith;
  String? password;
  String? privacyPolicy;
  String? signIn;
  String? signInButton;
  String? signUp;
  String? termsAndConditions;

  SignInPage({
    this.and,
    this.bySigningInAgreeToTermsAndConditions,
    this.dontHaveAccount,
    this.emailAddress,
    this.forgotPassword,
    this.orSignInWith,
    this.password,
    this.privacyPolicy,
    this.signIn,
    this.signInButton,
    this.signUp,
    this.termsAndConditions,
  });

  factory SignInPage.fromJson(Map<String, dynamic> json) => SignInPage(
        and: json["and"],
        bySigningInAgreeToTermsAndConditions: json["by_signing_in_agree_to_terms_and_conditions"],
        dontHaveAccount: json["dont_have_account"],
        emailAddress: json["email_address"],
        forgotPassword: json["forgot_password"],
        orSignInWith: json["or_sign_in_with"],
        password: json["password"],
        privacyPolicy: json["privacy_policy"],
        signIn: json["sign_in"],
        signInButton: json["sign_in_button"],
        signUp: json["sign_up"],
        termsAndConditions: json["terms_and_conditions"],
      );

  Map<String, dynamic> toJson() => {
        "and": and,
        "by_signing_in_agree_to_terms_and_conditions": bySigningInAgreeToTermsAndConditions,
        "dont_have_account": dontHaveAccount,
        "email_address": emailAddress,
        "forgot_password": forgotPassword,
        "or_sign_in_with": orSignInWith,
        "password": password,
        "privacy_policy": privacyPolicy,
        "sign_in": signIn,
        "sign_in_button": signInButton,
        "sign_up": signUp,
        "terms_and_conditions": termsAndConditions,
      };
}

class SignUpPage {
  String? alreadyHaveAccount;
  String? and;
  String? bySigningUpIAgreeToLivewellS;
  String? confirmPassword;
  String? createNewAccount;
  String? emailAddress;
  String? enterYourDetailsToRegister;
  String? or;
  String? password;
  String? privacyPolicy;
  String? signIn;
  String? signUp;
  String? termsAndConditions;

  SignUpPage({
    this.alreadyHaveAccount,
    this.and,
    this.bySigningUpIAgreeToLivewellS,
    this.confirmPassword,
    this.createNewAccount,
    this.emailAddress,
    this.enterYourDetailsToRegister,
    this.or,
    this.password,
    this.privacyPolicy,
    this.signIn,
    this.signUp,
    this.termsAndConditions,
  });

  factory SignUpPage.fromJson(Map<String, dynamic> json) => SignUpPage(
        alreadyHaveAccount: json["already_have_account"],
        and: json["and"],
        bySigningUpIAgreeToLivewellS: json["by_signing up, I agree to Livewell's "],
        confirmPassword: json["confirm_password"],
        createNewAccount: json["create_new_account"],
        emailAddress: json["email_address"],
        enterYourDetailsToRegister: json["enter_your_details_to_register"],
        or: json["or"],
        password: json["password"],
        privacyPolicy: json["privacy_policy"],
        signIn: json["sign_in"],
        signUp: json["sign_up"],
        termsAndConditions: json["terms_and_conditions"],
      );

  Map<String, dynamic> toJson() => {
        "already_have_account": alreadyHaveAccount,
        "and": and,
        "by_signing up, I agree to Livewell's ": bySigningUpIAgreeToLivewellS,
        "confirm_password": confirmPassword,
        "create_new_account": createNewAccount,
        "email_address": emailAddress,
        "enter_your_details_to_register": enterYourDetailsToRegister,
        "or": or,
        "password": password,
        "privacy_policy": privacyPolicy,
        "sign_in": signIn,
        "sign_up": signUp,
        "terms_and_conditions": termsAndConditions,
      };
}

class SleepPage {
  String? addSleep;
  String? cancel;
  String? dailyBreakdown;
  String? deepSleep;
  String? hrs;
  String? inputSleep;
  String? last7Days;
  String? lightSleep;
  String? ofDailyGoals;
  String? save;
  String? sleep;
  String? startTimeOfSleep;
  String? time;
  String? wakeUpTime;
  String? wentToSleep;
  String? wokeUp;

  SleepPage({
    this.addSleep,
    this.cancel,
    this.dailyBreakdown,
    this.deepSleep,
    this.hrs,
    this.inputSleep,
    this.last7Days,
    this.lightSleep,
    this.ofDailyGoals,
    this.save,
    this.sleep,
    this.startTimeOfSleep,
    this.time,
    this.wakeUpTime,
    this.wentToSleep,
    this.wokeUp,
  });

  factory SleepPage.fromJson(Map<String, dynamic> json) => SleepPage(
        addSleep: json["add_sleep"],
        cancel: json["cancel"],
        dailyBreakdown: json["daily_breakdown"],
        deepSleep: json["deep_sleep"],
        hrs: json["hrs"],
        inputSleep: json["input_sleep"],
        last7Days: json["last_7_days"],
        lightSleep: json["light_sleep"],
        ofDailyGoals: json["of_daily_goals"],
        save: json["save"],
        sleep: json["sleep"],
        startTimeOfSleep: json["start_time_of_sleep"],
        time: json["time"],
        wakeUpTime: json["wake_up_time"],
        wentToSleep: json["went_to_sleep"],
        wokeUp: json["woke_up"],
      );

  Map<String, dynamic> toJson() => {
        "add_sleep": addSleep,
        "cancel": cancel,
        "daily_breakdown": dailyBreakdown,
        "deep_sleep": deepSleep,
        "hrs": hrs,
        "input_sleep": inputSleep,
        "last_7_days": last7Days,
        "light_sleep": lightSleep,
        "of_daily_goals": ofDailyGoals,
        "save": save,
        "sleep": sleep,
        "start_time_of_sleep": startTimeOfSleep,
        "time": time,
        "wake_up_time": wakeUpTime,
        "went_to_sleep": wentToSleep,
        "woke_up": wokeUp,
      };
}

class StreakPage {
  String? activity;
  String? cal;
  String? dayStreak;
  String? hrs;
  String? hydration;
  String? learningDailyKeepsYourStreakUp;
  String? liters;
  String? mood;
  String? nutrition;
  String? sleep;
  String? steps;
  String? streakPage;

  StreakPage({
    this.activity,
    this.cal,
    this.dayStreak,
    this.hrs,
    this.hydration,
    this.learningDailyKeepsYourStreakUp,
    this.liters,
    this.mood,
    this.nutrition,
    this.sleep,
    this.steps,
    this.streakPage,
  });

  factory StreakPage.fromJson(Map<String, dynamic> json) => StreakPage(
        activity: json["activity"],
        cal: json["cal"],
        dayStreak: json["day_streak"],
        hrs: json["hrs"],
        hydration: json["hydration"],
        learningDailyKeepsYourStreakUp: json["learning_daily_keeps_your_streak_up"],
        liters: json["liters"],
        mood: json["mood"],
        nutrition: json["nutrition"],
        sleep: json["sleep"],
        steps: json["steps"],
        streakPage: json["streak_page"],
      );

  Map<String, dynamic> toJson() => {
        "activity": activity,
        "cal": cal,
        "day_streak": dayStreak,
        "hrs": hrs,
        "hydration": hydration,
        "learning_daily_keeps_your_streak_up": learningDailyKeepsYourStreakUp,
        "liters": liters,
        "mood": mood,
        "nutrition": nutrition,
        "sleep": sleep,
        "steps": steps,
        "streak_page": streakPage,
      };
}

class TooltipHomePage {
  String? nutricoPlusTitle;
  String? taskRecommendationTitle;
  String? finishTaskRecommendationTitle;
  String? wellnessScoreTitle;
  String? nutricoPlusDescription;
  String? taskRecommendationDescription;
  String? finishTaskRecommendationDescription;
  String? wellnessScoreDescription;

  TooltipHomePage({
    this.nutricoPlusTitle,
    this.taskRecommendationTitle,
    this.finishTaskRecommendationTitle,
    this.wellnessScoreTitle,
    this.nutricoPlusDescription,
    this.taskRecommendationDescription,
    this.finishTaskRecommendationDescription,
    this.wellnessScoreDescription,
  });

  factory TooltipHomePage.fromJson(Map<String, dynamic> json) => TooltipHomePage(
        nutricoPlusTitle: json["nutrico_plus_title"],
        taskRecommendationTitle: json["task_recommendation_title"],
        finishTaskRecommendationTitle: json["finish_task_recommendation_title"],
        wellnessScoreTitle: json["wellness_score_title"],
        nutricoPlusDescription: json["nutrico_plus_description"],
        taskRecommendationDescription: json["task_recommendation_description"],
        finishTaskRecommendationDescription: json["finish_task_recommendation_description"],
        wellnessScoreDescription: json["wellness_score_description"],
      );

  Map<String, dynamic> toJson() => {
        "nutrico_plus_title": nutricoPlusTitle,
        "task_recommendation_title": taskRecommendationTitle,
        "finish_task_recommendation_title": finishTaskRecommendationTitle,
        "wellness_score_title": wellnessScoreTitle,
        "nutrico_plus_description": nutricoPlusDescription,
        "task_recommendation_description": taskRecommendationDescription,
        "finish_task_recommendation_description": finishTaskRecommendationDescription,
        "wellness_score_description": wellnessScoreDescription,
      };
}

class UpdatePasswordPage {
  String? change;
  String? changePassword;
  String? enterNewPassword;
  String? newPassword;
  String? newPasswordConfirmation;

  UpdatePasswordPage({
    this.change,
    this.changePassword,
    this.enterNewPassword,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  factory UpdatePasswordPage.fromJson(Map<String, dynamic> json) => UpdatePasswordPage(
        change: json["change"],
        changePassword: json["change_password"],
        enterNewPassword: json["enter_new_password"],
        newPassword: json["new_password"],
        newPasswordConfirmation: json["new_password_confirmation"],
      );

  Map<String, dynamic> toJson() => {
        "change": change,
        "change_password": changePassword,
        "enter_new_password": enterNewPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
      };
}

class UserDiaryPage {
  String? breakfast;
  String? caloriesBurnt;
  String? cancel;
  String? diary;
  String? dinner;
  String? done;
  String? exercise;
  String? lunch;
  String? numberOfServing;
  String? nutrition;
  String? sleep;
  String? snack;
  String? steps;
  String? update;

  UserDiaryPage({
    this.breakfast,
    this.caloriesBurnt,
    this.cancel,
    this.diary,
    this.dinner,
    this.done,
    this.exercise,
    this.lunch,
    this.numberOfServing,
    this.nutrition,
    this.sleep,
    this.snack,
    this.steps,
    this.update,
  });

  factory UserDiaryPage.fromJson(Map<String, dynamic> json) => UserDiaryPage(
        breakfast: json["breakfast"],
        caloriesBurnt: json["calories_burnt"],
        cancel: json["cancel"],
        diary: json["diary"],
        dinner: json["dinner"],
        done: json["done"],
        exercise: json["exercise"],
        lunch: json["lunch"],
        numberOfServing: json["number_of_serving"],
        nutrition: json["nutrition"],
        sleep: json["sleep"],
        snack: json["snack"],
        steps: json["steps"],
        update: json["update"],
      );

  Map<String, dynamic> toJson() => {
        "breakfast": breakfast,
        "calories_burnt": caloriesBurnt,
        "cancel": cancel,
        "diary": diary,
        "dinner": dinner,
        "done": done,
        "exercise": exercise,
        "lunch": lunch,
        "number_of_serving": numberOfServing,
        "nutrition": nutrition,
        "sleep": sleep,
        "snack": snack,
        "steps": steps,
        "update": update,
      };
}

class WaterPage {
  String? the100Ml;
  String? the250Ml;
  String? the500Ml;
  String? addDrink;
  String? addWater;
  String? amber;
  String? custom;
  String? darkYellow;
  String? dehydrated;
  String? drinkWaterNow;
  String? fair;
  String? good;
  String? here;
  String? hydration;
  String? hydrationScoreToday;
  String? inputYourWaterIntake;
  String? learnYourUrineColor;
  String? letsHelpYourBodyStayHydrated;
  String? lightDehydrated;
  String? noColor;
  String? normal;
  String? overhydrated;
  String? paleStrawYellow;
  String? pleaseKeepYourWaterIntakeUnder;
  String? pleaseReduceYourWaterIntakeByUpTo;
  String? reduce;
  String? reduceDrink;
  String? reduceWater;
  String? remaining;
  String? seeHowDoHydrationScoreCalculated;
  String? timeToSlowTheFlow;
  String? totalOfWaterYouHaveAlreadyLogged;
  String? translucentYellow;
  String? understandYourHydration;
  String? wantToReduceWaterIntake;
  String? youHitYourGoalToday;
  String? yourHydrationScoreStillEmpty;
  String? youreDoingWellInStayingHydrated;

  WaterPage({
    this.the100Ml,
    this.the250Ml,
    this.the500Ml,
    this.addDrink,
    this.addWater,
    this.amber,
    this.custom,
    this.darkYellow,
    this.dehydrated,
    this.drinkWaterNow,
    this.fair,
    this.good,
    this.here,
    this.hydration,
    this.hydrationScoreToday,
    this.inputYourWaterIntake,
    this.learnYourUrineColor,
    this.letsHelpYourBodyStayHydrated,
    this.lightDehydrated,
    this.noColor,
    this.normal,
    this.overhydrated,
    this.paleStrawYellow,
    this.pleaseKeepYourWaterIntakeUnder,
    this.pleaseReduceYourWaterIntakeByUpTo,
    this.reduce,
    this.reduceDrink,
    this.reduceWater,
    this.remaining,
    this.seeHowDoHydrationScoreCalculated,
    this.timeToSlowTheFlow,
    this.totalOfWaterYouHaveAlreadyLogged,
    this.translucentYellow,
    this.understandYourHydration,
    this.wantToReduceWaterIntake,
    this.youHitYourGoalToday,
    this.yourHydrationScoreStillEmpty,
    this.youreDoingWellInStayingHydrated,
  });

  factory WaterPage.fromJson(Map<String, dynamic> json) => WaterPage(
        the100Ml: json["100ml"],
        the250Ml: json["250ml"],
        the500Ml: json["500ml"],
        addDrink: json["add_drink"],
        addWater: json["add_water"],
        amber: json["amber"],
        custom: json["custom"],
        darkYellow: json["dark_yellow"],
        dehydrated: json["dehydrated"],
        drinkWaterNow: json["drink_water_now"],
        fair: json["fair"],
        good: json["good"],
        here: json["here"],
        hydration: json["hydration"],
        hydrationScoreToday: json["hydration_score_today"],
        inputYourWaterIntake: json["input_your_water_intake"],
        learnYourUrineColor: json["learn_your_urine_color"],
        letsHelpYourBodyStayHydrated: json["lets_help_your_body_stay_hydrated"],
        lightDehydrated: json["light_dehydrated"],
        noColor: json["no_color"],
        normal: json["normal"],
        overhydrated: json["overhydrated"],
        paleStrawYellow: json["pale_straw_yellow"],
        pleaseKeepYourWaterIntakeUnder: json["please_keep_your_water_intake_under"],
        pleaseReduceYourWaterIntakeByUpTo: json["please_reduce_your_water_intake_by_up_to"],
        reduce: json["reduce"],
        reduceDrink: json["reduce_drink"],
        reduceWater: json["reduce_water"],
        remaining: json["remaining"],
        seeHowDoHydrationScoreCalculated: json["see_how_do_hydration_score_calculated"],
        timeToSlowTheFlow: json["time_to_slow_the_flow"],
        totalOfWaterYouHaveAlreadyLogged: json["total_of_water_you_have_already_logged"],
        translucentYellow: json["translucent_yellow"],
        understandYourHydration: json["understand_your_hydration"],
        wantToReduceWaterIntake: json["want_to_reduce_water_intake"],
        youHitYourGoalToday: json["you_hit_your_goal_today"],
        yourHydrationScoreStillEmpty: json["your_hydration_score_still_empty"],
        youreDoingWellInStayingHydrated: json["youre_doing_well_in_staying_hydrated"],
      );

  Map<String, dynamic> toJson() => {
        "100ml": the100Ml,
        "250ml": the250Ml,
        "500ml": the500Ml,
        "add_drink": addDrink,
        "add_water": addWater,
        "amber": amber,
        "custom": custom,
        "dark_yellow": darkYellow,
        "dehydrated": dehydrated,
        "drink_water_now": drinkWaterNow,
        "fair": fair,
        "good": good,
        "here": here,
        "hydration": hydration,
        "hydration_score_today": hydrationScoreToday,
        "input_your_water_intake": inputYourWaterIntake,
        "learn_your_urine_color": learnYourUrineColor,
        "lets_help_your_body_stay_hydrated": letsHelpYourBodyStayHydrated,
        "light_dehydrated": lightDehydrated,
        "no_color": noColor,
        "normal": normal,
        "overhydrated": overhydrated,
        "pale_straw_yellow": paleStrawYellow,
        "please_keep_your_water_intake_under": pleaseKeepYourWaterIntakeUnder,
        "please_reduce_your_water_intake_by_up_to": pleaseReduceYourWaterIntakeByUpTo,
        "reduce": reduce,
        "reduce_drink": reduceDrink,
        "reduce_water": reduceWater,
        "remaining": remaining,
        "see_how_do_hydration_score_calculated": seeHowDoHydrationScoreCalculated,
        "time_to_slow_the_flow": timeToSlowTheFlow,
        "total_of_water_you_have_already_logged": totalOfWaterYouHaveAlreadyLogged,
        "translucent_yellow": translucentYellow,
        "understand_your_hydration": understandYourHydration,
        "want_to_reduce_water_intake": wantToReduceWaterIntake,
        "you_hit_your_goal_today": youHitYourGoalToday,
        "your_hydration_score_still_empty": yourHydrationScoreStillEmpty,
        "youre_doing_well_in_staying_hydrated": youreDoingWellInStayingHydrated,
      };
}

class WeightPage {
  String? caloriesIntake;
  String? disclaimer;
  String? disclaimerDescription;
  String? goal;
  String? goalSettingUpdate;
  String? goalsSetting;
  String? last7Days;
  String? projectedWeightAfter4Weeks;
  String? update;
  String? updateYourCurrentGoalSetting;
  String? updateYourCurrentWeight;
  String? updateYourWeight;
  String? weight;
  String? weightProgress;
  String? weightUpdate;
  String? whatsYourGoal;
  String? whatsYourWeight;
  String? youHaveGained;
  String? youHaveLost;
  String? youreDoingGreatKeepYourSpiritUp;

  WeightPage({
    this.caloriesIntake,
    this.disclaimer,
    this.disclaimerDescription,
    this.goal,
    this.goalSettingUpdate,
    this.goalsSetting,
    this.last7Days,
    this.projectedWeightAfter4Weeks,
    this.update,
    this.updateYourCurrentGoalSetting,
    this.updateYourCurrentWeight,
    this.updateYourWeight,
    this.weight,
    this.weightProgress,
    this.weightUpdate,
    this.whatsYourGoal,
    this.whatsYourWeight,
    this.youHaveGained,
    this.youHaveLost,
    this.youreDoingGreatKeepYourSpiritUp,
  });

  factory WeightPage.fromJson(Map<String, dynamic> json) => WeightPage(
        caloriesIntake: json["calories_intake"],
        disclaimer: json["disclaimer"],
        disclaimerDescription: json["disclaimer_description"],
        goal: json["goal"],
        goalSettingUpdate: json["goal_setting_update"],
        goalsSetting: json["goals_setting"],
        last7Days: json["last_7_days"],
        projectedWeightAfter4Weeks: json["projected_weight_after_4_weeks"],
        update: json["update"],
        updateYourCurrentGoalSetting: json["update_your_current_goal_setting"],
        updateYourCurrentWeight: json["update_your_current_weight"],
        updateYourWeight: json["update_your_weight"],
        weight: json["weight"],
        weightProgress: json["weight_progress"],
        weightUpdate: json["weight_update"],
        whatsYourGoal: json["whats_your_goal"],
        whatsYourWeight: json["whats_your_weight"],
        youHaveGained: json["you_have_gained"],
        youHaveLost: json["you_have_lost"],
        youreDoingGreatKeepYourSpiritUp: json["youre_doing_great_keep_your_spirit_up"],
      );

  Map<String, dynamic> toJson() => {
        "calories_intake": caloriesIntake,
        "disclaimer": disclaimer,
        "disclaimer_description": disclaimerDescription,
        "goal": goal,
        "goal_setting_update": goalSettingUpdate,
        "goals_setting": goalsSetting,
        "last_7_days": last7Days,
        "projected_weight_after_4_weeks": projectedWeightAfter4Weeks,
        "update": update,
        "update_your_current_goal_setting": updateYourCurrentGoalSetting,
        "update_your_current_weight": updateYourCurrentWeight,
        "update_your_weight": updateYourWeight,
        "weight": weight,
        "weight_progress": weightProgress,
        "weight_update": weightUpdate,
        "whats_your_goal": whatsYourGoal,
        "whats_your_weight": whatsYourWeight,
        "you_have_gained": youHaveGained,
        "you_have_lost": youHaveLost,
        "youre_doing_great_keep_your_spirit_up": youreDoingGreatKeepYourSpiritUp,
      };
}

class WellnessScorePage {
  String? balanced;
  String? balancedDescription;
  String? checkTheAppToSeeWhatYouNeedToImprove;
  String? excellent;
  String? excellentDescription;
  String? exercise;
  String? high;
  String? learnMore;
  String? low;
  String? mood;
  String? needImprovement;
  String? needImprovementDescription;
  String? nutrition;
  String? optimal;
  String? reccomendationForYou;
  String? seeHowDoWellnessScoreCalculated;
  String? showMore;
  String? sleep;
  String? trackYourDailyTaskToSeeYourWellness;
  String? unlockYourWellnessScoreToday;
  String? water;
  String? wellness;
  String? wellnessScore;
  String? yourWellnessProfileToday;

  WellnessScorePage({
    this.balanced,
    this.balancedDescription,
    this.checkTheAppToSeeWhatYouNeedToImprove,
    this.excellent,
    this.excellentDescription,
    this.exercise,
    this.high,
    this.learnMore,
    this.low,
    this.mood,
    this.needImprovement,
    this.needImprovementDescription,
    this.nutrition,
    this.optimal,
    this.reccomendationForYou,
    this.seeHowDoWellnessScoreCalculated,
    this.showMore,
    this.sleep,
    this.trackYourDailyTaskToSeeYourWellness,
    this.unlockYourWellnessScoreToday,
    this.water,
    this.wellness,
    this.wellnessScore,
    this.yourWellnessProfileToday,
  });

  factory WellnessScorePage.fromJson(Map<String, dynamic> json) => WellnessScorePage(
        balanced: json["balanced"],
        balancedDescription: json["balanced_description"],
        checkTheAppToSeeWhatYouNeedToImprove: json["check_the_app_to_see_what_you_need_to_improve"],
        excellent: json["excellent"],
        excellentDescription: json["excellent_description"],
        exercise: json["exercise"],
        high: json["high"],
        learnMore: json["learn_more"],
        low: json["low"],
        mood: json["mood"],
        needImprovement: json["need_improvement"],
        needImprovementDescription: json["need_improvement_description"],
        nutrition: json["nutrition"],
        optimal: json["optimal"],
        reccomendationForYou: json["reccomendation_for_you"],
        seeHowDoWellnessScoreCalculated: json["see_how_do_wellness_score_calculated"],
        showMore: json["show_more"],
        sleep: json["sleep"],
        trackYourDailyTaskToSeeYourWellness: json["track_your_daily_task_to_see_your_wellness"],
        unlockYourWellnessScoreToday: json["unlock_your_wellness_score_today"],
        water: json["water"],
        wellness: json["wellness"],
        wellnessScore: json["wellness_score"],
        yourWellnessProfileToday: json["your_wellness_profile_today"],
      );

  Map<String, dynamic> toJson() => {
        "balanced": balanced,
        "balanced_description": balancedDescription,
        "check_the_app_to_see_what_you_need_to_improve": checkTheAppToSeeWhatYouNeedToImprove,
        "excellent": excellent,
        "excellent_description": excellentDescription,
        "exercise": exercise,
        "high": high,
        "learn_more": learnMore,
        "low": low,
        "mood": mood,
        "need_improvement": needImprovement,
        "need_improvement_description": needImprovementDescription,
        "nutrition": nutrition,
        "optimal": optimal,
        "reccomendation_for_you": reccomendationForYou,
        "see_how_do_wellness_score_calculated": seeHowDoWellnessScoreCalculated,
        "show_more": showMore,
        "sleep": sleep,
        "track_your_daily_task_to_see_your_wellness": trackYourDailyTaskToSeeYourWellness,
        "unlock_your_wellness_score_today": unlockYourWellnessScoreToday,
        "water": water,
        "wellness": wellness,
        "wellness_score": wellnessScore,
        "your_wellness_profile_today": yourWellnessProfileToday,
      };
}
