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
  int? height;
  int? weight;
  num? bmi;
  num? bmr;
  int? weightTarget;
  List<DailyJournal>? dailyJournal;
  OnboardingQuestionnaire? onboardingQuestionnaire;

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
      this.onboardingQuestionnaire});

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
    weightTarget = json['weight_target'];
    if (json['daily_journal'] != null) {
      dailyJournal = <DailyJournal>[];
      json['daily_journal'].forEach((v) {
        dailyJournal!.add(new DailyJournal.fromJson(v));
      });
    }
    onboardingQuestionnaire = json['onboarding_questionnaire'] != null
        ? new OnboardingQuestionnaire.fromJson(json['onboarding_questionnaire'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['mcc'] = this.mcc;
    data['phone_number'] = this.phoneNumber;
    data['reference_id'] = this.referenceId;
    data['status'] = this.status;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['birth_date'] = this.birthDate;
    data['gender'] = this.gender;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['bmi'] = this.bmi;
    data['bmr'] = this.bmr;
    data['weight_target'] = this.weightTarget;
    if (this.dailyJournal != null) {
      data['daily_journal'] =
          this.dailyJournal!.map((v) => v.toJson()).toList();
    }
    if (this.onboardingQuestionnaire != null) {
      data['onboarding_questionnaire'] = this.onboardingQuestionnaire!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['time'] = this.time;
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
    targetImprovement = json['target_improvement'].cast<String>();
    userRawFoodMaterial = json['user_raw_food_material'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['describe_physical_health'] = this.describePhysicalHealth;
    data['dietary_restrictions'] = this.dietaryRestrictions;
    data['eating_habits'] = this.eatingHabits;
    data['exercise_per_week'] = this.exercisePerWeek;
    data['feel_about_change'] = this.feelAboutChange;
    data['glasses_of_water_daily'] = this.glassesOfWaterDaily;
    data['meal_type'] = this.mealType;
    data['sleep_duration'] = this.sleepDuration;
    data['sleep_problem'] = this.sleepProblem;
    data['source_of_carbs'] = this.sourceOfCarbs;
    data['target_improvement'] = this.targetImprovement;
    data['user_raw_food_material'] = this.userRawFoodMaterial;
    return data;
  }
}
