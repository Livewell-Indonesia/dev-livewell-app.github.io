import 'package:dartz/dartz.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/update_weight/domain/usecase/update_user_weight.dart';

import '../../../../core/error/failures.dart';

abstract class UpdateWeightRepository {
  Future<Either<Failure, RegisterModel>> updateWeight(
      UpdateWeightParams params);
}
