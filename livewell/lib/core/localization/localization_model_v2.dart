// To parse this JSON data, do
//
//     final localizationModelV2 = localizationModelV2FromJson(jsonString);

import 'dart:convert';

LocalizationModelV2 localizationModelV2FromJson(String str) => LocalizationModelV2.fromJson(json.decode(str));

String localizationModelV2ToJson(LocalizationModelV2 data) => json.encode(data.toJson());

class LocalizationModelV2 {
  EnUs? enUs;
  EnUs? idId;

  LocalizationModelV2({
    this.enUs,
    this.idId,
  });

  factory LocalizationModelV2.fromJson(Map<String, dynamic> json) => LocalizationModelV2(
        enUs: json["en_US"] == null ? null : EnUs.fromJson(json["en_US"]),
        idId: json["id_ID"] == null ? null : EnUs.fromJson(json["id_ID"]),
      );

  Map<String, dynamic> toJson() => {
        "en_US": enUs?.toJson(),
        "id_ID": idId?.toJson(),
      };
}

class EnUs {
  HomePage? homePage;
  LandingPage? landingPage;
  SignUpPage? signUpPage;
  SignInPage? signInPage;
  ForgotPasswordPage? forgotPasswordPage;
  AccountPage? accountPage;
  AccountSettingsPage? accountSettingsPage;
  ChangePasswordPage? changePasswordPage;
  DeleteAccountDialog? deleteAccountDialog;
  DailyJournalPage? dailyJournalPage;
  PhysicalInformationPage? physicalInformationPage;
  MyGoalsPage? myGoalsPage;
  LanguagesDialog? languagesDialog;
  WaterPage? waterPage;
  MoodPage? moodPage;
  ExercisePage? exercisePage;
  SleepPage? sleepPage;
  NutritionPage? nutritionPage;
  WellnessScorePage? wellnessScorePage;
  WeightPage? weightPage;
  NutriscoreDetailPage? nutriscoreDetailPage;
  StreakPage? streakPage;
  OnboardingPage? onboardingPage;
  Map<String, String>? wellnessCalculation;

  EnUs({
    this.homePage,
    this.landingPage,
    this.signUpPage,
    this.signInPage,
    this.forgotPasswordPage,
    this.accountPage,
    this.accountSettingsPage,
    this.changePasswordPage,
    this.deleteAccountDialog,
    this.dailyJournalPage,
    this.physicalInformationPage,
    this.myGoalsPage,
    this.languagesDialog,
    this.waterPage,
    this.moodPage,
    this.exercisePage,
    this.sleepPage,
    this.nutritionPage,
    this.wellnessScorePage,
    this.weightPage,
    this.nutriscoreDetailPage,
    this.streakPage,
    this.onboardingPage,
    this.wellnessCalculation,
  });

