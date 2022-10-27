import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/repository/food_repository.dart';
import '../repository/food_repository.dart';

class DeleteMealHistory extends UseCase<RegisterModel, int> {
  late FoodRepository repository;

  DeleteMealHistory.instance() {
    repository = FoodRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, RegisterModel>> call(int params) async {
    return await repository.deleteMealHistory(params);
  }
}
