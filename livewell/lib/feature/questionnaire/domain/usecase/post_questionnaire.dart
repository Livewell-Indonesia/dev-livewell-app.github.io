import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/questionnaire/data/repository/questionnaire_repository_impl.dart';
import 'package:livewell/feature/questionnaire/domain/repository/questionnaire_repository.dart';

import '../../../../core/error/failures.dart';

class PostQuestionnaire extends UseCase<RegisterModel, QuestionnaireParams> {
  late QuestionnaireRepository repository;

  PostQuestionnaire.instance() {
    repository = QuestionnaireRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, RegisterModel>> call(QuestionnaireParams params) {
    return repository.postQuestionnaire(params);
  }
}

class QuestionnaireParams {
  String? firstName;
  String? lastName;
  String? dob;
  String? gender;
  num? height;
  num? weight;
  num? targetWeight;
  num? exerciseGoalKcal;
  OnboardingQuestionnaire? onboardingQuestionnaire;

  QuestionnaireParams(
      {this.firstName,
      this.lastName,
      this.dob,
      this.gender,
      this.height,
      this.weight,
      this.targetWeight,
      this.onboardingQuestionnaire,
      this.exerciseGoalKcal});

  QuestionnaireParams.asParams(
      this.firstName,
      this.lastName,
      this.gender,
      String age,
      this.weight,
      this.height,
      this.targetWeight,
      this.exerciseGoalKcal,
      String drink,
      String sleep,
      String dietraryRestriction,
      String goal) {
    dob = age;
    onboardingQuestionnaire = OnboardingQuestionnaire(
      dietaryRestrictions: [dietraryRestriction],
      sleepDuration: sleep,
      glassesOfWaterDaily: drink,
      targetImprovement: [goal],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['dob'] = dob;
    data['gender'] = gender;
    data['height'] = height;
    data['weight'] = weight;
    data['exercise_goal_kcal'] = exerciseGoalKcal;
    if (onboardingQuestionnaire!.targetImprovement != null &&
        !onboardingQuestionnaire!.targetImprovement!
            .contains("Better Sleeping")) {
      data['weight_target'] = targetWeight;
    }
    if (onboardingQuestionnaire != null) {
      data['onboarding_questionnaire'] = onboardingQuestionnaire!.toJson();
    }
    return data;
  }
}

class OnboardingQuestionnaire {
  List<String>? dietaryRestrictions;
  String? sleepDuration;
  String? glassesOfWaterDaily;
  List<String>? targetImprovement;

  OnboardingQuestionnaire(
      {this.dietaryRestrictions,
      this.sleepDuration,
      this.glassesOfWaterDaily,
      this.targetImprovement});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dietary_restrictions'] = dietaryRestrictions;
    data['sleep_duration'] = sleepDuration;
    data['glasses_of_water_daily'] = glassesOfWaterDaily;
    data['target_improvement'] = targetImprovement;
    return data;
  }
}
