class Localization {
  final Map<String, dynamic> enUS;
  final Map<String, dynamic> esES;
  final Map<String, dynamic> ptBR;

  Localization({
    required this.enUS,
    required this.esES,
    required this.ptBR,
  });

  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(
      enUS: json['en_US'],
      esES: json['es_ES'],
      ptBR: json['pt_BR'],
    );
  }
}

class LocalizationKeys {
  final String welcomeToLivewell;
  final String betterHealthThroughBetterLiving;
  final String getStarted;
  final String signIn;
  final String signUp;
  final String alreadyHaveAccount;
  final String dontHaveAccount;
  final String createNewAccount;
  final String enterYourDetailsToRegister;
  final String emailAddress;
  final String password;
  final String fullName;
  final String orSignUpWith;
  final String firstName;
  final String lastName;
  final String orSignInWith;
  final String forgotPassword;
  final String getStartedExclamation;
  final String youAreReadyToGo;
  final String thanksForTakingYourTimeToCreateAccountWithUs;
  final String
      pleaseEnterYourEmailAddressYouWillReceiveALinkToCreateANewPasswordViaEmail;
  final String submit;
  final String forgotPasswordTitle;
  final String bySignInAboveIAgreeToLivewellTermsAndConditions;
  final String termsAndConditions;
  final String and;
  final String privacyPolicy;
  final String bySigningUpIAgreeToLivewell;
  final String done;
  final String edit;
  final String save;
  final String accountSettings;
  final String dailyJournal;
  final String physicalInformation;
  final String exercise;
  final String myGoals;
  final String logout;
  final String setYourMealTime;
  final String breakfast;
  final String lunch;
  final String dinner;
  final String snack;
  final String diary;
  final String changePassword;
  final String updateWeight;
  final String yes;
  final String yourRecommendedFoods;
  final String pickedBasedOnYourNutritionalNeeds;
  final String foodRecommendation;
  final String
      discoverPersonalizedFoodRecommendationsThatMatchYourNutritionalNeeds;
  final String no;
  final String none;
  final String getFitter;
  final String betterSleeping;
  final String weightLoss;
  final String trackNutrition;
  final String improveOverallFitness;
  final String scanABarcode;
  final String scanAMeal;
  final String scanFood;
  final String foodRequestCompleted;
  final String thankYou;
  final String ourTeamIsWorkingOnYourRequest;
  final String backToDashboard;
  final String nutrientFact;
  final String food;
  final String addFood;
  final String showNutrientFacts;
  final String servingSize;
  final String time;
  final String cancel;
  final String filter;
  final String resetFilter;
  final String amount;
  final String numberOfServing;
  final String calories;
  final String protein;
  final String carbs;
  final String fat;
  final String male;
  final String female;
  final String saveChanges;
  final String gender;
  final String age;
  final String heightCm;
  final String weightKg;
  final String drink;
  final String dietaryRestriction;
  final String specificGoal;
  final String sleepHours;
  final String targetWeightKg;
  final String noResultsFound;
  final String nutriScoreDetails;
  final String enterYourOTP;
  final String enterNewPassword;
  final String newPassword;
  final String confirmPassword;
  final String change;
  final String eating;
  final String searchResult;
  final String searchHere;
  final String todayYouHaveConsumed;
  final String ofDailyGoals;
  final String add;
  final String requestFood;
  final String foodName;
  final String processing;
  final String wellRedirectYouToAnotherScreenOnceWeGotTheScanningResult;
  final String exerciseInformation;
  final String pre;
  final String next;
  final String currentWeightKg;
  final String update;
  final String waterConsumed;
  final String custom;
  final String waterTracking;
  final String addDrink;
  final String seeDetails;
  final String low;
  final String optimal;
  final String high;
  final String mid;
  final String belowTarget;
  final String onTrack;
  final String excellent;
  final String todaysAmount;
  final String weeklyAverage;
  final String last7Days;
  final String disclaimer;
  final String yourValue;
  final String eaten;
  final String burned;
  final String remaining;
  final String taskList;
  final String morning;
  final String afternoon;
  final String evening;
  final String keepWithOurPlanYouAreDoingGreat;
  final String seeMyProgress;
  final String youHaveReached;
  final String ofYourGoal;
  final String exerciseHabit;
  final String dailyBreakdown;
  final String poor;
  final String good;
  final String almost;
  final String great;
  final String goalsSetting;
  final String personalInformation;
  final String requestToDeleteAccount;
  final String deleteAccountPermanently;
  final String yourAccountAndContentDeletedPermanently;
  final String yourWaterIntakeForToday;
  final String livewellNutritionalDataDisclaimer;
  final String letsMakeTodayCount;
  final String dontWorryWeCanImproveNutritionTogether;
  final String youreDoingGreat;
  final String greatJobNutritionOnPoint;

