class UserModel {
  String? email;
  String? mcc;
  String? phoneNumber;
  String? referenceId;
  String? status;
  String? firstName;
  String? lastName;
  String? birthDate;
  String? gender;
  num? height;
  num? weight;
  num? bmi;
  num? bmr;
  int? weightTarget;
  List<DailyJournal>? dailyJournal;
  OnboardingQuestionnaire? onboardingQuestionnaire;
  String? lastSyncedAt;
  int? exerciseGoalKcal;
  int? stepsGoalCount;

  UserModel(
      {this.email,
      this.mcc,
      this.phoneNumber,
      this.referenceId,
      this.status,
      this.firstName,
      this.lastName,
      this.birthDate,
      this.gender,
      this.height,
      this.weight,
      this.bmi,
      this.bmr,
      this.weightTarget,
      this.dailyJournal,
      this.onboardingQuestionnaire,
      this.lastSyncedAt,
      this.exerciseGoalKcal,
      this.stepsGoalCount});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mcc = json['mcc'];
    phoneNumber = json['phone_number'];
    referenceId = json['reference_id'];
    status = json['status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
    bmi = json['bmi'];
    bmr = json['bmr'];
    lastSyncedAt = json['last_synced_at'];
    exerciseGoalKcal = json['exercise_goal_kcal'];
    stepsGoalCount = json['steps_goal_count'];
    weightTarget = json['weight_target'];
    if (json['daily_journal'] != null) {
      dailyJournal = <DailyJournal>[];
      json['daily_journal'].forEach((v) {
        dailyJournal!.add(DailyJournal.fromJson(v));
      });
    }
    onboardingQuestionnaire = json['onboarding_questionnaire'] != null
        ? OnboardingQuestionnaire.fromJson(json['onboarding_questionnaire'])
        : null;
  }

  // create copyWith
  UserModel copyWith({
    String? email,
    String? mcc,
    String? phoneNumber,
    String? referenceId,
    String? status,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? gender,
    num? height,
    num? weight,
    num? bmi,
    num? bmr,
    int? weightTarget,
    List<DailyJournal>? dailyJournal,
    OnboardingQuestionnaire? onboardingQuestionnaire,
    String? lastSyncedAt,
    int? exerciseGoalKcal,
    int? stepsGoalCount,
  }) {
    return UserModel(
      email: email ?? this.email,
      mcc: mcc ?? this.mcc,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      referenceId: referenceId ?? this.referenceId,
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
      bmr: bmr ?? this.bmr,
      weightTarget: weightTarget ?? this.weightTarget,
      dailyJournal: dailyJournal ?? this.dailyJournal,
      onboardingQuestionnaire:
          onboardingQuestionnaire ?? this.onboardingQuestionnaire,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      exerciseGoalKcal: exerciseGoalKcal ?? this.exerciseGoalKcal,
      stepsGoalCount: stepsGoalCount ?? this.stepsGoalCount,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['mcc'] = mcc;
    data['phone_number'] = phoneNumber;
    data['reference_id'] = referenceId;
    data['status'] = status;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['birth_date'] = birthDate;
    data['gender'] = gender;
    data['height'] = height;
    data['weight'] = weight;
    data['bmi'] = bmi;
    data['bmr'] = bmr;
    data['weight_target'] = weightTarget;
    if (dailyJournal != null) {
      data['daily_journal'] = dailyJournal!.map((v) => v.toJson()).toList();
    }
    if (onboardingQuestionnaire != null) {
      data['onboarding_questionnaire'] = onboardingQuestionnaire!.toJson();
    }
    return data;
  }
}

class DailyJournal {
  String? name;
  String? time;

  DailyJournal({this.name, this.time});

  DailyJournal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['time'] = time;
    return data;
  }
}

class OnboardingQuestionnaire {
  String? describePhysicalHealth;
  List<String>? dietaryRestrictions;
  Null? eatingHabits;
  String? exercisePerWeek;
  String? feelAboutChange;
  String? glassesOfWaterDaily;
  String? mealType;
  String? sleepDuration;
  String? sleepProblem;
  Null? sourceOfCarbs;
  List<String>? targetImprovement;
  Null? userRawFoodMaterial;

  OnboardingQuestionnaire(
      {this.describePhysicalHealth,
      this.dietaryRestrictions,
      this.eatingHabits,
      this.exercisePerWeek,
      this.feelAboutChange,
      this.glassesOfWaterDaily,
      this.mealType,
      this.sleepDuration,
      this.sleepProblem,
      this.sourceOfCarbs,
      this.targetImprovement,
      this.userRawFoodMaterial});

  OnboardingQuestionnaire.fromJson(Map<String, dynamic> json) {
    describePhysicalHealth = json['describe_physical_health'];
    dietaryRestrictions = json['dietary_restrictions'].cast<String>();
    eatingHabits = json['eating_habits'];
    exercisePerWeek = json['exercise_per_week'];
    feelAboutChange = json['feel_about_change'];
    glassesOfWaterDaily = json['glasses_of_water_daily'];
    mealType = json['meal_type'];
    sleepDuration = json['sleep_duration'];
    sleepProblem = json['sleep_problem'];
    sourceOfCarbs = json['source_of_carbs'];
    targetImprovement = json['target_improvement'] is String
        ? [json['target_improvement']]
        : json['target_improvement'].cast<String>();
    userRawFoodMaterial = json['user_raw_food_material'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['describe_physical_health'] = describePhysicalHealth;
    data['dietary_restrictions'] = dietaryRestrictions;
    data['eating_habits'] = eatingHabits;
    data['exercise_per_week'] = exercisePerWeek;
    data['feel_about_change'] = feelAboutChange;
    data['glasses_of_water_daily'] = glassesOfWaterDaily;
    data['meal_type'] = mealType;
    data['sleep_duration'] = sleepDuration;
    data['sleep_problem'] = sleepProblem;
    data['source_of_carbs'] = sourceOfCarbs;
    data['target_improvement'] = targetImprovement;
    data['user_raw_food_material'] = userRawFoodMaterial;
    return data;
  }
}
