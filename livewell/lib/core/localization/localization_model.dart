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
      data['id_ID'] = this.idID!.toJson();
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
  String? basedOnYourNutritionalNeeds;
  String? belowTarget;
  String? betterHealthThroughBetterLiving;
  String? betterSleeping;
  String? breakfast;
  String? burned;
  String? bySigningInAgreeToTermsAndConditions;
  String? bySigningUpAgreeToTermsAndConditions;
  String? calorieIntake;
  String? calories;
  String? caloriesBurnt;
  String? cancel;
  String? carbs;
  String? change;
  String? changePassword;
  String? confirmPassword;
  String? createNewAccount;
  String? current;
  String? currentWeightKg;
  String? custom;
  String? dailyBreakdown;
  String? dailyJournal;
  String? deepSleep;
  String? deleteAccountPermanently;
  String? diary;
  String? dietaryRestriction;
  String? dinner;
  String? disclaimer;
  String? disclaimerProjectionBasedOnTodays;
  String? discoverPersonalizedFood;
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
  String? exploreYourPersonalHealth;
  String? fat;
  String? female;
  String? filter;
  String? filterRestaurantBrandsBy;
  String? firstName;
  String? food;
  String? foodFilter;
  String? foodName;
  String? foodRecommendation;
  String? foodRequestCompleted;
  String? forgotPassword;
  String? forgotPasswordText;
  String? foundAFoodThatIsNot;
  String? fullName;
  String? gender;
  String? getFitter;
  String? getStarted;
  String? getStartedExclamation;
  String? goalsSetting;
  String? good;
  String? goodGreeting;
  String? great;
  String? greatJobNutritionOnPoint;
  String? heightCm;
  String? high;
  String? improveOverallFitness;
  String? keepWithOurPlan;
  String? languages;
  String? last7Days;
  String? lastName;
  String? letsMakeTodayCount;
  String? lightSleep;
  String? livewellNutritionalDataDisclaimer;
  String? logYourFirstMeal;
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
  String? prev;
  String? privacyPolicy;
  String? processing;
  String? projectedWeightAfter4Weeks;
  String? protein;
  String? remaining;
  String? requestFood;
  String? requestNewFood;
  String? requestToDeleteAccount;
  String? resetFilter;
  String? save;
  String? saveChanges;
  String? scanABarcode;
  String? scanAMeal;
  String? scanFood;
  String? searchBar;
  String? searchHere;
  String? searchResult;
  String? seeDetails;
  String? seeMyProgress;
  String? seeYourProgress;
  String? servingSize;
  String? setYourMealTime;
  String? showNutrientFacts;
  String? signIn;
  String? signUp;
  String? sleep;
  String? sleepHours;
  String? snack;
  String? specificGoal;
  String? steps;
  String? submit;
  String? targetWeightKg;
  String? taskList;
  String? termsAndConditions;
  String? thankYou;
  String? thanksForCreatingAccount;
  String? time;
  String? toLogYourFirstMealSimply;
  String? todayYouHaveConsumed;
  String? todaysAmount;
  String? trackNutrition;
  String? update;
  String? updateWeight;
  String? updateYourWeight;
  String? useTheSearchbarTo;
  String? viewYourNutriscore;
  String? waterConsumed;
  String? waterTracking;
  String? weeklyAverage;
  String? weightKg;
  String? weightLoss;
  String? weightProgress;
  String? welcomeToLivewell;
  String? wellRedirectAfterScanningResult;
  String? wellnessHub;
  String? wentToSleep;
  String? wokeUp;
  String? yes;
  String? youAreReadyToGo;
  String? youHaveGained;
  String? youHaveLost;
  String? youHaveReached;
  String? yourAccountAndContentDeletedPermanently;
  String? yourRecommendedFoods;
  String? yourValue;
  String? yourWaterIntakeForToday;
  String? youreDoingGreat;
  String? youreDoingGreatKeepYourSpirit;
  String? language;
  String? name;
  String? howOldAreYou;
  String? whatsYourWeight;
  String? anyDietaryRestrictions;
  String? yourSpecificGoal;
  String? exerice;
  String? targetWeight;
  String? finish;
  String? s200kcal;
  String? s300kcal;
  String? s400kcal;
  String? selectYourPreferred;
  String? helpUsToCreatePersonalize;
  String? howManyGlassesOfWater;
  String? youCanAlwaysChangeThisLater;
  String? setYourFitnessGoals;
  String? howManyHoursOfSleeps;
  String? whatsYourHeight;

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
      this.basedOnYourNutritionalNeeds,
      this.belowTarget,
      this.betterHealthThroughBetterLiving,
      this.betterSleeping,
      this.breakfast,
      this.burned,
      this.bySigningInAgreeToTermsAndConditions,
      this.bySigningUpAgreeToTermsAndConditions,
      this.calorieIntake,
      this.calories,
      this.caloriesBurnt,
      this.cancel,
      this.carbs,
      this.change,
      this.changePassword,
      this.confirmPassword,
      this.createNewAccount,
      this.current,
      this.currentWeightKg,
      this.custom,
      this.dailyBreakdown,
      this.dailyJournal,
      this.deepSleep,
      this.deleteAccountPermanently,
      this.diary,
      this.dietaryRestriction,
      this.dinner,
      this.disclaimer,
      this.disclaimerProjectionBasedOnTodays,
      this.discoverPersonalizedFood,
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
      this.exploreYourPersonalHealth,
      this.fat,
      this.female,
      this.filter,
      this.filterRestaurantBrandsBy,
      this.firstName,
      this.food,
      this.foodFilter,
      this.foodName,
      this.foodRecommendation,
      this.foodRequestCompleted,
      this.forgotPassword,
      this.forgotPasswordText,
      this.foundAFoodThatIsNot,
      this.fullName,
      this.gender,
      this.getFitter,
      this.getStarted,
      this.getStartedExclamation,
      this.goalsSetting,
      this.good,
      this.goodGreeting,
      this.great,
      this.greatJobNutritionOnPoint,
      this.heightCm,
      this.high,
      this.improveOverallFitness,
      this.keepWithOurPlan,
      this.languages,
      this.last7Days,
      this.lastName,
      this.letsMakeTodayCount,
      this.lightSleep,
      this.livewellNutritionalDataDisclaimer,
      this.logYourFirstMeal,
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
      this.prev,
      this.privacyPolicy,
      this.processing,
      this.projectedWeightAfter4Weeks,
      this.protein,
      this.remaining,
      this.requestFood,
      this.requestNewFood,
      this.requestToDeleteAccount,
      this.resetFilter,
      this.save,
      this.saveChanges,
      this.scanABarcode,
      this.scanAMeal,
      this.scanFood,
      this.searchBar,
      this.searchHere,
      this.searchResult,
      this.seeDetails,
      this.seeMyProgress,
      this.seeYourProgress,
      this.servingSize,
      this.setYourMealTime,
      this.showNutrientFacts,
      this.signIn,
      this.signUp,
      this.sleep,
      this.sleepHours,
      this.snack,
      this.specificGoal,
      this.steps,
      this.submit,
      this.targetWeightKg,
      this.taskList,
      this.termsAndConditions,
      this.thankYou,
      this.thanksForCreatingAccount,
      this.time,
      this.toLogYourFirstMealSimply,
      this.todayYouHaveConsumed,
      this.todaysAmount,
      this.trackNutrition,
      this.update,
      this.updateWeight,
      this.updateYourWeight,
      this.useTheSearchbarTo,
      this.viewYourNutriscore,
      this.waterConsumed,
      this.waterTracking,
      this.weeklyAverage,
      this.weightKg,
      this.weightLoss,
      this.weightProgress,
      this.welcomeToLivewell,
      this.wellRedirectAfterScanningResult,
      this.wellnessHub,
      this.wentToSleep,
      this.wokeUp,
      this.yes,
      this.youAreReadyToGo,
      this.youHaveGained,
      this.youHaveLost,
      this.youHaveReached,
      this.yourAccountAndContentDeletedPermanently,
      this.yourRecommendedFoods,
      this.yourValue,
      this.yourWaterIntakeForToday,
      this.youreDoingGreat,
      this.youreDoingGreatKeepYourSpirit,
      this.language,
      this.name,
      this.howOldAreYou,
      this.whatsYourWeight,
      this.anyDietaryRestrictions,
      this.yourSpecificGoal,
      this.exerice,
      this.targetWeight,
      this.finish,
      this.s200kcal,
      this.s300kcal,
      this.s400kcal,
      this.selectYourPreferred,
      this.helpUsToCreatePersonalize,
      this.howManyGlassesOfWater,
      this.youCanAlwaysChangeThisLater,
      this.setYourFitnessGoals,
      this.howManyHoursOfSleeps,
      this.whatsYourHeight});

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
    basedOnYourNutritionalNeeds = json['based_on_your_nutritional_needs'];
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
    calorieIntake = json['calorie_intake'];
    calories = json['calories'];
    caloriesBurnt = json['calories_burnt'];
    cancel = json['cancel'];
    carbs = json['carbs'];
    change = json['change'];
    changePassword = json['change_password'];
    confirmPassword = json['confirm_password'];
    createNewAccount = json['create_new_account'];
    current = json['current'];
    currentWeightKg = json['current_weight_kg'];
    custom = json['custom'];
    dailyBreakdown = json['daily_breakdown'];
    dailyJournal = json['daily_journal'];
    deepSleep = json['deep_sleep'];
    deleteAccountPermanently = json['delete_account_permanently'];
    diary = json['diary'];
    dietaryRestriction = json['dietary_restriction'];
    dinner = json['dinner'];
    disclaimer = json['disclaimer'];
    disclaimerProjectionBasedOnTodays =
        json['disclaimer_projection_based_on_todays'];
    discoverPersonalizedFood = json['discover_personalized_food'];
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
    exploreYourPersonalHealth = json['explore_your_personal_health'];
    fat = json['fat'];
    female = json['female'];
    filter = json['filter'];
    filterRestaurantBrandsBy = json['filter_restaurant_brands_by'];
    firstName = json['first_name'];
    food = json['food'];
    foodFilter = json['food_filter'];
    foodName = json['food_name'];
    foodRecommendation = json['food_recommendation'];
    foodRequestCompleted = json['food_request_completed'];
    forgotPassword = json['forgot_password'];
    forgotPasswordText = json['forgot_password_text'];
    foundAFoodThatIsNot = json['found_a_food_that_is_not'];
    fullName = json['full_name'];
    gender = json['gender'];
    getFitter = json['get_fitter'];
    getStarted = json['get_started'];
    getStartedExclamation = json['get_started_exclamation'];
    goalsSetting = json['goals_setting'];
    good = json['good'];
    goodGreeting = json['good_greeting'];
    great = json['great'];
    greatJobNutritionOnPoint = json['great_job_nutrition_on_point'];
    heightCm = json['height_cm'];
    high = json['high'];
    improveOverallFitness = json['improve_overall_fitness'];
    keepWithOurPlan = json['keep_with_our_plan'];
    languages = json['languages'];
    last7Days = json['last_7_days'];
    lastName = json['last_name'];
    letsMakeTodayCount = json['lets_make_today_count'];
    lightSleep = json['light_sleep'];
    livewellNutritionalDataDisclaimer =
        json['livewell_nutritional_data_disclaimer'];
    logYourFirstMeal = json['log_your_first_meal'];
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
    prev = json['prev'];
    privacyPolicy = json['privacy_policy'];
    processing = json['processing'];
    projectedWeightAfter4Weeks = json['projected_weight_after_4_weeks'];
    protein = json['protein'];
    remaining = json['remaining'];
    requestFood = json['request_food'];
    requestNewFood = json['request_new_food'];
    requestToDeleteAccount = json['request_to_delete_account'];
    resetFilter = json['reset_filter'];
    save = json['save'];
    saveChanges = json['save_changes'];
    scanABarcode = json['scan_a_barcode'];
    scanAMeal = json['scan_a_meal'];
    scanFood = json['scan_food'];
    searchBar = json['search_bar'];
    searchHere = json['search_here'];
    searchResult = json['search_result'];
    seeDetails = json['see_details'];
    seeMyProgress = json['see_my_progress'];
    seeYourProgress = json['see_your_progress'];
    servingSize = json['serving_size'];
    setYourMealTime = json['set_your_meal_time'];
    showNutrientFacts = json['show_nutrient_facts'];
    signIn = json['sign_in'];
    signUp = json['sign_up'];
    sleep = json['sleep'];
    sleepHours = json['sleep_hours'];
    snack = json['snack'];
    specificGoal = json['specific_goal'];
    steps = json['steps'];
    submit = json['submit'];
    targetWeightKg = json['target_weight_kg'];
    taskList = json['task_list'];
    termsAndConditions = json['terms_and_conditions'];
    thankYou = json['thank_you'];
    thanksForCreatingAccount = json['thanks_for_creating_account'];
    time = json['time'];
    toLogYourFirstMealSimply = json['to_log_your_first_meal_simply'];
    todayYouHaveConsumed = json['today_you_have_consumed'];
    todaysAmount = json['todays_amount'];
    trackNutrition = json['track_nutrition'];
    update = json['update'];
    updateWeight = json['update_weight'];
    updateYourWeight = json['update_your_weight'];
    useTheSearchbarTo = json['use_the_searchbar_to'];
    viewYourNutriscore = json['view_your_nutriscore'];
    waterConsumed = json['water_consumed'];
    waterTracking = json['water_tracking'];
    weeklyAverage = json['weekly_average'];
    weightKg = json['weight_kg'];
    weightLoss = json['weight_loss'];
    weightProgress = json['weight_progress'];
    welcomeToLivewell = json['welcome_to_livewell'];
    wellRedirectAfterScanningResult =
        json['well_redirect_after_scanning_result'];
    wellnessHub = json['wellness_hub'];
    wentToSleep = json['went_to_sleep'];
    wokeUp = json['woke_up'];
    yes = json['yes'];
    youAreReadyToGo = json['you_are_ready_to_go'];
    youHaveGained = json['you_have_gained'];
    youHaveLost = json['you_have_lost'];
    youHaveReached = json['you_have_reached'];
    yourAccountAndContentDeletedPermanently =
        json['your_account_and_content_deleted_permanently'];
    yourRecommendedFoods = json['your_recommended_foods'];
    yourValue = json['your_value'];
    yourWaterIntakeForToday = json['your_water_intake_for_today'];
    youreDoingGreat = json['youre_doing_great'];
    youreDoingGreatKeepYourSpirit = json['youre_doing_great_keep_your_spirit'];
    language = json['language'];
    name = json['Name'];
    gender = json['Gender'];
    howOldAreYou = json['how_old_are_you'];
    whatsYourWeight = json['whats_your_weight'];
    anyDietaryRestrictions = json['any_dietary_restrictions'];
    yourSpecificGoal = json['your_specific_goal'];
    exerice = json['exerice'];
    targetWeight = json['target_weight'];
    finish = json['finish'];
    s200kcal = json['200kcal'];
    s300kcal = json['300kcal'];
    s400kcal = json['400kcal'];
    selectYourPreferred = json['select_your_preferred'];
    helpUsToCreatePersonalize = json['help_us_to_create_personalize'];
    howManyGlassesOfWater = json['how_many_glasses_of_water'];
    youCanAlwaysChangeThisLater = json['you_can_always_change_this_later'];
    setYourFitnessGoals = json['set_your_fitness_goals'];
    howManyHoursOfSleeps = json['how_many_hours_of_sleeps'];
    whatsYourHeight = json['whats_your_height'];
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
    data['based_on_your_nutritional_needs'] = this.basedOnYourNutritionalNeeds;
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
    data['calorie_intake'] = this.calorieIntake;
    data['calories'] = this.calories;
    data['calories_burnt'] = this.caloriesBurnt;
    data['cancel'] = this.cancel;
    data['carbs'] = this.carbs;
    data['change'] = this.change;
    data['change_password'] = this.changePassword;
    data['confirm_password'] = this.confirmPassword;
    data['create_new_account'] = this.createNewAccount;
    data['current'] = this.current;
    data['current_weight_kg'] = this.currentWeightKg;
    data['custom'] = this.custom;
    data['daily_breakdown'] = this.dailyBreakdown;
    data['daily_journal'] = this.dailyJournal;
    data['deep_sleep'] = this.deepSleep;
    data['delete_account_permanently'] = this.deleteAccountPermanently;
    data['diary'] = this.diary;
    data['dietary_restriction'] = this.dietaryRestriction;
    data['dinner'] = this.dinner;
    data['disclaimer'] = this.disclaimer;
    data['disclaimer_projection_based_on_todays'] =
        this.disclaimerProjectionBasedOnTodays;
    data['discover_personalized_food'] = this.discoverPersonalizedFood;
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
    data['explore_your_personal_health'] = this.exploreYourPersonalHealth;
    data['fat'] = this.fat;
    data['female'] = this.female;
    data['filter'] = this.filter;
    data['filter_restaurant_brands_by'] = this.filterRestaurantBrandsBy;
    data['first_name'] = this.firstName;
    data['food'] = this.food;
    data['food_filter'] = this.foodFilter;
    data['food_name'] = this.foodName;
    data['food_recommendation'] = this.foodRecommendation;
    data['food_request_completed'] = this.foodRequestCompleted;
    data['forgot_password'] = this.forgotPassword;
    data['forgot_password_text'] = this.forgotPasswordText;
    data['found_a_food_that_is_not'] = this.foundAFoodThatIsNot;
    data['full_name'] = this.fullName;
    data['gender'] = this.gender;
    data['get_fitter'] = this.getFitter;
    data['get_started'] = this.getStarted;
    data['get_started_exclamation'] = this.getStartedExclamation;
    data['goals_setting'] = this.goalsSetting;
    data['good'] = this.good;
    data['good_greeting'] = this.goodGreeting;
    data['great'] = this.great;
    data['great_job_nutrition_on_point'] = this.greatJobNutritionOnPoint;
    data['height_cm'] = this.heightCm;
    data['high'] = this.high;
    data['improve_overall_fitness'] = this.improveOverallFitness;
    data['keep_with_our_plan'] = this.keepWithOurPlan;
    data['languages'] = this.languages;
    data['last_7_days'] = this.last7Days;
    data['last_name'] = this.lastName;
    data['lets_make_today_count'] = this.letsMakeTodayCount;
    data['light_sleep'] = this.lightSleep;
    data['livewell_nutritional_data_disclaimer'] =
        this.livewellNutritionalDataDisclaimer;
    data['log_your_first_meal'] = this.logYourFirstMeal;
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
    data['prev'] = this.prev;
    data['privacy_policy'] = this.privacyPolicy;
    data['processing'] = this.processing;
    data['projected_weight_after_4_weeks'] = this.projectedWeightAfter4Weeks;
    data['protein'] = this.protein;
    data['remaining'] = this.remaining;
    data['request_food'] = this.requestFood;
    data['request_new_food'] = this.requestNewFood;
    data['request_to_delete_account'] = this.requestToDeleteAccount;
    data['reset_filter'] = this.resetFilter;
    data['save'] = this.save;
    data['save_changes'] = this.saveChanges;
    data['scan_a_barcode'] = this.scanABarcode;
    data['scan_a_meal'] = this.scanAMeal;
    data['scan_food'] = this.scanFood;
    data['search_bar'] = this.searchBar;
    data['search_here'] = this.searchHere;
    data['search_result'] = this.searchResult;
    data['see_details'] = this.seeDetails;
    data['see_my_progress'] = this.seeMyProgress;
    data['see_your_progress'] = this.seeYourProgress;
    data['serving_size'] = this.servingSize;
    data['set_your_meal_time'] = this.setYourMealTime;
    data['show_nutrient_facts'] = this.showNutrientFacts;
    data['sign_in'] = this.signIn;
    data['sign_up'] = this.signUp;
    data['sleep'] = this.sleep;
    data['sleep_hours'] = this.sleepHours;
    data['snack'] = this.snack;
    data['specific_goal'] = this.specificGoal;
    data['steps'] = this.steps;
    data['submit'] = this.submit;
    data['target_weight_kg'] = this.targetWeightKg;
    data['task_list'] = this.taskList;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['thank_you'] = this.thankYou;
    data['thanks_for_creating_account'] = this.thanksForCreatingAccount;
    data['time'] = this.time;
    data['to_log_your_first_meal_simply'] = this.toLogYourFirstMealSimply;
    data['today_you_have_consumed'] = this.todayYouHaveConsumed;
    data['todays_amount'] = this.todaysAmount;
    data['track_nutrition'] = this.trackNutrition;
    data['update'] = this.update;
    data['update_weight'] = this.updateWeight;
    data['update_your_weight'] = this.updateYourWeight;
    data['use_the_searchbar_to'] = this.useTheSearchbarTo;
    data['view_your_nutriscore'] = this.viewYourNutriscore;
    data['water_consumed'] = this.waterConsumed;
    data['water_tracking'] = this.waterTracking;
    data['weekly_average'] = this.weeklyAverage;
    data['weight_kg'] = this.weightKg;
    data['weight_loss'] = this.weightLoss;
    data['weight_progress'] = this.weightProgress;
    data['welcome_to_livewell'] = this.welcomeToLivewell;
    data['well_redirect_after_scanning_result'] =
        this.wellRedirectAfterScanningResult;
    data['wellness_hub'] = this.wellnessHub;
    data['went_to_sleep'] = this.wentToSleep;
    data['woke_up'] = this.wokeUp;
    data['yes'] = this.yes;
    data['you_are_ready_to_go'] = this.youAreReadyToGo;
    data['you_have_gained'] = this.youHaveGained;
    data['you_have_lost'] = this.youHaveLost;
    data['you_have_reached'] = this.youHaveReached;
    data['your_account_and_content_deleted_permanently'] =
        this.yourAccountAndContentDeletedPermanently;
    data['your_recommended_foods'] = this.yourRecommendedFoods;
    data['your_value'] = this.yourValue;
    data['your_water_intake_for_today'] = this.yourWaterIntakeForToday;
    data['youre_doing_great'] = this.youreDoingGreat;
    data['youre_doing_great_keep_your_spirit'] =
        this.youreDoingGreatKeepYourSpirit;
    data['language'] = this.language;
    data['Name'] = this.name;
    data['Gender'] = this.gender;
    data['how_old_are_you'] = this.howOldAreYou;
    data['whats_your_weight'] = this.whatsYourWeight;
    data['any_dietary_restrictions'] = this.anyDietaryRestrictions;
    data['your_specific_goal'] = this.yourSpecificGoal;
    data['exerice'] = this.exerice;
    data['target_weight'] = this.targetWeight;
    data['finish'] = this.finish;
    data['200kcal'] = this.s200kcal;
    data['300kcal'] = this.s300kcal;
    data['400kcal'] = this.s400kcal;
    data['select_your_preferred'] = this.selectYourPreferred;
    data['help_us_to_create_personalize'] = this.helpUsToCreatePersonalize;
    data['how_many_glasses_of_water'] = this.howManyGlassesOfWater;
    data['you_can_always_change_this_later'] = this.youCanAlwaysChangeThisLater;
    data['set_your_fitness_goals'] = this.setYourFitnessGoals;
    data['how_many_hours_of_sleeps'] = this.howManyHoursOfSleeps;
    data['whats_your_height'] = this.whatsYourHeight;
    return data;
  }
}
