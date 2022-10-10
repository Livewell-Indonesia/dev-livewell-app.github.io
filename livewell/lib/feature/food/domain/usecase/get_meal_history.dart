import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/food/domain/entity/meal_history.dart';

import '../../../../core/error/failures.dart';
import '../../data/repository/food_repository.dart';
import '../repository/food_repository.dart';

class GetMealHistory extends UseCase<MealHistories, NoParams> {
  late FoodRepository repository;

  GetMealHistory.instance() {
    repository = FoodRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, MealHistories>> call(NoParams params) async {
    return await repository.getMealHistory();
  }
}
