import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/repository/food_repository.dart';
import '../repository/food_repository.dart';

class GetFoodHistory implements UseCase<FoodsModel, NoParams> {
  late FoodRepository repository;

  GetFoodHistory.instance() {
    repository = FoodRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, FoodsModel>> call(NoParams params) async {
    return await repository.getFoodHistory();
  }
}
