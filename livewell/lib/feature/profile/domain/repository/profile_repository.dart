import 'package:dartz/dartz.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/profile/domain/usecase/update_user_info.dart';

import '../../../../core/error/failures.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, RegisterModel>> updateUserProfile(
      UpdateUserInfoParams params);
}