  factory EnUs.fromJson(Map<String, dynamic> json) => EnUs(
        homePage: json["home_page"] == null ? null : HomePage.fromJson(json["home_page"]),
        landingPage: json["landing_page"] == null ? null : LandingPage.fromJson(json["landing_page"]),
        signUpPage: json["sign_up_page"] == null ? null : SignUpPage.fromJson(json["sign_up_page"]),
        signInPage: json["sign_in_page"] == null ? null : SignInPage.fromJson(json["sign_in_page"]),
        forgotPasswordPage: json["forgot_password_page"] == null ? null : ForgotPasswordPage.fromJson(json["forgot_password_page"]),
        accountPage: json["account_page"] == null ? null : AccountPage.fromJson(json["account_page"]),
        accountSettingsPage: json["account_settings_page"] == null ? null : AccountSettingsPage.fromJson(json["account_settings_page"]),
        changePasswordPage: json["change_password_page"] == null ? null : ChangePasswordPage.fromJson(json["change_password_page"]),
        deleteAccountDialog: json["delete_account_dialog"] == null ? null : DeleteAccountDialog.fromJson(json["delete_account_dialog"]),
        dailyJournalPage: json["daily_journal_page"] == null ? null : DailyJournalPage.fromJson(json["daily_journal_page"]),
        physicalInformationPage: json["physical_information_page"] == null ? null : PhysicalInformationPage.fromJson(json["physical_information_page"]),
        myGoalsPage: json["my_goals_page"] == null ? null : MyGoalsPage.fromJson(json["my_goals_page"]),
        languagesDialog: json["languages_dialog"] == null ? null : LanguagesDialog.fromJson(json["languages_dialog"]),
        waterPage: json["water_page"] == null ? null : WaterPage.fromJson(json["water_page"]),
        moodPage: json["mood_page"] == null ? null : MoodPage.fromJson(json["mood_page"]),
        exercisePage: json["exercise_page"] == null ? null : ExercisePage.fromJson(json["exercise_page"]),
        sleepPage: json["sleep_page"] == null ? null : SleepPage.fromJson(json["sleep_page"]),
        nutritionPage: json["nutrition_page"] == null ? null : NutritionPage.fromJson(json["nutrition_page"]),
        wellnessScorePage: json["wellness_score_page"] == null ? null : WellnessScorePage.fromJson(json["wellness_score_page"]),
        weightPage: json["weight_page"] == null ? null : WeightPage.fromJson(json["weight_page"]),
        nutriscoreDetailPage: json["nutriscore_detail_page"] == null ? null : NutriscoreDetailPage.fromJson(json["nutriscore_detail_page"]),
        streakPage: json["streak_page"] == null ? null : StreakPage.fromJson(json["streak_page"]),
        onboardingPage: json["onboarding_page"] == null ? null : OnboardingPage.fromJson(json["onboarding_page"]),
        wellnessCalculation: Map.from(json["wellness_calculation"]!).map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "home_page": homePage?.toJson(),
        "landing_page": landingPage?.toJson(),
        "sign_up_page": signUpPage?.toJson(),
        "sign_in_page": signInPage?.toJson(),
        "forgot_password_page": forgotPasswordPage?.toJson(),
        "account_page": accountPage?.toJson(),
        "account_settings_page": accountSettingsPage?.toJson(),
        "change_password_page": changePasswordPage?.toJson(),
        "delete_account_dialog": deleteAccountDialog?.toJson(),
        "daily_journal_page": dailyJournalPage?.toJson(),
        "physical_information_page": physicalInformationPage?.toJson(),
        "my_goals_page": myGoalsPage?.toJson(),
        "languages_dialog": languagesDialog?.toJson(),
        "water_page": waterPage?.toJson(),
        "mood_page": moodPage?.toJson(),
        "exercise_page": exercisePage?.toJson(),
        "sleep_page": sleepPage?.toJson(),
        "nutrition_page": nutritionPage?.toJson(),
        "wellness_score_page": wellnessScorePage?.toJson(),
        "weight_page": weightPage?.toJson(),
        "nutriscore_detail_page": nutriscoreDetailPage?.toJson(),
        "streak_page": streakPage?.toJson(),
        "onboarding_page": onboardingPage?.toJson(),
        "wellness_calculation": Map.from(wellnessCalculation!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class AccountPage {
  String? accountSettings;
  String? dailyJournal;
  String? physicalInformation;
  String? myGoals;
  String? languages;
  String? privacyPolicy;
  String? logout;

  AccountPage({
    this.accountSettings,
    this.dailyJournal,
    this.physicalInformation,
    this.myGoals,
    this.languages,
    this.privacyPolicy,
    this.logout,
  });

  factory AccountPage.fromJson(Map<String, dynamic> json) => AccountPage(
        accountSettings: json["account_settings"],
        dailyJournal: json["daily_journal"],
        physicalInformation: json["physical_information"],
        myGoals: json["my_goals"],
        languages: json["languages"],
        privacyPolicy: json["privacy_policy"],
        logout: json["logout"],
      );

  Map<String, dynamic> toJson() => {
        "account_settings": accountSettings,
        "daily_journal": dailyJournal,
        "physical_information": physicalInformation,
        "my_goals": myGoals,
        "languages": languages,
        "privacy_policy": privacyPolicy,
        "logout": logout,
      };
}

class AccountSettingsPage {
  String? accountSettings;
  String? personalInformation;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? changeYourPassword;
  String? changeYourPasswordAnytime;
  String? deleteAccount;
  String? update;

  AccountSettingsPage({
    this.accountSettings,
    this.personalInformation,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.changeYourPassword,
    this.changeYourPasswordAnytime,
    this.deleteAccount,
    this.update,
  });

  factory AccountSettingsPage.fromJson(Map<String, dynamic> json) => AccountSettingsPage(
        accountSettings: json["account_settings"],
        personalInformation: json["personal_information"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailAddress: json["email_address"],
        changeYourPassword: json["change_your_password"],
        changeYourPasswordAnytime: json["change_your_password_anytime"],
        deleteAccount: json["delete_account"],
        update: json["update"],
      );

  Map<String, dynamic> toJson() => {
        "account_settings": accountSettings,
        "personal_information": personalInformation,
        "first_name": firstName,
        "last_name": lastName,
        "email_address": emailAddress,
        "change_your_password": changeYourPassword,
        "change_your_password_anytime": changeYourPasswordAnytime,
        "delete_account": deleteAccount,
        "update": update,
      };
}

class ChangePasswordPage {
  String? changePassword;
  String? enterNewPassword;
  String? newPassword;
  String? newPasswordConfirmation;
  String? change;

  ChangePasswordPage({
    this.changePassword,
    this.enterNewPassword,
    this.newPassword,
    this.newPasswordConfirmation,
    this.change,
  });

  factory ChangePasswordPage.fromJson(Map<String, dynamic> json) => ChangePasswordPage(
        changePassword: json["change_password"],
        enterNewPassword: json["enter_new_password"],
        newPassword: json["new_password"],
        newPasswordConfirmation: json["new_password_confirmation"],
        change: json["change"],
      );

  Map<String, dynamic> toJson() => {
        "change_password": changePassword,
        "enter_new_password": enterNewPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
        "change": change,
      };
}

class DailyJournalPage {
  String? dailyJournal;
  String? eating;
  String? setYourMealTime;
  String? breakfast;
  String? lunch;
  String? snack;
  String? dinner;

  DailyJournalPage({
    this.dailyJournal,
    this.eating,
    this.setYourMealTime,
    this.breakfast,
    this.lunch,
    this.snack,
    this.dinner,
  });

  factory DailyJournalPage.fromJson(Map<String, dynamic> json) => DailyJournalPage(
        dailyJournal: json["daily_journal"],
        eating: json["eating"],
        setYourMealTime: json["set_your_meal_time"],
        breakfast: json["breakfast"],
        lunch: json["lunch"],
        snack: json["snack"],
        dinner: json["dinner"],
      );

  Map<String, dynamic> toJson() => {
        "daily_journal": dailyJournal,
        "eating": eating,
        "set_your_meal_time": setYourMealTime,
        "breakfast": breakfast,
        "lunch": lunch,
        "snack": snack,
        "dinner": dinner,
      };
}

class DeleteAccountDialog {
  String? dialogTitle;
  String? dialogSubtitle;
  String? cancel;
  String? confirm;

  DeleteAccountDialog({
    this.dialogTitle,
    this.dialogSubtitle,
    this.cancel,
    this.confirm,
  });

  factory DeleteAccountDialog.fromJson(Map<String, dynamic> json) => DeleteAccountDialog(
        dialogTitle: json["dialog_title"],
        dialogSubtitle: json["dialog_subtitle"],
        cancel: json["cancel"],
        confirm: json["confirm"],
      );

  Map<String, dynamic> toJson() => {
        "dialog_title": dialogTitle,
        "dialog_subtitle": dialogSubtitle,
        "cancel": cancel,
        "confirm": confirm,
      };
}

class ExercisePage {
  String? exercise;
  String? youHaveReached;
  String? ofYourGoal;
  String? caloriesBurnt;
  String? steps;
  String? syncedVia;
  String? inputSteps;
  String? exerciseHabit;
  String? last7Days;
  String? kcal;
  String? addSteps;
  String? stepCount;
  String? save;

  ExercisePage({
    this.exercise,
    this.youHaveReached,
    this.ofYourGoal,
    this.caloriesBurnt,
    this.steps,
    this.syncedVia,
    this.inputSteps,
    this.exerciseHabit,
    this.last7Days,
    this.kcal,
    this.addSteps,
    this.stepCount,
    this.save,
  });

  factory ExercisePage.fromJson(Map<String, dynamic> json) => ExercisePage(
        exercise: json["exercise"],
        youHaveReached: json["you_have_reached"],
        ofYourGoal: json["of_your_goal"],
        caloriesBurnt: json["calories_burnt"],
        steps: json["steps"],
        syncedVia: json["synced_via"],
        inputSteps: json["input_steps"],
        exerciseHabit: json["exercise_habit"],
        last7Days: json["last_7_days"],
        kcal: json["kcal"],
        addSteps: json["add_steps"],
        stepCount: json["step_count"],
        save: json["save"],
      );

  Map<String, dynamic> toJson() => {
        "exercise": exercise,
        "you_have_reached": youHaveReached,
        "of_your_goal": ofYourGoal,
        "calories_burnt": caloriesBurnt,
        "steps": steps,
        "synced_via": syncedVia,
        "input_steps": inputSteps,
        "exercise_habit": exerciseHabit,
        "last_7_days": last7Days,
        "kcal": kcal,
        "add_steps": addSteps,
        "step_count": stepCount,
        "save": save,
      };
}

class ForgotPasswordPage {
  String? forgotPassword;
  String? pleaseEnterEmailToResetPassword;
  String? emailAddress;
  String? submit;

  ForgotPasswordPage({
    this.forgotPassword,
    this.pleaseEnterEmailToResetPassword,
    this.emailAddress,
    this.submit,
  });

  factory ForgotPasswordPage.fromJson(Map<String, dynamic> json) => ForgotPasswordPage(
        forgotPassword: json["forgot_password"],
        pleaseEnterEmailToResetPassword: json["please_enter_email_to_reset_password"],
        emailAddress: json["email_address"],
        submit: json["submit"],
      );

  Map<String, dynamic> toJson() => {
        "forgot_password": forgotPassword,
        "please_enter_email_to_reset_password": pleaseEnterEmailToResetPassword,
        "email_address": emailAddress,
        "submit": submit,
      };
}

class HomePage {
  String? hi;
  String? startYourStreak;
  String? dayStreak;
  String? calories;
  String? exerciseBurnt;
  String? carbs;
  String? sleep;
  String? protein;
  String? water;
  String? fat;
  String? mood;
  String? nutritionButton;
  String? exerciseButton;
  String? sleepButton;
  String? waterButton;
  String? moodButton;
  String? taskList;
  String? howAreYou;
  String? waterTask;
  String? lunchTask;
  String? snackTask;
  String? dinnerTask;
  String? home;
  String? nutricoPlus;
  String? account;
  String? goodMorning;
  String? goodAfternoon;
  String? goodEvening;

  HomePage({
    this.hi,
    this.startYourStreak,
    this.dayStreak,
    this.calories,
    this.exerciseBurnt,
    this.carbs,
    this.sleep,
    this.protein,
    this.water,
    this.fat,
    this.mood,
    this.nutritionButton,
    this.exerciseButton,
    this.sleepButton,
    this.waterButton,
    this.moodButton,
    this.taskList,
    this.howAreYou,
    this.waterTask,
    this.lunchTask,
    this.snackTask,
    this.dinnerTask,
    this.home,
    this.nutricoPlus,
    this.account,
    this.goodMorning,
    this.goodAfternoon,
    this.goodEvening,
  });

  factory HomePage.fromJson(Map<String, dynamic> json) => HomePage(
        hi: json["hi"],
        startYourStreak: json["start_your_streak"],
        dayStreak: json["day_streak"],
        calories: json["calories"],
        exerciseBurnt: json["exercise_burnt"],
        carbs: json["carbs"],
        sleep: json["sleep"],
        protein: json["protein"],
        water: json["water"],
        fat: json["fat"],
        mood: json["mood"],
        nutritionButton: json["nutrition_button"],
        exerciseButton: json["exercise_button"],
        sleepButton: json["sleep_button"],
        waterButton: json["water_button"],
        moodButton: json["mood_button"],
        taskList: json["task_list"],
        howAreYou: json["how_are_you"],
        waterTask: json["water_task"],
        lunchTask: json["lunch_task"],
        snackTask: json["snack_task"],
        dinnerTask: json["dinner_task"],
        home: json["home"],
        nutricoPlus: json["nutrico_plus"],
        account: json["account"],
        goodMorning: json["good_morning"],
        goodAfternoon: json["good_afternoon"],
        goodEvening: json["good_evening"],
      );

  Map<String, dynamic> toJson() => {
        "hi": hi,
        "start_your_streak": startYourStreak,
        "day_streak": dayStreak,
        "calories": calories,
        "exercise_burnt": exerciseBurnt,
        "carbs": carbs,
        "sleep": sleep,
        "protein": protein,
        "water": water,
        "fat": fat,
        "mood": mood,
        "nutrition_button": nutritionButton,
        "exercise_button": exerciseButton,
        "sleep_button": sleepButton,
        "water_button": waterButton,
        "mood_button": moodButton,
        "task_list": taskList,
        "how_are_you": howAreYou,
        "water_task": waterTask,
        "lunch_task": lunchTask,
        "snack_task": snackTask,
        "dinner_task": dinnerTask,
        "home": home,
        "nutrico_plus": nutricoPlus,
        "account": account,
        "good_morning": goodMorning,
        "good_afternoon": goodAfternoon,
        "good_evening": goodEvening,
      };
}

class LandingPage {
  String? welcomeToLivewell;
  String? betterHealthThroughBetterLiving;
  String? getStarted;
  String? alreadyHaveAccount;
  String? signIn;

  LandingPage({
    this.welcomeToLivewell,
    this.betterHealthThroughBetterLiving,
    this.getStarted,
    this.alreadyHaveAccount,
    this.signIn,
  });

  factory LandingPage.fromJson(Map<String, dynamic> json) => LandingPage(
        welcomeToLivewell: json["welcome_to_livewell"],
        betterHealthThroughBetterLiving: json["better_health_through_better_living"],
        getStarted: json["get_started"],
        alreadyHaveAccount: json["already_have_account"],
        signIn: json["sign_in"],
      );

  Map<String, dynamic> toJson() => {
        "welcome_to_livewell": welcomeToLivewell,
        "better_health_through_better_living": betterHealthThroughBetterLiving,
        "get_started": getStarted,
        "already_have_account": alreadyHaveAccount,
        "sign_in": signIn,
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
  String? moodTracker;
  String? last14Days;
  String? moodCount;
  String? great;
  String? good;
  String? meh;
  String? bad;
  String? awful;

  MoodPage({
    this.moodTracker,
    this.last14Days,
    this.moodCount,
    this.great,
    this.good,
    this.meh,
    this.bad,
    this.awful,
  });

  factory MoodPage.fromJson(Map<String, dynamic> json) => MoodPage(
        moodTracker: json["mood_tracker"],
        last14Days: json["last_14_days"],
        moodCount: json["mood_count"],
        great: json["great"],
        good: json["good"],
        meh: json["meh"],
        bad: json["bad"],
        awful: json["awful"],
      );

  Map<String, dynamic> toJson() => {
        "mood_tracker": moodTracker,
        "last_14_days": last14Days,
        "mood_count": moodCount,
        "great": great,
        "good": good,
        "meh": meh,
        "bad": bad,
        "awful": awful,
      };
}

class MyGoalsPage {
  String? goalsSetting;
  String? targetWeightKg;
  String? drink;
  String? glass;
  String? sleepHours;
  String? caloriesKcal;
  String? setYourFitnessGoals;
  String? specificGoal;
  String? save;

  MyGoalsPage({
    this.goalsSetting,
    this.targetWeightKg,
    this.drink,
    this.glass,
    this.sleepHours,
    this.caloriesKcal,
    this.setYourFitnessGoals,
    this.specificGoal,
    this.save,
  });

  factory MyGoalsPage.fromJson(Map<String, dynamic> json) => MyGoalsPage(
        goalsSetting: json["goals_setting"],
        targetWeightKg: json["target_weight_kg"],
        drink: json["drink"],
        glass: json["glass"],
        sleepHours: json["sleep_hours"],
        caloriesKcal: json["calories_kcal"],
        setYourFitnessGoals: json["set_your_fitness_goals"],
        specificGoal: json["specific_goal"],
        save: json["save"],
      );

  Map<String, dynamic> toJson() => {
        "goals_setting": goalsSetting,
        "target_weight_kg": targetWeightKg,
        "drink": drink,
        "glass": glass,
        "sleep_hours": sleepHours,
        "calories_kcal": caloriesKcal,
        "set_your_fitness_goals": setYourFitnessGoals,
        "specific_goal": specificGoal,
        "save": save,
      };
}

class NutriscoreDetailPage {
  String? nutriscoreDetail;
  String? nutriscore;
  String? low;
  String? mid;
  String? optimal;
  String? belowTarget;
  String? onTrack;
  String? excellent;
  String? score;
  String? todaysAmount;
  String? weeklyAverage;
  String? last7Days;
  String? disclaimer;
  String? disclaimerDescription;
  String? yourValue;
  String? water;
  String? protein;
  String? carbohydrate;
  String? fat;
  String? sodium;
  String? saturatedFat;
  String? monounsaturatedFat;
  String? polyunsaturatedFat;
  String? transFat;
  String? potassium;
  String? calcium;
  String? vitaminA;
  String? vitaminC;
  String? sugar;
  String? fiber;
  String? cholesterol;

  NutriscoreDetailPage({
    this.nutriscoreDetail,
    this.nutriscore,
    this.low,
    this.mid,
    this.optimal,
    this.belowTarget,
    this.onTrack,
    this.excellent,
    this.score,
    this.todaysAmount,
    this.weeklyAverage,
    this.last7Days,
    this.disclaimer,
    this.disclaimerDescription,
    this.yourValue,
    this.water,
    this.protein,
    this.carbohydrate,
    this.fat,
    this.sodium,
    this.saturatedFat,
    this.monounsaturatedFat,
    this.polyunsaturatedFat,
    this.transFat,
    this.potassium,
    this.calcium,
    this.vitaminA,
    this.vitaminC,
    this.sugar,
    this.fiber,
    this.cholesterol,
  });

  factory NutriscoreDetailPage.fromJson(Map<String, dynamic> json) => NutriscoreDetailPage(
        nutriscoreDetail: json["nutriscore_detail"],
        nutriscore: json["nutriscore"],
        low: json["low"],
        mid: json["mid"],
        optimal: json["optimal"],
        belowTarget: json["below_target"],
        onTrack: json["on_track"],
        excellent: json["excellent"],
        score: json["score"],
        todaysAmount: json["todays_amount"],
        weeklyAverage: json["weekly_average"],
        last7Days: json["last_7_days"],
        disclaimer: json["disclaimer"],
        disclaimerDescription: json["disclaimer_description"],
        yourValue: json["your_value"],
        water: json["water"],
        protein: json["protein"],
        carbohydrate: json["carbohydrate"],
        fat: json["fat"],
        sodium: json["sodium"],
        saturatedFat: json["saturated_fat"],
        monounsaturatedFat: json["monounsaturated_fat"],
        polyunsaturatedFat: json["polyunsaturated_fat"],
        transFat: json["trans_fat"],
        potassium: json["potassium"],
        calcium: json["calcium"],
        vitaminA: json["vitamin_a"],
        vitaminC: json["vitamin_c"],
        sugar: json["sugar"],
        fiber: json["fiber"],
        cholesterol: json["cholesterol"],
      );

  Map<String, dynamic> toJson() => {
        "nutriscore_detail": nutriscoreDetail,
        "nutriscore": nutriscore,
        "low": low,
        "mid": mid,
        "optimal": optimal,
        "below_target": belowTarget,
        "on_track": onTrack,
        "excellent": excellent,
        "score": score,
        "todays_amount": todaysAmount,
        "weekly_average": weeklyAverage,
        "last_7_days": last7Days,
        "disclaimer": disclaimer,
        "disclaimer_description": disclaimerDescription,
        "your_value": yourValue,
        "water": water,
        "protein": protein,
        "carbohydrate": carbohydrate,
        "fat": fat,
        "sodium": sodium,
        "saturated_fat": saturatedFat,
        "monounsaturated_fat": monounsaturatedFat,
        "polyunsaturated_fat": polyunsaturatedFat,
        "trans_fat": transFat,
        "potassium": potassium,
        "calcium": calcium,
        "vitamin_a": vitaminA,
        "vitamin_c": vitaminC,
        "sugar": sugar,
        "fiber": fiber,
        "cholesterol": cholesterol,
      };
}

class NutritionPage {
  String? nutrition;
  String? todayYouHaveConsumed;
  String? macroNut;
  String? microNut;
  String? totalCal;
  String? breakfast;
  String? lunch;
  String? snack;
  String? dinner;
  String? nutriscore;
  String? seeDetails;
  String? of;
  String? protein;
  String? carbs;
  String? fat;

  NutritionPage({
    this.nutrition,
    this.todayYouHaveConsumed,
    this.macroNut,
    this.microNut,
    this.totalCal,
    this.breakfast,
    this.lunch,
    this.snack,
    this.dinner,
    this.nutriscore,
    this.seeDetails,
    this.of,
    this.protein,
    this.carbs,
    this.fat,
  });

  factory NutritionPage.fromJson(Map<String, dynamic> json) => NutritionPage(
        nutrition: json["nutrition"],
        todayYouHaveConsumed: json["today_you_have_consumed"],
        macroNut: json["macro_nut"],
        microNut: json["micro_nut"],
        totalCal: json["total_cal"],
        breakfast: json["breakfast"],
        lunch: json["lunch"],
        snack: json["snack"],
        dinner: json["dinner"],
        nutriscore: json["nutriscore"],
        seeDetails: json["see_details"],
        of: json["of"],
        protein: json["protein"],
        carbs: json["carbs"],
        fat: json["fat"],
      );

  Map<String, dynamic> toJson() => {
        "nutrition": nutrition,
        "today_you_have_consumed": todayYouHaveConsumed,
        "macro_nut": macroNut,
        "micro_nut": microNut,
        "total_cal": totalCal,
        "breakfast": breakfast,
        "lunch": lunch,
        "snack": snack,
        "dinner": dinner,
        "nutriscore": nutriscore,
        "see_details": seeDetails,
        "of": of,
        "protein": protein,
        "carbs": carbs,
        "fat": fat,
      };
}

class OnboardingPage {
  String? healthProfile;
  String? letsStartByCompletingYourProfile;
  String? personalizedPlanWillBeCraftedBasedOnYourCurrentCondition;
  String? startNow;
  String? firstWhatsYourName;
  String? tellUsYourNameToUnlockPersonalizedExperience;
  String? firstName;
  String? lastName;
  String? next;
  String? whatIsYourGender;
  String? genderDescription;
  String? tellUsYourBirthDate;
  String? asYourBodyChangesWithAge;
  String? whatsYourCurrentWeightHeight;
  String? itsEssentialForCalculating;
  String? height;
  String? confirm;
  String? yourCurrentCondition;
  String? helpUsCalculateYourDailyCalorieNeeds;
  String? light100Kcal;
  String? moderate250Kcal;
  String? active400Kcal;
  String? lightDescription;
  String? moderateDescription;
  String? activeDescription;
  String? doYouHaveAnyAllergies;
  String? youCanAnswerNo;
  String? example;
  String? submit;
  String? youreAllSet;
  String? yourPersonalizedPlanIsReady;
  String? getStarted;

  OnboardingPage({
    this.healthProfile,
    this.letsStartByCompletingYourProfile,
    this.personalizedPlanWillBeCraftedBasedOnYourCurrentCondition,
    this.startNow,
    this.firstWhatsYourName,
    this.tellUsYourNameToUnlockPersonalizedExperience,
    this.firstName,
    this.lastName,
    this.next,
    this.whatIsYourGender,
    this.genderDescription,
    this.tellUsYourBirthDate,
    this.asYourBodyChangesWithAge,
    this.whatsYourCurrentWeightHeight,
    this.itsEssentialForCalculating,
    this.height,
    this.confirm,
    this.yourCurrentCondition,
    this.helpUsCalculateYourDailyCalorieNeeds,
    this.light100Kcal,
    this.moderate250Kcal,
    this.active400Kcal,
    this.lightDescription,
    this.moderateDescription,
    this.activeDescription,
    this.doYouHaveAnyAllergies,
    this.youCanAnswerNo,
    this.example,
    this.submit,
    this.youreAllSet,
    this.yourPersonalizedPlanIsReady,
    this.getStarted,
  });

  factory OnboardingPage.fromJson(Map<String, dynamic> json) => OnboardingPage(
        healthProfile: json["health_profile"],
        letsStartByCompletingYourProfile: json["lets_start_by_completing_your_profile"],
        personalizedPlanWillBeCraftedBasedOnYourCurrentCondition: json["personalized_plan_will_be_crafted_based_on_your_current_condition"],
        startNow: json["start_now"],
        firstWhatsYourName: json["first_whats_your_name"],
        tellUsYourNameToUnlockPersonalizedExperience: json["tell_us_your_name_to_unlock_personalized_experience"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        next: json["next"],
        whatIsYourGender: json["what_is_your_gender"],
        genderDescription: json["gender_description"],
        tellUsYourBirthDate: json["tell_us_your_birth_date"],
        asYourBodyChangesWithAge: json["as_your_body_changes_with_age"],
        whatsYourCurrentWeightHeight: json["whats_your_current_weight_height"],
        itsEssentialForCalculating: json["its_essential_for_calculating"],
        height: json["height"],
        confirm: json["confirm"],
        yourCurrentCondition: json["your_current_condition"],
        helpUsCalculateYourDailyCalorieNeeds: json["help_us_calculate_your_daily_calorie_needs"],
        light100Kcal: json["light_100kcal"],
        moderate250Kcal: json["moderate_250kcal"],
        active400Kcal: json["active_400kcal"],
        lightDescription: json["light_description"],
        moderateDescription: json["moderate_description"],
        activeDescription: json["active_description"],
        doYouHaveAnyAllergies: json["do_you_have_any_allergies"],
        youCanAnswerNo: json["you_can_answer_no"],
        example: json["example"],
        submit: json["submit"],
        youreAllSet: json["youre_all_set"],
        yourPersonalizedPlanIsReady: json["your_personalized_plan_is_ready"],
        getStarted: json["get_started"],
      );

  Map<String, dynamic> toJson() => {
        "health_profile": healthProfile,
        "lets_start_by_completing_your_profile": letsStartByCompletingYourProfile,
        "personalized_plan_will_be_crafted_based_on_your_current_condition": personalizedPlanWillBeCraftedBasedOnYourCurrentCondition,
        "start_now": startNow,
        "first_whats_your_name": firstWhatsYourName,
        "tell_us_your_name_to_unlock_personalized_experience": tellUsYourNameToUnlockPersonalizedExperience,
        "first_name": firstName,
        "last_name": lastName,
        "next": next,
        "what_is_your_gender": whatIsYourGender,
        "gender_description": genderDescription,
        "tell_us_your_birth_date": tellUsYourBirthDate,
        "as_your_body_changes_with_age": asYourBodyChangesWithAge,
        "whats_your_current_weight_height": whatsYourCurrentWeightHeight,
        "its_essential_for_calculating": itsEssentialForCalculating,
        "height": height,
        "confirm": confirm,
        "your_current_condition": yourCurrentCondition,
        "help_us_calculate_your_daily_calorie_needs": helpUsCalculateYourDailyCalorieNeeds,
        "light_100kcal": light100Kcal,
        "moderate_250kcal": moderate250Kcal,
        "active_400kcal": active400Kcal,
        "light_description": lightDescription,
        "moderate_description": moderateDescription,
        "active_description": activeDescription,
        "do_you_have_any_allergies": doYouHaveAnyAllergies,
        "you_can_answer_no": youCanAnswerNo,
        "example": example,
        "submit": submit,
        "youre_all_set": youreAllSet,
        "your_personalized_plan_is_ready": yourPersonalizedPlanIsReady,
        "get_started": getStarted,
      };
}

class PhysicalInformationPage {
  String? physicalInformation;
  String? gender;
  String? age;
  String? heightCm;
  String? weightKg;
  String? dietaryRestriction;
  String? save;

  PhysicalInformationPage({
    this.physicalInformation,
    this.gender,
    this.age,
    this.heightCm,
    this.weightKg,
    this.dietaryRestriction,
    this.save,
  });

  factory PhysicalInformationPage.fromJson(Map<String, dynamic> json) => PhysicalInformationPage(
        physicalInformation: json["physical_information"],
        gender: json["gender"],
        age: json["age"],
        heightCm: json["height_cm"],
        weightKg: json["weight_kg"],
        dietaryRestriction: json["dietary_restriction"],
        save: json["save"],
      );

  Map<String, dynamic> toJson() => {
        "physical_information": physicalInformation,
        "gender": gender,
        "age": age,
        "height_cm": heightCm,
        "weight_kg": weightKg,
        "dietary_restriction": dietaryRestriction,
        "save": save,
      };
}

class SignInPage {
  String? signIn;
  String? emailAddress;
  String? password;
  String? signInButton;
  String? forgotPassword;
  String? orSignInWith;
  String? dontHaveAccount;
  String? signUp;
  String? bySigningInAgreeToTermsAndConditions;
  String? termsAndConditions;
  String? privacyPolicy;
  String? and;

  SignInPage({
    this.signIn,
    this.emailAddress,
    this.password,
    this.signInButton,
    this.forgotPassword,
    this.orSignInWith,
    this.dontHaveAccount,
    this.signUp,
    this.bySigningInAgreeToTermsAndConditions,
    this.termsAndConditions,
    this.privacyPolicy,
    this.and,
  });

  factory SignInPage.fromJson(Map<String, dynamic> json) => SignInPage(
        signIn: json["sign_in"],
        emailAddress: json["email_address"],
        password: json["password"],
        signInButton: json["sign_in_button"],
        forgotPassword: json["forgot_password"],
        orSignInWith: json["or_sign_in_with"],
        dontHaveAccount: json["dont_have_account"],
        signUp: json["sign_up"],
        bySigningInAgreeToTermsAndConditions: json["by_signing_in_agree_to_terms_and_conditions"],
        termsAndConditions: json["terms_and_conditions"],
        privacyPolicy: json["privacy_policy"],
        and: json["and"],
      );

  Map<String, dynamic> toJson() => {
        "sign_in": signIn,
        "email_address": emailAddress,
        "password": password,
        "sign_in_button": signInButton,
        "forgot_password": forgotPassword,
        "or_sign_in_with": orSignInWith,
        "dont_have_account": dontHaveAccount,
        "sign_up": signUp,
        "by_signing_in_agree_to_terms_and_conditions": bySigningInAgreeToTermsAndConditions,
        "terms_and_conditions": termsAndConditions,
        "privacy_policy": privacyPolicy,
        "and": and,
      };
}

class SignUpPage {
  String? createNewAccount;
  String? enterYourDetailsToRegister;
  String? emailAddress;
  String? password;
  String? confirmPassword;
  String? signUp;
  String? or;
  String? alreadyHaveAccount;
  String? signIn;
  String? bySigningUpIAgreeToLivewellS;
  String? termsAndConditions;
  String? privacyPolicy;
  String? and;

  SignUpPage({
    this.createNewAccount,
    this.enterYourDetailsToRegister,
    this.emailAddress,
    this.password,
    this.confirmPassword,
    this.signUp,
    this.or,
    this.alreadyHaveAccount,
    this.signIn,
    this.bySigningUpIAgreeToLivewellS,
    this.termsAndConditions,
    this.privacyPolicy,
    this.and,
  });

  factory SignUpPage.fromJson(Map<String, dynamic> json) => SignUpPage(
        createNewAccount: json["create_new_account"],
        enterYourDetailsToRegister: json["enter_your_details_to_register"],
        emailAddress: json["email_address"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
        signUp: json["sign_up"],
        or: json["or"],
        alreadyHaveAccount: json["already_have_account"],
        signIn: json["sign_in"],
        bySigningUpIAgreeToLivewellS: json["by_signing up, I agree to Livewell's "],
        termsAndConditions: json["terms_and_conditions"],
        privacyPolicy: json["privacy_policy"],
        and: json["and"],
      );

  Map<String, dynamic> toJson() => {
        "create_new_account": createNewAccount,
        "enter_your_details_to_register": enterYourDetailsToRegister,
        "email_address": emailAddress,
        "password": password,
        "confirm_password": confirmPassword,
        "sign_up": signUp,
        "or": or,
        "already_have_account": alreadyHaveAccount,
        "sign_in": signIn,
        "by_signing up, I agree to Livewell's ": bySigningUpIAgreeToLivewellS,
        "terms_and_conditions": termsAndConditions,
        "privacy_policy": privacyPolicy,
        "and": and,
      };
}

class SleepPage {
  String? sleep;
  String? ofDailyGoals;
  String? dailyBreakdown;
  String? wentToSleep;
  String? wokeUp;
  String? lightSleep;
  String? deepSleep;
  String? inputSleep;
  String? last7Days;
  String? hrs;
  String? addSleep;
  String? startTimeOfSleep;
  String? wakeUpTime;
  String? save;

  SleepPage({
    this.sleep,
    this.ofDailyGoals,
    this.dailyBreakdown,
    this.wentToSleep,
    this.wokeUp,
    this.lightSleep,
    this.deepSleep,
    this.inputSleep,
    this.last7Days,
    this.hrs,
    this.addSleep,
    this.startTimeOfSleep,
    this.wakeUpTime,
    this.save,
  });

  factory SleepPage.fromJson(Map<String, dynamic> json) => SleepPage(
        sleep: json["sleep"],
        ofDailyGoals: json["of_daily_goals"],
        dailyBreakdown: json["daily_breakdown"],
        wentToSleep: json["went_to_sleep"],
        wokeUp: json["woke_up"],
        lightSleep: json["light_sleep"],
        deepSleep: json["deep_sleep"],
        inputSleep: json["input_sleep"],
        last7Days: json["last_7_days"],
        hrs: json["hrs"],
        addSleep: json["add_sleep"],
        startTimeOfSleep: json["start_time_of_sleep"],
        wakeUpTime: json["wake_up_time"],
        save: json["save"],
      );

  Map<String, dynamic> toJson() => {
        "sleep": sleep,
        "of_daily_goals": ofDailyGoals,
        "daily_breakdown": dailyBreakdown,
        "went_to_sleep": wentToSleep,
        "woke_up": wokeUp,
        "light_sleep": lightSleep,
        "deep_sleep": deepSleep,
        "input_sleep": inputSleep,
        "last_7_days": last7Days,
        "hrs": hrs,
        "add_sleep": addSleep,
        "start_time_of_sleep": startTimeOfSleep,
        "wake_up_time": wakeUpTime,
        "save": save,
      };
}

class StreakPage {
  String? streakPage;
  String? dayStreak;
  String? learningDailyKeepsYourStreakUp;
  String? nutrition;
  String? activity;
  String? sleep;
  String? hydration;
  String? mood;
  String? cal;
  String? hrs;
  String? liters;
  String? steps;

  StreakPage({
    this.streakPage,
    this.dayStreak,
    this.learningDailyKeepsYourStreakUp,
    this.nutrition,
    this.activity,
    this.sleep,
    this.hydration,
    this.mood,
    this.cal,
    this.hrs,
    this.liters,
    this.steps,
  });

  factory StreakPage.fromJson(Map<String, dynamic> json) => StreakPage(
        streakPage: json["streak_page"],
        dayStreak: json["day_streak"],
        learningDailyKeepsYourStreakUp: json["learning_daily_keeps_your_streak_up"],
        nutrition: json["nutrition"],
        activity: json["activity"],
        sleep: json["sleep"],
        hydration: json["hydration"],
        mood: json["mood"],
        cal: json["cal"],
        hrs: json["hrs"],
        liters: json["liters"],
        steps: json["steps"],
      );

  Map<String, dynamic> toJson() => {
        "streak_page": streakPage,
        "day_streak": dayStreak,
        "learning_daily_keeps_your_streak_up": learningDailyKeepsYourStreakUp,
        "nutrition": nutrition,
        "activity": activity,
        "sleep": sleep,
        "hydration": hydration,
        "mood": mood,
        "cal": cal,
        "hrs": hrs,
        "liters": liters,
        "steps": steps,
      };
}

class WaterPage {
  String? hydration;
  String? remaining;
  String? custom;
  String? the100Ml;
  String? the250Ml;
  String? the500Ml;
  String? wantToReduceWaterIntake;
  String? reduceWater;
  String? yourHydrationScoreStillEmpty;
  String? letsHelpYourBodyStayHydrated;
  String? learnYourUrineColor;
  String? understandYourHydration;
  String? overhydrated;
  String? good;
  String? fair;
  String? lightDehydrated;
  String? dehydrated;
  String? timeToSlowTheFlow;
  String? normal;
  String? drinkWaterNow;
  String? addWater;
  String? addDrink;
  String? reduce;
  String? pleaseReduceYourWaterIntakeByUpTo;
  String? totalOfWaterYouHaveAlreadyLogged;
  String? reduceDrink;
  String? inputYourWaterIntake;
  String? pleaseKeepYourWaterIntakeUnder;
  String? hydrationScoreToday;
  String? seeHowDoHydrationScoreCalculated;
  String? here;
  String? youreDoingWellInStayingHydrated;
  String? youHitYourGoalToday;

  WaterPage({
    this.hydration,
    this.remaining,
    this.custom,
    this.the100Ml,
    this.the250Ml,
    this.the500Ml,
    this.wantToReduceWaterIntake,
    this.reduceWater,
    this.yourHydrationScoreStillEmpty,
    this.letsHelpYourBodyStayHydrated,
    this.learnYourUrineColor,
    this.understandYourHydration,
    this.overhydrated,
    this.good,
    this.fair,
    this.lightDehydrated,
    this.dehydrated,
    this.timeToSlowTheFlow,
    this.normal,
    this.drinkWaterNow,
    this.addWater,
    this.addDrink,
    this.reduce,
    this.pleaseReduceYourWaterIntakeByUpTo,
    this.totalOfWaterYouHaveAlreadyLogged,
    this.reduceDrink,
    this.inputYourWaterIntake,
    this.pleaseKeepYourWaterIntakeUnder,
    this.hydrationScoreToday,
    this.seeHowDoHydrationScoreCalculated,
    this.here,
    this.youreDoingWellInStayingHydrated,
    this.youHitYourGoalToday,
  });

  factory WaterPage.fromJson(Map<String, dynamic> json) => WaterPage(
        hydration: json["hydration"],
        remaining: json["remaining"],
        custom: json["custom"],
        the100Ml: json["100ml"],
        the250Ml: json["250ml"],
        the500Ml: json["500ml"],
        wantToReduceWaterIntake: json["want_to_reduce_water_intake"],
        reduceWater: json["reduce_water"],
        yourHydrationScoreStillEmpty: json["your_hydration_score_still_empty"],
        letsHelpYourBodyStayHydrated: json["lets_help_your_body_stay_hydrated"],
        learnYourUrineColor: json["learn_your_urine_color"],
        understandYourHydration: json["understand_your_hydration"],
        overhydrated: json["overhydrated"],
        good: json["good"],
        fair: json["fair"],
        lightDehydrated: json["light_dehydrated"],
        dehydrated: json["dehydrated"],
        timeToSlowTheFlow: json["time_to_slow_the_flow"],
        normal: json["normal"],
        drinkWaterNow: json["drink_water_now"],
        addWater: json["add_water"],
        addDrink: json["add_drink"],
        reduce: json["reduce"],
        pleaseReduceYourWaterIntakeByUpTo: json["please_reduce_your_water_intake_by_up_to"],
        totalOfWaterYouHaveAlreadyLogged: json["total_of_water_you_have_already_logged"],
        reduceDrink: json["reduce_drink"],
        inputYourWaterIntake: json["input_your_water_intake"],
        pleaseKeepYourWaterIntakeUnder: json["please_keep_your_water_intake_under"],
        hydrationScoreToday: json["hydration_score_today"],
        seeHowDoHydrationScoreCalculated: json["see_how_do_hydration_score_calculated"],
        here: json["here"],
        youreDoingWellInStayingHydrated: json["youre_doing_well_in_staying_hydrated"],
        youHitYourGoalToday: json["you_hit_your_goal_today"],
      );

  Map<String, dynamic> toJson() => {
        "hydration": hydration,
        "remaining": remaining,
        "custom": custom,
        "100ml": the100Ml,
        "250ml": the250Ml,
        "500ml": the500Ml,
        "want_to_reduce_water_intake": wantToReduceWaterIntake,
        "reduce_water": reduceWater,
        "your_hydration_score_still_empty": yourHydrationScoreStillEmpty,
        "lets_help_your_body_stay_hydrated": letsHelpYourBodyStayHydrated,
        "learn_your_urine_color": learnYourUrineColor,
        "understand_your_hydration": understandYourHydration,
        "overhydrated": overhydrated,
        "good": good,
        "fair": fair,
        "light_dehydrated": lightDehydrated,
        "dehydrated": dehydrated,
        "time_to_slow_the_flow": timeToSlowTheFlow,
        "normal": normal,
        "drink_water_now": drinkWaterNow,
        "add_water": addWater,
        "add_drink": addDrink,
        "reduce": reduce,
        "please_reduce_your_water_intake_by_up_to": pleaseReduceYourWaterIntakeByUpTo,
        "total_of_water_you_have_already_logged": totalOfWaterYouHaveAlreadyLogged,
        "reduce_drink": reduceDrink,
        "input_your_water_intake": inputYourWaterIntake,
        "please_keep_your_water_intake_under": pleaseKeepYourWaterIntakeUnder,
        "hydration_score_today": hydrationScoreToday,
        "see_how_do_hydration_score_calculated": seeHowDoHydrationScoreCalculated,
        "here": here,
        "youre_doing_well_in_staying_hydrated": youreDoingWellInStayingHydrated,
        "you_hit_your_goal_today": youHitYourGoalToday,
      };
}

class WeightPage {
  String? weight;
  String? goal;
  String? youHaveGained;
  String? youreDoingGreatKeepYourSpiritUp;
  String? updateYourWeight;
  String? weightProgress;
  String? caloriesIntake;
  String? last7Days;
  String? projectedWeightAfter4Weeks;
  String? disclaimer;
  String? disclaimerDescription;
  String? weightUpdate;
  String? whatsYourWeight;
  String? updateYourCurrentWeight;
  String? update;
  String? goalsSetting;
  String? whatsYourGoal;
  String? updateYourCurrentGoalSetting;
  String? goalSettingUpdate;

  WeightPage({
    this.weight,
    this.goal,
    this.youHaveGained,
    this.youreDoingGreatKeepYourSpiritUp,
    this.updateYourWeight,
    this.weightProgress,
    this.caloriesIntake,
    this.last7Days,
    this.projectedWeightAfter4Weeks,
    this.disclaimer,
    this.disclaimerDescription,
    this.weightUpdate,
    this.whatsYourWeight,
    this.updateYourCurrentWeight,
    this.update,
    this.goalsSetting,
    this.whatsYourGoal,
    this.updateYourCurrentGoalSetting,
    this.goalSettingUpdate,
  });

  factory WeightPage.fromJson(Map<String, dynamic> json) => WeightPage(
        weight: json["weight"],
        goal: json["goal"],
        youHaveGained: json["you_have_gained"],
        youreDoingGreatKeepYourSpiritUp: json["youre_doing_great_keep_your_spirit_up"],
        updateYourWeight: json["update_your_weight"],
        weightProgress: json["weight_progress"],
        caloriesIntake: json["calories_intake"],
        last7Days: json["last_7_days"],
        projectedWeightAfter4Weeks: json["projected_weight_after_4_weeks"],
        disclaimer: json["disclaimer"],
        disclaimerDescription: json["disclaimer_description"],
        weightUpdate: json["weight_update"],
        whatsYourWeight: json["whats_your_weight"],
        updateYourCurrentWeight: json["update_your_current_weight"],
        update: json["update"],
        goalsSetting: json["goals_setting"],
        whatsYourGoal: json["whats_your_goal"],
        updateYourCurrentGoalSetting: json["update_your_current_goal_setting"],
        goalSettingUpdate: json["goal_setting_update"],
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "goal": goal,
        "you_have_gained": youHaveGained,
        "youre_doing_great_keep_your_spirit_up": youreDoingGreatKeepYourSpiritUp,
        "update_your_weight": updateYourWeight,
        "weight_progress": weightProgress,
        "calories_intake": caloriesIntake,
        "last_7_days": last7Days,
        "projected_weight_after_4_weeks": projectedWeightAfter4Weeks,
        "disclaimer": disclaimer,
        "disclaimer_description": disclaimerDescription,
        "weight_update": weightUpdate,
        "whats_your_weight": whatsYourWeight,
        "update_your_current_weight": updateYourCurrentWeight,
        "update": update,
        "goals_setting": goalsSetting,
        "whats_your_goal": whatsYourGoal,
        "update_your_current_goal_setting": updateYourCurrentGoalSetting,
        "goal_setting_update": goalSettingUpdate,
      };
}

class WellnessScorePage {
  String? wellnessScore;
  String? wellness;
  String? checkTheAppToSeeWhatYouNeedToImprove;
  String? low;
  String? optimal;
  String? high;
  String? nutrition;
  String? exercise;
  String? sleep;
  String? water;
  String? mood;
  String? seeHowDoWellnessScoreCalculated;
  String? learnMore;
  String? yourWellnessProfileToday;
  String? needImprovement;
  String? balanced;
  String? excellent;
  String? needImprovementDescription;
  String? balancedDescription;
  String? excellentDescription;
  String? reccomendationForYou;
  String? showMore;
  String? unlockYourWellnessScoreToday;
  String? trackYourDailyTaskToSeeYourWellness;

  WellnessScorePage({
    this.wellnessScore,
    this.wellness,
    this.checkTheAppToSeeWhatYouNeedToImprove,
    this.low,
    this.optimal,
    this.high,
    this.nutrition,
    this.exercise,
    this.sleep,
    this.water,
    this.mood,
    this.seeHowDoWellnessScoreCalculated,
    this.learnMore,
    this.yourWellnessProfileToday,
    this.needImprovement,
    this.balanced,
    this.excellent,
    this.needImprovementDescription,
    this.balancedDescription,
    this.excellentDescription,
    this.reccomendationForYou,
    this.showMore,
    this.unlockYourWellnessScoreToday,
    this.trackYourDailyTaskToSeeYourWellness,
  });

  factory WellnessScorePage.fromJson(Map<String, dynamic> json) => WellnessScorePage(
        wellnessScore: json["wellness_score"],
        wellness: json["wellness"],
        checkTheAppToSeeWhatYouNeedToImprove: json["check_the_app_to_see_what_you_need_to_improve"],
        low: json["low"],
        optimal: json["optimal"],
        high: json["high"],
        nutrition: json["nutrition"],
        exercise: json["exercise"],
        sleep: json["sleep"],
        water: json["water"],
        mood: json["mood"],
        seeHowDoWellnessScoreCalculated: json["see_how_do_wellness_score_calculated"],
        learnMore: json["learn_more"],
        yourWellnessProfileToday: json["your_wellness_profile_today"],
        needImprovement: json["need_improvement"],
        balanced: json["balanced"],
        excellent: json["excellent"],
        needImprovementDescription: json["need_improvement_description"],
        balancedDescription: json["balanced_description"],
        excellentDescription: json["excellent_description"],
        reccomendationForYou: json["reccomendation_for_you"],
        showMore: json["show_more"],
        unlockYourWellnessScoreToday: json["unlock_your_wellness_score_today"],
        trackYourDailyTaskToSeeYourWellness: json["track_your_daily_task_to_see_your_wellness"],
      );

  Map<String, dynamic> toJson() => {
        "wellness_score": wellnessScore,
        "wellness": wellness,
        "check_the_app_to_see_what_you_need_to_improve": checkTheAppToSeeWhatYouNeedToImprove,
        "low": low,
        "optimal": optimal,
        "high": high,
        "nutrition": nutrition,
        "exercise": exercise,
        "sleep": sleep,
        "water": water,
        "mood": mood,
        "see_how_do_wellness_score_calculated": seeHowDoWellnessScoreCalculated,
        "learn_more": learnMore,
        "your_wellness_profile_today": yourWellnessProfileToday,
        "need_improvement": needImprovement,
        "balanced": balanced,
        "excellent": excellent,
        "need_improvement_description": needImprovementDescription,
        "balanced_description": balancedDescription,
        "excellent_description": excellentDescription,
        "reccomendation_for_you": reccomendationForYou,
        "show_more": showMore,
        "unlock_your_wellness_score_today": unlockYourWellnessScoreToday,
        "track_your_daily_task_to_see_your_wellness": trackYourDailyTaskToSeeYourWellness,
      };
}
