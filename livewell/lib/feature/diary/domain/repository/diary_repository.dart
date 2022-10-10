import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/user_meal_history_model.dart';
import '../usecase/get_user_meal_history.dart';

abstract class DiaryRepostiory {
  Future<Either<Failure, UserMealHistoryModel>> getUserMealHistory(
      UserMealHistoryParams params);
}