  LocalizationKeys({
    required this.welcomeToLivewell,
    required this.betterHealthThroughBetterLiving,
    required this.getStarted,
    required this.signIn,
    required this.signUp,
    required this.alreadyHaveAccount,
    required this.dontHaveAccount,
    required this.createNewAccount,
    required this.enterYourDetailsToRegister,
    required this.emailAddress,
    required this.password,
    required this.fullName,
    required this.orSignUpWith,
    required this.firstName,
    required this.lastName,
    required this.orSignInWith,
    required this.forgotPassword,
    required this.getStartedExclamation,
    required this.youAreReadyToGo,
    required this.thanksForTakingYourTimeToCreateAccountWithUs,
    required this.pleaseEnterYourEmailAddressYouWillReceiveALinkToCreateANewPasswordViaEmail,
    required this.submit,
    required this.forgotPasswordTitle,
    required this.bySignInAboveIAgreeToLivewellTermsAndConditions,
    required this.termsAndConditions,
    required this.and,
    required this.privacyPolicy,
    required this.bySigningUpIAgreeToLivewell,
    required this.done,
    required this.edit,
    required this.save,
    required this.accountSettings,
    required this.dailyJournal,
    required this.physicalInformation,
    required this.exercise,
    required this.myGoals,
    required this.logout,
    required this.setYourMealTime,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
    required this.diary,
    required this.changePassword,
    required this.updateWeight,
    required this.yes,
    required this.yourRecommendedFoods,
    required this.pickedBasedOnYourNutritionalNeeds,
    required this.foodRecommendation,
    required this.discoverPersonalizedFoodRecommendationsThatMatchYourNutritionalNeeds,
    required this.no,
    required this.none,
    required this.getFitter,
    required this.betterSleeping,
    required this.weightLoss,
    required this.trackNutrition,
    required this.improveOverallFitness,
    required this.scanABarcode,
    required this.scanAMeal,
    required this.scanFood,
    required this.foodRequestCompleted,
    required this.thankYou,
    required this.ourTeamIsWorkingOnYourRequest,
    required this.backToDashboard,
    required this.nutrientFact,
    required this.food,
    required this.addFood,
    required this.showNutrientFacts,
    required this.servingSize,
    required this.time,
    required this.cancel,
    required this.filter,
    required this.resetFilter,
    required this.amount,
    required this.numberOfServing,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.male,
    required this.female,
    required this.saveChanges,
    required this.gender,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.drink,
    required this.dietaryRestriction,
    required this.specificGoal,
    required this.sleepHours,
    required this.targetWeightKg,
    required this.noResultsFound,
    required this.nutriScoreDetails,
    required this.enterYourOTP,
    required this.enterNewPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.change,
    required this.eating,
    required this.searchResult,
    required this.searchHere,
    required this.todayYouHaveConsumed,
    required this.ofDailyGoals,
    required this.add,
    required this.requestFood,
    required this.foodName,
    required this.processing,
    required this.wellRedirectYouToAnotherScreenOnceWeGotTheScanningResult,
    required this.exerciseInformation,
    required this.pre,
    required this.next,
    required this.currentWeightKg,
    required this.update,
    required this.waterConsumed,
    required this.custom,
    required this.waterTracking,
    required this.addDrink,
    required this.seeDetails,
    required this.low,
    required this.optimal,
    required this.high,
    required this.mid,
    required this.belowTarget,
    required this.onTrack,
    required this.excellent,
    required this.todaysAmount,
    required this.weeklyAverage,
    required this.last7Days,
    required this.disclaimer,
    required this.yourValue,
    required this.eaten,
    required this.burned,
    required this.remaining,
    required this.taskList,
    required this.morning,
    required this.afternoon,
    required this.evening,
    required this.keepWithOurPlanYouAreDoingGreat,
    required this.seeMyProgress,
    required this.youHaveReached,
    required this.ofYourGoal,
    required this.exerciseHabit,
    required this.dailyBreakdown,
    required this.poor,
    required this.good,
    required this.almost,
    required this.great,
    required this.goalsSetting,
    required this.personalInformation,
    required this.requestToDeleteAccount,
    required this.deleteAccountPermanently,
    required this.yourAccountAndContentDeletedPermanently,
    required this.yourWaterIntakeForToday,
    required this.livewellNutritionalDataDisclaimer,
    required this.letsMakeTodayCount,
    required this.dontWorryWeCanImproveNutritionTogether,
    required this.youreDoingGreat,
    required this.greatJobNutritionOnPoint,
  });

