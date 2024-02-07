class Localization {
  LocalizationKey? enUS;
  LocalizationKey? idID;

  Localization({this.enUS, this.idID});

  Localization.fromJson(Map<String, dynamic> json) {
    enUS =
        json['en_US'] != null ? LocalizationKey.fromJson(json['en_US']) : null;
    idID =
        json['id_ID'] != null ? LocalizationKey.fromJson(json['id_ID']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (enUS != null) {
      data['en_US'] = enUS!.toJson();
    }
    if (idID != null) {
      data['id_ID'] = idID!.toJson();
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
  String? nutrition;
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
  String? of;
  String? moodTracker;
  String? moodChart;
  String? last14Days;
  String? moodCount;
  String? howAreYou;
  String? moodGreat;
  String? moodGood;
  String? moodMeh;
  String? moodBad;
  String? moodAwful;

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
      this.nutrition,
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
      this.whatsYourHeight,
      this.of,
      this.moodTracker,
      this.moodChart,
      this.last14Days,
      this.moodCount,
      this.howAreYou,
      this.moodGreat,
      this.moodGood,
      this.moodMeh,
      this.moodBad,
      this.moodAwful});

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
    nutrition = json['nutrition'];
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
    of = json['of'];
    moodTracker = json['mood_tracker'];
    moodChart = json['mood_chart'];
    last14Days = json['last_14_days'];
    moodCount = json['mood_count'];
    howAreYou = json['how_are_you'];
    moodGreat = json['mood_great'];
    moodGood = json['mood_good'];
    moodMeh = json['mood_meh'];
    moodBad = json['mood_bad'];
    moodAwful = json['mood_awful'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_settings'] = accountSettings;
    data['add'] = add;
    data['add_drink'] = addDrink;
    data['add_food'] = addFood;
    data['afternoon'] = afternoon;
    data['age'] = age;
    data['almost'] = almost;
    data['already_have_account'] = alreadyHaveAccount;
    data['amount'] = amount;
    data['and'] = and;
    data['back_to_dashboard'] = backToDashboard;
    data['based_on_your_nutritional_needs'] = basedOnYourNutritionalNeeds;
    data['below_target'] = belowTarget;
    data['better_health_through_better_living'] =
        betterHealthThroughBetterLiving;
    data['better_sleeping'] = betterSleeping;
    data['breakfast'] = breakfast;
    data['burned'] = burned;
    data['by_signing_in_agree_to_terms_and_conditions'] =
        bySigningInAgreeToTermsAndConditions;
    data['by_signing_up_agree_to_terms_and_conditions'] =
        bySigningUpAgreeToTermsAndConditions;
    data['calorie_intake'] = calorieIntake;
    data['calories'] = calories;
    data['calories_burnt'] = caloriesBurnt;
    data['cancel'] = cancel;
    data['carbs'] = carbs;
    data['change'] = change;
    data['change_password'] = changePassword;
    data['confirm_password'] = confirmPassword;
    data['create_new_account'] = createNewAccount;
    data['current'] = current;
    data['current_weight_kg'] = currentWeightKg;
    data['custom'] = custom;
    data['daily_breakdown'] = dailyBreakdown;
    data['daily_journal'] = dailyJournal;
    data['deep_sleep'] = deepSleep;
    data['delete_account_permanently'] = deleteAccountPermanently;
    data['diary'] = diary;
    data['dietary_restriction'] = dietaryRestriction;
    data['dinner'] = dinner;
    data['disclaimer'] = disclaimer;
    data['disclaimer_projection_based_on_todays'] =
        disclaimerProjectionBasedOnTodays;
    data['discover_personalized_food'] = discoverPersonalizedFood;
    data['discover_personalized_food_recommendations'] =
        discoverPersonalizedFoodRecommendations;
    data['done'] = done;
    data['dont_have_account'] = dontHaveAccount;
    data['dont_worry_we_can_improve_nutrition_together'] =
        dontWorryWeCanImproveNutritionTogether;
    data['drink'] = drink;
    data['eaten'] = eaten;
    data['eating'] = eating;
    data['edit'] = edit;
    data['email_address'] = emailAddress;
    data['enter_new_password'] = enterNewPassword;
    data['enter_your_details_to_register'] = enterYourDetailsToRegister;
    data['enter_your_otp'] = enterYourOtp;
    data['evening'] = evening;
    data['excellent'] = excellent;
    data['exercise'] = exercise;
    data['exercise_habit'] = exerciseHabit;
    data['exercise_information'] = exerciseInformation;
    data['explore_your_personal_health'] = exploreYourPersonalHealth;
    data['fat'] = fat;
    data['female'] = female;
    data['filter'] = filter;
    data['filter_restaurant_brands_by'] = filterRestaurantBrandsBy;
    data['first_name'] = firstName;
    data['food'] = food;
    data['food_filter'] = foodFilter;
    data['food_name'] = foodName;
    data['food_recommendation'] = foodRecommendation;
    data['food_request_completed'] = foodRequestCompleted;
    data['forgot_password'] = forgotPassword;
    data['forgot_password_text'] = forgotPasswordText;
    data['found_a_food_that_is_not'] = foundAFoodThatIsNot;
    data['full_name'] = fullName;
    data['gender'] = gender;
    data['get_fitter'] = getFitter;
    data['get_started'] = getStarted;
    data['get_started_exclamation'] = getStartedExclamation;
    data['goals_setting'] = goalsSetting;
    data['good'] = good;
    data['good_greeting'] = goodGreeting;
    data['great'] = great;
    data['great_job_nutrition_on_point'] = greatJobNutritionOnPoint;
    data['height_cm'] = heightCm;
    data['high'] = high;
    data['improve_overall_fitness'] = improveOverallFitness;
    data['keep_with_our_plan'] = keepWithOurPlan;
    data['languages'] = languages;
    data['last_7_days'] = last7Days;
    data['last_name'] = lastName;
    data['lets_make_today_count'] = letsMakeTodayCount;
    data['light_sleep'] = lightSleep;
    data['livewell_nutritional_data_disclaimer'] =
        livewellNutritionalDataDisclaimer;
    data['log_your_first_meal'] = logYourFirstMeal;
    data['logout'] = logout;
    data['low'] = low;
    data['lunch'] = lunch;
    data['male'] = male;
    data['mid'] = mid;
    data['morning'] = morning;
    data['my_goals'] = myGoals;
    data['new_password'] = newPassword;
    data['next'] = next;
    data['no'] = no;
    data['no_results_found'] = noResultsFound;
    data['none'] = none;
    data['number_of_serving'] = numberOfServing;
    data['nutrition'] = nutrition;
    data['nutrient_fact'] = nutrientFact;
    data['nutriscore_details'] = nutriscoreDetails;
    data['of_daily_goals'] = ofDailyGoals;
    data['of_your_goal'] = ofYourGoal;
    data['on_track'] = onTrack;
    data['optimal'] = optimal;
    data['or_sign_in_with'] = orSignInWith;
    data['or_sign_up_with'] = orSignUpWith;
    data['our_team_working_on_your_request'] = ourTeamWorkingOnYourRequest;
    data['password'] = password;
    data['personal_information'] = personalInformation;
    data['physical_information'] = physicalInformation;
    data['picked_based_on_your_nutritional_needs'] =
        pickedBasedOnYourNutritionalNeeds;
    data['please_enter_email_to_reset_password'] =
        pleaseEnterEmailToResetPassword;
    data['poor'] = poor;
    data['pre'] = pre;
    data['prev'] = prev;
    data['privacy_policy'] = privacyPolicy;
    data['processing'] = processing;
    data['projected_weight_after_4_weeks'] = projectedWeightAfter4Weeks;
    data['protein'] = protein;
    data['remaining'] = remaining;
    data['request_food'] = requestFood;
    data['request_new_food'] = requestNewFood;
    data['request_to_delete_account'] = requestToDeleteAccount;
    data['reset_filter'] = resetFilter;
    data['save'] = save;
    data['save_changes'] = saveChanges;
    data['scan_a_barcode'] = scanABarcode;
    data['scan_a_meal'] = scanAMeal;
    data['scan_food'] = scanFood;
    data['search_bar'] = searchBar;
    data['search_here'] = searchHere;
    data['search_result'] = searchResult;
    data['see_details'] = seeDetails;
    data['see_my_progress'] = seeMyProgress;
    data['see_your_progress'] = seeYourProgress;
    data['serving_size'] = servingSize;
    data['set_your_meal_time'] = setYourMealTime;
    data['show_nutrient_facts'] = showNutrientFacts;
    data['sign_in'] = signIn;
    data['sign_up'] = signUp;
    data['sleep'] = sleep;
    data['sleep_hours'] = sleepHours;
    data['snack'] = snack;
    data['specific_goal'] = specificGoal;
    data['steps'] = steps;
    data['submit'] = submit;
    data['target_weight_kg'] = targetWeightKg;
    data['task_list'] = taskList;
    data['terms_and_conditions'] = termsAndConditions;
    data['thank_you'] = thankYou;
    data['thanks_for_creating_account'] = thanksForCreatingAccount;
    data['time'] = time;
    data['to_log_your_first_meal_simply'] = toLogYourFirstMealSimply;
    data['today_you_have_consumed'] = todayYouHaveConsumed;
    data['todays_amount'] = todaysAmount;
    data['track_nutrition'] = trackNutrition;
    data['update'] = update;
    data['update_weight'] = updateWeight;
    data['update_your_weight'] = updateYourWeight;
    data['use_the_searchbar_to'] = useTheSearchbarTo;
    data['view_your_nutriscore'] = viewYourNutriscore;
    data['water_consumed'] = waterConsumed;
    data['water_tracking'] = waterTracking;
    data['weekly_average'] = weeklyAverage;
    data['weight_kg'] = weightKg;
    data['weight_loss'] = weightLoss;
    data['weight_progress'] = weightProgress;
    data['welcome_to_livewell'] = welcomeToLivewell;
    data['well_redirect_after_scanning_result'] =
        wellRedirectAfterScanningResult;
    data['wellness_hub'] = wellnessHub;
    data['went_to_sleep'] = wentToSleep;
    data['woke_up'] = wokeUp;
    data['yes'] = yes;
    data['you_are_ready_to_go'] = youAreReadyToGo;
    data['you_have_gained'] = youHaveGained;
    data['you_have_lost'] = youHaveLost;
    data['you_have_reached'] = youHaveReached;
    data['your_account_and_content_deleted_permanently'] =
        yourAccountAndContentDeletedPermanently;
    data['your_recommended_foods'] = yourRecommendedFoods;
    data['your_value'] = yourValue;
    data['your_water_intake_for_today'] = yourWaterIntakeForToday;
    data['youre_doing_great'] = youreDoingGreat;
    data['youre_doing_great_keep_your_spirit'] = youreDoingGreatKeepYourSpirit;
    data['language'] = language;
    data['Name'] = name;
    data['Gender'] = gender;
    data['how_old_are_you'] = howOldAreYou;
    data['whats_your_weight'] = whatsYourWeight;
    data['any_dietary_restrictions'] = anyDietaryRestrictions;
    data['your_specific_goal'] = yourSpecificGoal;
    data['exerice'] = exerice;
    data['target_weight'] = targetWeight;
    data['finish'] = finish;
    data['200kcal'] = s200kcal;
    data['300kcal'] = s300kcal;
    data['400kcal'] = s400kcal;
    data['select_your_preferred'] = selectYourPreferred;
    data['help_us_to_create_personalize'] = helpUsToCreatePersonalize;
    data['how_many_glasses_of_water'] = howManyGlassesOfWater;
    data['you_can_always_change_this_later'] = youCanAlwaysChangeThisLater;
    data['set_your_fitness_goals'] = setYourFitnessGoals;
    data['how_many_hours_of_sleeps'] = howManyHoursOfSleeps;
    data['whats_your_height'] = whatsYourHeight;
    return data;
  }
}
