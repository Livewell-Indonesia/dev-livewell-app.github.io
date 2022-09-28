import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';

import '../../data/repository/food_repository.dart';
import '../entity/add_meal_param.dart';
import '../repository/food_repository.dart';

class AddMeal extends UseCase<RegisterModel, AddMealParams> {
  late FoodRepository repository;

  AddMeal.instance() {
    repository = FoodRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, RegisterModel>> call(AddMealParams params) {
    return repository.addMeal(params);
  }
}