  factory LocalizationKeys.fromJson(Map<String, dynamic> json) {
    return LocalizationKeys(
      welcomeToLivewell: json['welcome_to_livewell'],
      betterHealthThroughBetterLiving:
          json['better_health_through_better_living'],
      getStarted: json['get_started'],
      signIn: json['sign_in'],
      signUp: json['sign_up'],
      alreadyHaveAccount: json['already_have_account'],
      dontHaveAccount: json['dont_have_account'],
      createNewAccount: json['create_new_account'],
      enterYourDetailsToRegister: json['enter_your_details_to_register'],
      emailAddress: json['email_address'],
      password: json['password'],
      fullName: json['full_name'],
      orSignUpWith: json['or_sign_up_with'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      orSignInWith: json['or_sign_in_with'],
      forgotPassword: json['forgot_password'],
      getStartedExclamation: json['get_started_exclamation'],
      youAreReadyToGo: json['you_are_ready_to_go'],
      thanksForTakingYourTimeToCreateAccountWithUs:
          json['thanks_for_taking_your_time_to_create_account_with_us'],
      pleaseEnterYourEmailAddressYouWillReceiveALinkToCreateANewPasswordViaEmail:
          json[
              'please_enter_your_email_address_you_will_receive_a_link_to_create_a_new_password_via_email'],
      submit: json['submit'],
      forgotPasswordTitle: json['forgot_password_title'],
      bySignInAboveIAgreeToLivewellTermsAndConditions:
          json['by_sign_in_above_i_agree_to_livewell_terms_and_conditions'],
      termsAndConditions: json['terms_and_conditions'],
      and: json['and'],
      privacyPolicy: json['privacy_policy'],
      bySigningUpIAgreeToLivewell: json['by_signing_up_i_agree_to_livewell'],
      done: json['done'],
      edit: json['edit'],
      save: json['save'],
      accountSettings: json['account_settings'],
      dailyJournal: json['daily_journal'],
      physicalInformation: json['physical_information'],
      exercise: json['exercise'],
      myGoals: json['my_goals'],
      logout: json['logout'],
      setYourMealTime: json['set_your_meal_time'],
      breakfast: json['breakfast'],
      lunch: json['lunch'],
      dinner: json['dinner'],
      snack: json['snack'],
      diary: json['diary'],
      changePassword: json['change_password'],
      updateWeight: json['update_weight'],
      yes: json['yes'],
      yourRecommendedFoods: json['your_recommended_foods'],
      pickedBasedOnYourNutritionalNeeds:
          json['picked_based_on_your_nutritional_needs'],
      foodRecommendation: json['food_recommendation'],
      discoverPersonalizedFoodRecommendationsThatMatchYourNutritionalNeeds: json[
          'discover_personalized_food_recommendations_that_match_your_nutritional_needs'],
      no: json['no'],
      none: json['none'],
      getFitter: json['get_fitter'],
      betterSleeping: json['better_sleeping'],
      weightLoss: json['weight_loss'],
      trackNutrition: json['track_nutrition'],
      improveOverallFitness: json['improve_overall_fitness'],
      scanABarcode: json['scan_a_barcode'],
      scanAMeal: json['scan_a_meal'],
      scanFood: json['scan_food'],
      foodRequestCompleted: json['food_request_completed'],
      thankYou: json['thank_you'],
      ourTeamIsWorkingOnYourRequest:
          json['our_team_is_working_on_your_request'],
      backToDashboard: json['back_to_dashboard'],
      nutrientFact: json['nutrient_fact'],
      food: json['food'],
      addFood: json['add_food'],
      showNutrientFacts: json['show_nutrient_facts'],
      servingSize: json['serving_size'],
      time: json['time'],
      cancel: json['cancel'],
      filter: json['filter'],
      resetFilter: json['reset_filter'],
      amount: json['amount'],
      numberOfServing: json['number_of_serving'],
      calories: json['calories'],
      protein: json['protein'],
      carbs: json['carbs'],
      fat: json['fat'],
      male: json['male'],
      female: json['female'],
      saveChanges: json['save_changes'],
      gender: json['gender'],
      age: json['age'],
      heightCm: json['height_cm'],
      weightKg: json['weight_kg'],
      drink: json['drink'],
      dietaryRestriction: json['dietary_restriction'],
      specificGoal: json['specific_goal'],
      sleepHours: json['sleep_hours'],
      targetWeightKg: json['target_weight_kg'],
      noResultsFound: json['no_results_found'],
      nutriScoreDetails: json['nutri_score_details'],
      enterYourOTP: json['enter_your_otp'],
      enterNewPassword: json['enter_new_password'],
      newPassword: json['new_password'],
      confirmPassword: json['confirm_password'],
      change: json['change'],
      eating: json['eating'],
      searchResult: json['search_result'],
      searchHere: json['search_here'],
      todayYouHaveConsumed: json['today_you_have_consumed'],
      ofDailyGoals: json['of_daily_goals'],
      add: json['add'],
      requestFood: json['request_food'],
      foodName: json['food_name'],
      processing: json['processing'],
      wellRedirectYouToAnotherScreenOnceWeGotTheScanningResult: json[
          'well_redirect_you_to_another_screen_once_we_got_the_scanning_result'],
      exerciseInformation: json['exercise_information'],
      pre: json['pre'],
      next: json['next'],
      currentWeightKg: json['current_weight_kg'],
      update: json['update'],
      waterConsumed: json['water_consumed'],
      custom: json['custom'],
      waterTracking: json['water_tracking'],
      addDrink: json['add_drink'],
      seeDetails: json['see_details'],
      low: json['low'],
      optimal: json['optimal'],
      high: json['high'],
      mid: json['mid'],
      belowTarget: json['below_target'],
      onTrack: json['on_track'],
      excellent: json['excellent'],
      todaysAmount: json['todays_amount'],
      weeklyAverage: json['weekly_average'],
      last7Days: json['last_7_days'],
      disclaimer: json['disclaimer'],
      yourValue: json['your_value'],
      eaten: json['eaten'],
      burned: json['burned'],
      remaining: json['remaining'],
      taskList: json['task_list'],
      morning: json['morning'],
      afternoon: json['afternoon'],
      evening: json['evening'],
      keepWithOurPlanYouAreDoingGreat:
          json['keep_with_our_plan_you_are_doing_great'],
      seeMyProgress: json['see_my_progress'],
      youHaveReached: json['you_have_reached'],
      ofYourGoal: json['of_your_goal'],
      exerciseHabit: json['exercise_habit'],
      dailyBreakdown: json['daily_breakdown'],
      poor: json['poor'],
      good: json['good'],
      almost: json['almost'],
      great: json['great'],
      goalsSetting: json['goals_setting'],
      personalInformation: json['personal_information'],
      requestToDeleteAccount: json['request_to_delete_account'],
      deleteAccountPermanently: json['delete_account_permanently'],
      yourAccountAndContentDeletedPermanently:
          json['your_account_and_content_deleted_permanently'],
      yourWaterIntakeForToday: json['your_water_intake_for_today'],
      livewellNutritionalDataDisclaimer:
          json['livewell_nutritional_data_disclaimer'],
      letsMakeTodayCount: json['lets_make_today_count'],
      dontWorryWeCanImproveNutritionTogether:
          json['dont_worry_we_can_improve_nutrition'],
      youreDoingGreat: json['youre_doing_great'],
      greatJobNutritionOnPoint: json['great_job_nutrition_on_point'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['welcome_to_livewell'] = this.welcomeToLivewell;
    data['better_health_through_better_living'] =
        this.betterHealthThroughBetterLiving;
    data['get_started'] = this.getStarted;
    data['sign_in'] = this.signIn;
    data['sign_up'] = this.signUp;
    data['already_have_account'] = this.alreadyHaveAccount;
    data['dont_have_account'] = this.dontHaveAccount;
    data['create_new_account'] = this.createNewAccount;
    data['enter_your_details_to_register'] = this.enterYourDetailsToRegister;
    data['email_address'] = this.emailAddress;
    data['password'] = this.password;
    data['full_name'] = this.fullName;
    data['or_sign_up_with'] = this.orSignUpWith;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['or_sign_in_with'] = this.orSignInWith;
    data['forgot_password'] = this.forgotPassword;
    data['get_started_exclamation'] = this.getStartedExclamation;
    data['you_are_ready_to_go'] = this.youAreReadyToGo;
    data['thanks_for_taking_your_time_to_create_account_with_us'] =
        this.thanksForTakingYourTimeToCreateAccountWithUs;
    data['please_enter_your_email_address_you_will_receive_a_link_to_create_a_new_password_via_email'] =
        this.pleaseEnterYourEmailAddressYouWillReceiveALinkToCreateANewPasswordViaEmail;
    data['submit'] = this.submit;
    data['forgot_password_title'] = this.forgotPasswordTitle;
    data['by_sign_in_above_i_agree_to_livewell_terms_and_conditions'] =
        this.bySignInAboveIAgreeToLivewellTermsAndConditions;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['and'] = this.and;
    data['privacy_policy'] = this.privacyPolicy;
    data['by_signing_up_i_agree_to_livewell'] =
        this.bySigningUpIAgreeToLivewell;
    data['done'] = this.done;
    data['edit'] = this.edit;
    data['save'] = this.save;
    data['account_settings'] = this.accountSettings;
    data['daily_journal'] = this.dailyJournal;
    data['physical_information'] = this.physicalInformation;
    data['exercise'] = this.exercise;
    data['my_goals'] = this.myGoals;
    data['logout'] = this.logout;
    data['set_your_meal_time'] = this.setYourMealTime;
    data['breakfast'] = this.breakfast;
    data['lunch'] = this.lunch;
    data['dinner'] = this.dinner;
    data['snack'] = this.snack;
    data['diary'] = this.diary;
    data['change_password'] = this.changePassword;
    data['update_weight'] = this.updateWeight;
    data['yes'] = this.yes;
    data['your_recommended_foods'] = this.yourRecommendedFoods;
    data['picked_based_on_your_nutritional_needs'] =
        this.pickedBasedOnYourNutritionalNeeds;
    data['food_recommendation'] = this.foodRecommendation;
    data['discover_personalized_food_recommendations_that_match_your_nutritional_needs'] =
        this.discoverPersonalizedFoodRecommendationsThatMatchYourNutritionalNeeds;
    data['no'] = this.no;
    data['none'] = this.none;
    data['get_fitter'] = this.getFitter;
    data['better_sleeping'] = this.betterSleeping;
    data['weight_loss'] = this.weightLoss;
    data['track_nutrition'] = this.trackNutrition;
    data['improve_overall_fitness'] = this.improveOverallFitness;
    data['scan_a_barcode'] = this.scanABarcode;
    data['scan_a_meal'] = this.scanAMeal;
    data['scan_food'] = this.scanFood;
    data['food_request_completed'] = this.foodRequestCompleted;
    data['thank_you'] = this.thankYou;
    data['our_team_is_working_on_your_request'] =
        this.ourTeamIsWorkingOnYourRequest;
    data['back_to_dashboard'] = this.backToDashboard;
    data['nutrient_fact'] = this.nutrientFact;
    data['food'] = this.food;
    data['add_food'] = this.addFood;
    data['show_nutrient_facts'] = this.showNutrientFacts;
    data['serving_size'] = this.servingSize;
    data['time'] = this.time;
    data['cancel'] = this.cancel;
    data['filter'] = this.filter;
    data['reset_filter'] = this.resetFilter;
    data['amount'] = this.amount;
    data['number_of_serving'] = this.numberOfServing;
    data['calories'] = this.calories;
    data['protein'] = this.protein;
    data['carbs'] = this.carbs;
    data['fat'] = this.fat;
    data['male'] = this.male;
    data['female'] = this.female;
    data['save_changes'] = this.saveChanges;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['height_cm'] = this.heightCm;
    data['weight_kg'] = this.weightKg;
    data['drink'] = this.drink;
    data['dietary_restriction'] = this.dietaryRestriction;
    data['specific_goal'] = this.specificGoal;
    data['sleep_hours'] = this.sleepHours;
    data['target_weight_kg'] = this.targetWeightKg;
    data['no_results_found'] = this.noResultsFound;
    data['nutri_score_details'] = this.nutriScoreDetails;
    data['enter_your_otp'] = this.enterYourOTP;
    data['enter_new_password'] = this.enterNewPassword;
    data['new_password'] = this.newPassword;
    data['confirm_password'] = this.confirmPassword;
    data['change'] = this.change;
    data['eating'] = this.eating;
    data['search_result'] = this.searchResult;
    data['search_here'] = this.searchHere;
    data['today_you_have_consumed'] = this.todayYouHaveConsumed;
    data['of_daily_goals'] = this.ofDailyGoals;
    data['add'] = this.add;
    data['request_food'] = this.requestFood;
    data['food_name'] = this.foodName;
    data['processing'] = this.processing;
    data['well_redirect_you_to_another_screen_once_we_got_the_scanning_result'] =
        this.wellRedirectYouToAnotherScreenOnceWeGotTheScanningResult;
    data['exercise_information'] = this.exerciseInformation;
    data['pre'] = this.pre;
    data['next'] = this.next;
    data['current_weight_kg'] = this.currentWeightKg;
    data['update'] = this.update;
    data['water_consumed'] = this.waterConsumed;
    data['custom'] = this.custom;
    data['water_tracking'] = this.waterTracking;
    data['add_drink'] = this.addDrink;
    data['see_details'] = this.seeDetails;
    data['low'] = this.low;
    data['optimal'] = this.optimal;
    data['high'] = this.high;
    data['mid'] = this.mid;
    data['below_target'] = this.belowTarget;
    data['on_track'] = this.onTrack;
    data['excellent'] = this.excellent;
    data['todays_amount'] = this.todaysAmount;
    data['weekly_average'] = this.weeklyAverage;
    data['last_7_days'] = this.last7Days;
    data['disclaimer'] = this.disclaimer;
    data['your_value'] = this.yourValue;
    data['eaten'] = this.eaten;
    data['burned'] = this.burned;
    data['remaining'] = this.remaining;
    data['task_list'] = this.taskList;
    data['morning'] = this.morning;
    data['afternoon'] = this.afternoon;
    data['evening'] = this.evening;
    data['keep_with_our_plan_you_are_doing_great'] =
        this.keepWithOurPlanYouAreDoingGreat;
    data['see_my_progress'] = this.seeMyProgress;
    data['you_have_reached'] = this.youHaveReached;
    data['of_your_goal'] = this.ofYourGoal;
    data['exercise_habit'] = this.exerciseHabit;
    data['daily_breakdown'] = this.dailyBreakdown;
    data['poor'] = this.poor;
    data['good'] = this.good;
    data['almost'] = this.almost;
    data['great'] = this.great;
    data['goals_setting'] = this.goalsSetting;
    data['personal_information'] = this.personalInformation;
    data['request_to_delete_account'] = this.requestToDeleteAccount;
    data['delete_account_permanently'] = this.deleteAccountPermanently;
    data['your_account_and_content_deleted_permanently'] =
        this.yourAccountAndContentDeletedPermanently;
    data['your_water_intake_for_today'] = this.yourWaterIntakeForToday;
    data['livewell_nutritional_data_disclaimer'] =
        this.livewellNutritionalDataDisclaimer;
    data['lets_make_today_count'] = this.letsMakeTodayCount;
    data['dont_worry_we_can_improve_nutrition'] =
        this.dontWorryWeCanImproveNutritionTogether;
    data['youre_doing_great'] = this.youreDoingGreat;
    data['great_job_nutrition_on_point'] = this.greatJobNutritionOnPoint;
    return data;
  }
}
