import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/profile/data/repository/profile_repository_impl.dart';

import '../../../../core/error/failures.dart';
import '../repository/profile_repository.dart';

class UpdateUserInfo extends UseCase<RegisterModel, UpdateUserInfoParams> {
  late UserProfileRepository repository;

  UpdateUserInfo.instance() {
    repository = UserProfileRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, RegisterModel>> call(
      UpdateUserInfoParams params) async {
    return await repository.updateUserProfile(params);
  }
}

class UpdateUserInfoParams {
  String firstName;
  String lastName;
  String dob;
  String gender;
  num height;
  num weight;
  num weightTarget;
  num exerciseGoalKcal;

  UpdateUserInfoParams(
      {required this.firstName,
      required this.lastName,
      required this.dob,
      required this.gender,
      required this.height,
      required this.weight,
      required this.weightTarget,
      required this.exerciseGoalKcal});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['dob'] = dob;
    data['gender'] = gender;
    data['height'] = height;
    data['weight'] = weight;
    data['weight_target'] = weightTarget;
    data['exercise_goal_kcal'] = exerciseGoalKcal;
    return data;
  }
}
