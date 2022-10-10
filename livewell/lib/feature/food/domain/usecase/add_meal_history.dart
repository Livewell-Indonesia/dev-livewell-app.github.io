import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/feature/food/domain/entity/meal_history.dart';

import '../../../../core/base/usecase.dart';
import '../../data/repository/food_repository.dart';
import '../repository/food_repository.dart';

class AddMealHistory extends UseCase<bool, MealHistory> {
  late FoodRepository repository;

  AddMealHistory.instance() {
    repository = FoodRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, bool>> call(MealHistory params) async {
    return await repository.addMealHistory(params);
  }
}
