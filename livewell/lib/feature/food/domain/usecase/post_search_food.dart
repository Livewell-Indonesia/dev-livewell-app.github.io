import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';

import '../../data/repository/food_repository.dart';
import '../repository/food_repository.dart';

class PostSearchFood extends UseCase<FoodsModel, SearchFoodParams> {
  late FoodRepository repository;

  PostSearchFood.instance() {
    repository = FoodRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, FoodsModel>> call(SearchFoodParams params) async {
    return await repository.searchFood(params);
  }
}

class SearchFoodParams {
  String query;
  SearchFoodParams({required this.query});

  Map<String, dynamic> toJson() {
    return {
      'name': query,
    };
  }
}
