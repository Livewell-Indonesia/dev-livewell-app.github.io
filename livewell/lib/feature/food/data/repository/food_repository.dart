import 'dart:convert';
import 'dart:developer';

import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/food/domain/entity/add_meal_param.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/food/domain/entity/meal_history.dart';
import 'package:livewell/feature/food/domain/repository/food_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/log.dart';
import '../../../../core/network/api_url.dart';
import '../../domain/usecase/post_search_food.dart';
import '../model/foods_model.dart';
import 'package:camera/camera.dart';

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
      Log.colorGreen("success get data food history ${data.foods?.length}");
      return Right(data);
    } catch (ex) {
      Log.error(ex);
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, FoodsModel>> searchFood(SearchFoodParams name) async {
    try {
      final response = await postMethod("${Endpoint.foods}/v3",
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

  @override
  Future<Either<Failure, List<CameraDescription>>> getCameras() async {
    final cameras = await availableCameras();
    return Right(cameras);
  }

  @override
  Future<Either<Failure, bool>> addMealHistory(MealHistory params) async {
    final currentHistory = await SharedPref.getMealHistories();
    if (currentHistory.isNotEmpty) {
      final histories = MealHistories.fromJson(jsonDecode(currentHistory));
      histories.mealHistories?.add(params);
      inspect(histories);
      await SharedPref.saveMealHistories(jsonEncode(histories));
    } else {
      final result = MealHistories(mealHistories: []);
      result.mealHistories?.add(params);
      inspect(result);
      await SharedPref.saveMealHistories(jsonEncode(result));
    }
    return const Right(true);
  }

  @override
  Future<Either<Failure, MealHistories>> getMealHistory() async {
    final result = await SharedPref.getMealHistories();
    if (result.isNotEmpty) {
      final response = MealHistories.fromJson(jsonDecode(result));
      return Right(response);
    } else {
      return Right(MealHistories(mealHistories: []));
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> deleteMealHistory(int id) async {
    try {
      final response = await deleteMethod('${Endpoint.deleteMeal}/$id',
          headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      final data = RegisterModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> updateMealHistory(
      MealHistoryModel params) async {
    try {
      final response = await postMethod(Endpoint.updateMeal,
          headers: {authorization: await SharedPref.getToken()},
          body: params.toJson());
      final json = responseHandler(response);
      final data = RegisterModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> requestFood(String foodName) async {
    try {
      final response = await postMethod(Endpoint.requestFood,
          headers: {authorization: await SharedPref.getToken()},
          body: {"name": foodName});
      final json = responseHandler(response);
      final data = RegisterModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
