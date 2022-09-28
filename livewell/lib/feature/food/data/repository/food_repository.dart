import 'package:dartz/dartz.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/food/domain/entity/add_meal_param.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/food/domain/repository/food_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/log.dart';
import '../../../../core/network/api_url.dart';
import '../../domain/usecase/post_search_food.dart';
import '../model/foods_model.dart';

class FoodRepositoryImpl extends NetworkModule implements FoodRepository {
  FoodRepositoryImpl._();

  static FoodRepositoryImpl getInstance() => FoodRepositoryImpl._();

  @override
  Future<Either<Failure, FoodsModel>> getFoodHistory() async {
    try {
      final response = await postMethod(Endpoint.foods,
          body: {"name": ""},
          headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      final data = FoodsModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      Log.error(ex);
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, FoodsModel>> searchFood(SearchFoodParams name) async {
    try {
      final response = await postMethod(Endpoint.foods,
          body: name.toJson(),
          headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      final data = FoodsModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      Log.error(ex);
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> addMeal(AddMealParams params) async {
    try {
      final response = await postMethod(Endpoint.addMeal,
          body: params.toJson(),
          headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      final data = RegisterModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      Log.error(ex);
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
