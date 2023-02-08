import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';

import '../../../../core/base/usecase.dart';
import '../../data/repository/food_repository.dart';
import '../repository/food_repository.dart';

class UpdateFoodHistory extends UseCase<RegisterModel, MealHistoryModel> {
  late FoodRepository repository;

  UpdateFoodHistory.instance() {
    repository = FoodRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, RegisterModel>> call(MealHistoryModel params) async {
    return await repository.updateMealHistory(params);
  }
}
