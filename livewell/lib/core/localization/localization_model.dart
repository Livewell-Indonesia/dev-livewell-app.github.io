class Localization {
  LocalizationKey? enUS;
  LocalizationKey? idID;

  Localization({this.enUS, this.idID});

  Localization.fromJson(Map<String, dynamic> json) {
    enUS = json['en_US'] != null
        ? new LocalizationKey.fromJson(json['en_US'])
        : null;
    idID = json['id_ID'] != null
        ? new LocalizationKey.fromJson(json['id_ID'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.enUS != null) {
      data['en_US'] = this.enUS!.toJson();
    }
    if (this.idID != null) {
      data['id_ID'] = this.enUS!.toJson();
    }
    return data;
  }
}

class LocalizationKey {
  String? accountSettings;
  String? add;
  String? addDrink;
  String? addFood;
  String? afternoon;
  String? age;
  String? almost;
  String? alreadyHaveAccount;
  String? amount;
  String? and;
  String? backToDashboard;
  String? belowTarget;
  String? betterHealthThroughBetterLiving;
  String? betterSleeping;
  String? breakfast;
  String? burned;
  String? bySigningInAgreeToTermsAndConditions;
  String? bySigningUpAgreeToTermsAndConditions;
  String? calories;
  String? cancel;
  String? carbs;
  String? change;
  String? changePassword;
  String? confirmPassword;
  String? createNewAccount;
  String? currentWeightKg;
  String? custom;
  String? dailyBreakdown;
  String? dailyJournal;
  String? deleteAccountPermanently;
  String? diary;
  String? dietaryRestriction;
  String? dinner;
  String? disclaimer;
  String? discoverPersonalizedFoodRecommendations;
  String? done;
  String? dontHaveAccount;
  String? dontWorryWeCanImproveNutritionTogether;
  String? drink;
  String? eaten;
  String? eating;
  String? edit;
  String? emailAddress;
  String? enterNewPassword;
  String? enterYourDetailsToRegister;
  String? enterYourOtp;
  String? evening;
  String? excellent;
  String? exercise;
  String? exerciseHabit;
  String? exerciseInformation;
  String? fat;
  String? female;
  String? filter;
  String? firstName;
  String? food;
  String? foodName;
  String? foodRecommendation;
  String? foodRequestCompleted;
  String? forgotPassword;
  String? forgotPasswordText;
  String? fullName;
  String? gender;
  String? getFitter;
  String? getStarted;
  String? getStartedExclamation;
  String? goalsSetting;
  String? good;
  String? great;
  String? greatJobNutritionOnPoint;
  String? heightCm;
  String? high;
  String? improveOverallFitness;
  String? keepWithOurPlan;
  String? last7Days;
  String? lastName;
  String? letsMakeTodayCount;
  String? livewellNutritionalDataDisclaimer;
  String? logout;
  String? low;
  String? lunch;
  String? male;
  String? mid;
  String? morning;
  String? myGoals;
  String? newPassword;
  String? next;
  String? no;
  String? noResultsFound;
  String? none;
  String? numberOfServing;
  String? nutrientFact;
  String? nutriscoreDetails;
  String? ofDailyGoals;
  String? ofYourGoal;
  String? onTrack;
  String? optimal;
  String? orSignInWith;
  String? orSignUpWith;
  String? ourTeamWorkingOnYourRequest;
  String? password;
  String? personalInformation;
  String? physicalInformation;
  String? pickedBasedOnYourNutritionalNeeds;
  String? pleaseEnterEmailToResetPassword;
  String? poor;
  String? pre;
  String? privacyPolicy;
  String? processing;
  String? protein;
  String? remaining;
  String? requestFood;
  String? requestToDeleteAccount;
  String? resetFilter;
  String? save;
  String? saveChanges;
  String? scanABarcode;
  String? scanAMeal;
  String? scanFood;
  String? searchHere;
  String? searchResult;
  String? seeDetails;
  String? seeMyProgress;
  String? servingSize;
  String? setYourMealTime;
  String? showNutrientFacts;
  String? signIn;
  String? signUp;
  String? sleepHours;
  String? snack;
  String? specificGoal;
  String? submit;
  String? targetWeightKg;
  String? taskList;
  String? termsAndConditions;
  String? thankYou;
  String? thanksForCreatingAccount;
  String? time;
  String? todayYouHaveConsumed;
  String? todaysAmount;
  String? trackNutrition;
  String? update;
  String? updateWeight;
  String? waterConsumed;
  String? waterTracking;
  String? weeklyAverage;
  String? weightKg;
  String? weightLoss;
  String? welcomeToLivewell;
  String? wellRedirectAfterScanningResult;
  String? yes;
  String? youAreReadyToGo;
  String? youHaveReached;
  String? yourAccountAndContentDeletedPermanently;
  String? yourRecommendedFoods;
  String? yourValue;
  String? yourWaterIntakeForToday;
  String? youreDoingGreat;

  LocalizationKey(
      {this.accountSettings,
      this.add,
      this.addDrink,
      this.addFood,
      this.afternoon,
      this.age,
      this.almost,
      this.alreadyHaveAccount,
      this.amount,
      this.and,
      this.backToDashboard,
      this.belowTarget,
      this.betterHealthThroughBetterLiving,
      this.betterSleeping,
      this.breakfast,
      this.burned,
      this.bySigningInAgreeToTermsAndConditions,
      this.bySigningUpAgreeToTermsAndConditions,
      this.calories,
      this.cancel,
      this.carbs,
      this.change,
      this.changePassword,
      this.confirmPassword,
      this.createNewAccount,
      this.currentWeightKg,
      this.custom,
      this.dailyBreakdown,
      this.dailyJournal,
      this.deleteAccountPermanently,
      this.diary,
      this.dietaryRestriction,
      this.dinner,
      this.disclaimer,
      this.discoverPersonalizedFoodRecommendations,
      this.done,
      this.dontHaveAccount,
      this.dontWorryWeCanImproveNutritionTogether,
      this.drink,
      this.eaten,
      this.eating,
      this.edit,
      this.emailAddress,
      this.enterNewPassword,
      this.enterYourDetailsToRegister,
      this.enterYourOtp,
      this.evening,
      this.excellent,
      this.exercise,
      this.exerciseHabit,
      this.exerciseInformation,
      this.fat,
      this.female,
      this.filter,
      this.firstName,
      this.food,
      this.foodName,
      this.foodRecommendation,
      this.foodRequestCompleted,
      this.forgotPassword,
      this.forgotPasswordText,
      this.fullName,
      this.gender,
      this.getFitter,
      this.getStarted,
      this.getStartedExclamation,
      this.goalsSetting,
      this.good,
      this.great,
      this.greatJobNutritionOnPoint,
      this.heightCm,
      this.high,
      this.improveOverallFitness,
      this.keepWithOurPlan,
      this.last7Days,
      this.lastName,
      this.letsMakeTodayCount,
      this.livewellNutritionalDataDisclaimer,
      this.logout,
      this.low,
      this.lunch,
      this.male,
      this.mid,
      this.morning,
      this.myGoals,
      this.newPassword,
      this.next,
      this.no,
      this.noResultsFound,
      this.none,
      this.numberOfServing,
      this.nutrientFact,
      this.nutriscoreDetails,
      this.ofDailyGoals,
      this.ofYourGoal,
      this.onTrack,
      this.optimal,
      this.orSignInWith,
      this.orSignUpWith,
      this.ourTeamWorkingOnYourRequest,
      this.password,
      this.personalInformation,
      this.physicalInformation,
      this.pickedBasedOnYourNutritionalNeeds,
      this.pleaseEnterEmailToResetPassword,
      this.poor,
      this.pre,
      this.privacyPolicy,
      this.processing,
      this.protein,
      this.remaining,
      this.requestFood,
      this.requestToDeleteAccount,
      this.resetFilter,
      this.save,
      this.saveChanges,
      this.scanABarcode,
      this.scanAMeal,
      this.scanFood,
      this.searchHere,
      this.searchResult,
      this.seeDetails,
      this.seeMyProgress,
      this.servingSize,
      this.setYourMealTime,
      this.showNutrientFacts,
      this.signIn,
      this.signUp,
      this.sleepHours,
      this.snack,
      this.specificGoal,
      this.submit,
      this.targetWeightKg,
      this.taskList,
      this.termsAndConditions,
      this.thankYou,
      this.thanksForCreatingAccount,
      this.time,
      this.todayYouHaveConsumed,
      this.todaysAmount,
      this.trackNutrition,
      this.update,
      this.updateWeight,
      this.waterConsumed,
      this.waterTracking,
      this.weeklyAverage,
      this.weightKg,
      this.weightLoss,
      this.welcomeToLivewell,
      this.wellRedirectAfterScanningResult,
      this.yes,
      this.youAreReadyToGo,
      this.youHaveReached,
      this.yourAccountAndContentDeletedPermanently,
      this.yourRecommendedFoods,
      this.yourValue,
      this.yourWaterIntakeForToday,
      this.youreDoingGreat});

  LocalizationKey.fromJson(Map<String, dynamic> json) {
    accountSettings = json['account_settings'];
    add = json['add'];
    addDrink = json['add_drink'];
    addFood = json['add_food'];
    afternoon = json['afternoon'];
    age = json['age'];
    almost = json['almost'];
    alreadyHaveAccount = json['already_have_account'];
    amount = json['amount'];
    and = json['and'];
    backToDashboard = json['back_to_dashboard'];
    belowTarget = json['below_target'];
    betterHealthThroughBetterLiving =
        json['better_health_through_better_living'];
    betterSleeping = json['better_sleeping'];
    breakfast = json['breakfast'];
    burned = json['burned'];
    bySigningInAgreeToTermsAndConditions =
        json['by_signing_in_agree_to_terms_and_conditions'];
    bySigningUpAgreeToTermsAndConditions =
        json['by_signing_up_agree_to_terms_and_conditions'];
    calories = json['calories'];
    cancel = json['cancel'];
    carbs = json['carbs'];
    change = json['change'];
    changePassword = json['change_password'];
    confirmPassword = json['confirm_password'];
    createNewAccount = json['create_new_account'];
    currentWeightKg = json['current_weight_kg'];
    custom = json['custom'];
    dailyBreakdown = json['daily_breakdown'];
    dailyJournal = json['daily_journal'];
    deleteAccountPermanently = json['delete_account_permanently'];
    diary = json['diary'];
    dietaryRestriction = json['dietary_restriction'];
    dinner = json['dinner'];
    disclaimer = json['disclaimer'];
    discoverPersonalizedFoodRecommendations =
        json['discover_personalized_food_recommendations'];
    done = json['done'];
    dontHaveAccount = json['dont_have_account'];
    dontWorryWeCanImproveNutritionTogether =
        json['dont_worry_we_can_improve_nutrition_together'];
    drink = json['drink'];
    eaten = json['eaten'];
    eating = json['eating'];
    edit = json['edit'];
    emailAddress = json['email_address'];
    enterNewPassword = json['enter_new_password'];
    enterYourDetailsToRegister = json['enter_your_details_to_register'];
    enterYourOtp = json['enter_your_otp'];
    evening = json['evening'];
    excellent = json['excellent'];
    exercise = json['exercise'];
    exerciseHabit = json['exercise_habit'];
    exerciseInformation = json['exercise_information'];
    fat = json['fat'];
    female = json['female'];
    filter = json['filter'];
    firstName = json['first_name'];
    food = json['food'];
    foodName = json['food_name'];
    foodRecommendation = json['food_recommendation'];
    foodRequestCompleted = json['food_request_completed'];
    forgotPassword = json['forgot_password'];
    forgotPasswordText = json['forgot_password_text'];
    fullName = json['full_name'];
    gender = json['gender'];
    getFitter = json['get_fitter'];
    getStarted = json['get_started'];
    getStartedExclamation = json['get_started_exclamation'];
    goalsSetting = json['goals_setting'];
    good = json['good'];
    great = json['great'];
    greatJobNutritionOnPoint = json['great_job_nutrition_on_point'];
    heightCm = json['height_cm'];
    high = json['high'];
    improveOverallFitness = json['improve_overall_fitness'];
    keepWithOurPlan = json['keep_with_our_plan'];
    last7Days = json['last_7_days'];
    lastName = json['last_name'];
    letsMakeTodayCount = json['lets_make_today_count'];
    livewellNutritionalDataDisclaimer =
        json['livewell_nutritional_data_disclaimer'];
    logout = json['logout'];
    low = json['low'];
    lunch = json['lunch'];
    male = json['male'];
    mid = json['mid'];
    morning = json['morning'];
    myGoals = json['my_goals'];
    newPassword = json['new_password'];
    next = json['next'];
    no = json['no'];
    noResultsFound = json['no_results_found'];
    none = json['none'];
    numberOfServing = json['number_of_serving'];
    nutrientFact = json['nutrient_fact'];
    nutriscoreDetails = json['nutriscore_details'];
    ofDailyGoals = json['of_daily_goals'];
    ofYourGoal = json['of_your_goal'];
    onTrack = json['on_track'];
    optimal = json['optimal'];
    orSignInWith = json['or_sign_in_with'];
    orSignUpWith = json['or_sign_up_with'];
    ourTeamWorkingOnYourRequest = json['our_team_working_on_your_request'];
    password = json['password'];
    personalInformation = json['personal_information'];
    physicalInformation = json['physical_information'];
    pickedBasedOnYourNutritionalNeeds =
        json['picked_based_on_your_nutritional_needs'];
    pleaseEnterEmailToResetPassword =
        json['please_enter_email_to_reset_password'];
    poor = json['poor'];
    pre = json['pre'];
    privacyPolicy = json['privacy_policy'];
    processing = json['processing'];
    protein = json['protein'];
    remaining = json['remaining'];
    requestFood = json['request_food'];
    requestToDeleteAccount = json['request_to_delete_account'];
    resetFilter = json['reset_filter'];
    save = json['save'];
    saveChanges = json['save_changes'];
    scanABarcode = json['scan_a_barcode'];
    scanAMeal = json['scan_a_meal'];
    scanFood = json['scan_food'];
    searchHere = json['search_here'];
    searchResult = json['search_result'];
    seeDetails = json['see_details'];
    seeMyProgress = json['see_my_progress'];
    servingSize = json['serving_size'];
    setYourMealTime = json['set_your_meal_time'];
    showNutrientFacts = json['show_nutrient_facts'];
    signIn = json['sign_in'];
    signUp = json['sign_up'];
    sleepHours = json['sleep_hours'];
    snack = json['snack'];
    specificGoal = json['specific_goal'];
    submit = json['submit'];
    targetWeightKg = json['target_weight_kg'];
    taskList = json['task_list'];
    termsAndConditions = json['terms_and_conditions'];
    thankYou = json['thank_you'];
    thanksForCreatingAccount = json['thanks_for_creating_account'];
    time = json['time'];
    todayYouHaveConsumed = json['today_you_have_consumed'];
    todaysAmount = json['todays_amount'];
    trackNutrition = json['track_nutrition'];
    update = json['update'];
    updateWeight = json['update_weight'];
    waterConsumed = json['water_consumed'];
    waterTracking = json['water_tracking'];
    weeklyAverage = json['weekly_average'];
    weightKg = json['weight_kg'];
    weightLoss = json['weight_loss'];
    welcomeToLivewell = json['welcome_to_livewell'];
    wellRedirectAfterScanningResult =
        json['well_redirect_after_scanning_result'];
    yes = json['yes'];
    youAreReadyToGo = json['you_are_ready_to_go'];
    youHaveReached = json['you_have_reached'];
    yourAccountAndContentDeletedPermanently =
        json['your_account_and_content_deleted_permanently'];
    yourRecommendedFoods = json['your_recommended_foods'];
    yourValue = json['your_value'];
    yourWaterIntakeForToday = json['your_water_intake_for_today'];
    youreDoingGreat = json['youre_doing_great'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_settings'] = this.accountSettings;
    data['add'] = this.add;
    data['add_drink'] = this.addDrink;
    data['add_food'] = this.addFood;
    data['afternoon'] = this.afternoon;
    data['age'] = this.age;
    data['almost'] = this.almost;
    data['already_have_account'] = this.alreadyHaveAccount;
    data['amount'] = this.amount;
    data['and'] = this.and;
    data['back_to_dashboard'] = this.backToDashboard;
    data['below_target'] = this.belowTarget;
    data['better_health_through_better_living'] =
        this.betterHealthThroughBetterLiving;
    data['better_sleeping'] = this.betterSleeping;
    data['breakfast'] = this.breakfast;
    data['burned'] = this.burned;
    data['by_signing_in_agree_to_terms_and_conditions'] =
        this.bySigningInAgreeToTermsAndConditions;
    data['by_signing_up_agree_to_terms_and_conditions'] =
        this.bySigningUpAgreeToTermsAndConditions;
    data['calories'] = this.calories;
    data['cancel'] = this.cancel;
    data['carbs'] = this.carbs;
    data['change'] = this.change;
    data['change_password'] = this.changePassword;
    data['confirm_password'] = this.confirmPassword;
    data['create_new_account'] = this.createNewAccount;
    data['current_weight_kg'] = this.currentWeightKg;
    data['custom'] = this.custom;
    data['daily_breakdown'] = this.dailyBreakdown;
    data['daily_journal'] = this.dailyJournal;
    data['delete_account_permanently'] = this.deleteAccountPermanently;
    data['diary'] = this.diary;
    data['dietary_restriction'] = this.dietaryRestriction;
    data['dinner'] = this.dinner;
    data['disclaimer'] = this.disclaimer;
    data['discover_personalized_food_recommendations'] =
        this.discoverPersonalizedFoodRecommendations;
    data['done'] = this.done;
    data['dont_have_account'] = this.dontHaveAccount;
    data['dont_worry_we_can_improve_nutrition_together'] =
        this.dontWorryWeCanImproveNutritionTogether;
    data['drink'] = this.drink;
    data['eaten'] = this.eaten;
    data['eating'] = this.eating;
    data['edit'] = this.edit;
    data['email_address'] = this.emailAddress;
    data['enter_new_password'] = this.enterNewPassword;
    data['enter_your_details_to_register'] = this.enterYourDetailsToRegister;
    data['enter_your_otp'] = this.enterYourOtp;
    data['evening'] = this.evening;
    data['excellent'] = this.excellent;
    data['exercise'] = this.exercise;
    data['exercise_habit'] = this.exerciseHabit;
    data['exercise_information'] = this.exerciseInformation;
    data['fat'] = this.fat;
    data['female'] = this.female;
    data['filter'] = this.filter;
    data['first_name'] = this.firstName;
    data['food'] = this.food;
    data['food_name'] = this.foodName;
    data['food_recommendation'] = this.foodRecommendation;
    data['food_request_completed'] = this.foodRequestCompleted;
    data['forgot_password'] = this.forgotPassword;
    data['forgot_password_text'] = this.forgotPasswordText;
    data['full_name'] = this.fullName;
    data['gender'] = this.gender;
    data['get_fitter'] = this.getFitter;
    data['get_started'] = this.getStarted;
    data['get_started_exclamation'] = this.getStartedExclamation;
    data['goals_setting'] = this.goalsSetting;
    data['good'] = this.good;
    data['great'] = this.great;
    data['great_job_nutrition_on_point'] = this.greatJobNutritionOnPoint;
    data['height_cm'] = this.heightCm;
    data['high'] = this.high;
    data['improve_overall_fitness'] = this.improveOverallFitness;
    data['keep_with_our_plan'] = this.keepWithOurPlan;
    data['last_7_days'] = this.last7Days;
    data['last_name'] = this.lastName;
    data['lets_make_today_count'] = this.letsMakeTodayCount;
    data['livewell_nutritional_data_disclaimer'] =
        this.livewellNutritionalDataDisclaimer;
    data['logout'] = this.logout;
    data['low'] = this.low;
    data['lunch'] = this.lunch;
    data['male'] = this.male;
    data['mid'] = this.mid;
    data['morning'] = this.morning;
    data['my_goals'] = this.myGoals;
    data['new_password'] = this.newPassword;
    data['next'] = this.next;
    data['no'] = this.no;
    data['no_results_found'] = this.noResultsFound;
    data['none'] = this.none;
    data['number_of_serving'] = this.numberOfServing;
    data['nutrient_fact'] = this.nutrientFact;
    data['nutriscore_details'] = this.nutriscoreDetails;
    data['of_daily_goals'] = this.ofDailyGoals;
    data['of_your_goal'] = this.ofYourGoal;
    data['on_track'] = this.onTrack;
    data['optimal'] = this.optimal;
    data['or_sign_in_with'] = this.orSignInWith;
    data['or_sign_up_with'] = this.orSignUpWith;
    data['our_team_working_on_your_request'] = this.ourTeamWorkingOnYourRequest;
    data['password'] = this.password;
    data['personal_information'] = this.personalInformation;
    data['physical_information'] = this.physicalInformation;
    data['picked_based_on_your_nutritional_needs'] =
        this.pickedBasedOnYourNutritionalNeeds;
    data['please_enter_email_to_reset_password'] =
        this.pleaseEnterEmailToResetPassword;
    data['poor'] = this.poor;
    data['pre'] = this.pre;
    data['privacy_policy'] = this.privacyPolicy;
    data['processing'] = this.processing;
    data['protein'] = this.protein;
    data['remaining'] = this.remaining;
    data['request_food'] = this.requestFood;
    data['request_to_delete_account'] = this.requestToDeleteAccount;
    data['reset_filter'] = this.resetFilter;
    data['save'] = this.save;
    data['save_changes'] = this.saveChanges;
    data['scan_a_barcode'] = this.scanABarcode;
    data['scan_a_meal'] = this.scanAMeal;
    data['scan_food'] = this.scanFood;
    data['search_here'] = this.searchHere;
    data['search_result'] = this.searchResult;
    data['see_details'] = this.seeDetails;
    data['see_my_progress'] = this.seeMyProgress;
    data['serving_size'] = this.servingSize;
    data['set_your_meal_time'] = this.setYourMealTime;
    data['show_nutrient_facts'] = this.showNutrientFacts;
    data['sign_in'] = this.signIn;
    data['sign_up'] = this.signUp;
    data['sleep_hours'] = this.sleepHours;
    data['snack'] = this.snack;
    data['specific_goal'] = this.specificGoal;
    data['submit'] = this.submit;
    data['target_weight_kg'] = this.targetWeightKg;
    data['task_list'] = this.taskList;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['thank_you'] = this.thankYou;
    data['thanks_for_creating_account'] = this.thanksForCreatingAccount;
    data['time'] = this.time;
    data['today_you_have_consumed'] = this.todayYouHaveConsumed;
    data['todays_amount'] = this.todaysAmount;
    data['track_nutrition'] = this.trackNutrition;
    data['update'] = this.update;
    data['update_weight'] = this.updateWeight;
    data['water_consumed'] = this.waterConsumed;
    data['water_tracking'] = this.waterTracking;
    data['weekly_average'] = this.weeklyAverage;
    data['weight_kg'] = this.weightKg;
    data['weight_loss'] = this.weightLoss;
    data['welcome_to_livewell'] = this.welcomeToLivewell;
    data['well_redirect_after_scanning_result'] =
        this.wellRedirectAfterScanningResult;
    data['yes'] = this.yes;
    data['you_are_ready_to_go'] = this.youAreReadyToGo;
    data['you_have_reached'] = this.youHaveReached;
    data['your_account_and_content_deleted_permanently'] =
        this.yourAccountAndContentDeletedPermanently;
    data['your_recommended_foods'] = this.yourRecommendedFoods;
    data['your_value'] = this.yourValue;
    data['your_water_intake_for_today'] = this.yourWaterIntakeForToday;
    data['youre_doing_great'] = this.youreDoingGreat;
    return data;
  }
}
