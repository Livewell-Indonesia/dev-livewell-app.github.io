import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/food/domain/repository/food_repository.dart';

import '../../data/repository/food_repository.dart';

class PostRequestFood extends UseCase<RegisterModel, String> {
  late FoodRepository repository;

  PostRequestFood.instance() {
    repository = FoodRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, RegisterModel>> call(String params) async {
    return await repository.requestFood(params);
  }
}
