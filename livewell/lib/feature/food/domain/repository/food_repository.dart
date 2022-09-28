import 'package:dartz/dartz.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/domain/usecase/post_search_food.dart';

import '../../../../core/error/failures.dart';
import '../entity/add_meal_param.dart';

abstract class FoodRepository {
  Future<Either<Failure, FoodsModel>> getFoodHistory();
  Future<Either<Failure, FoodsModel>> searchFood(SearchFoodParams name);
  Future<Either<Failure, RegisterModel>> addMeal(AddMealParams params);
}
