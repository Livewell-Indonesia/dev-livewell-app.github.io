import 'dart:convert';

import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/domain/repository/diary_repository.dart';
import 'package:livewell/feature/diary/domain/usecase/get_user_meal_history.dart';

import '../../../../core/local_storage/shared_pref.dart';

class DiaryRepositoryImpl extends NetworkModule implements DiaryRepostiory {
  DiaryRepositoryImpl._();
  static DiaryRepositoryImpl getInstance() => DiaryRepositoryImpl._();
  @override
  Future<Either<Failure, UserMealHistoryModel>> getUserMealHistory(
      UserMealHistoryParams params) async {
    try {
      var response = await postMethod(Endpoint.userMealHistory,
          headers: {authorization: await SharedPref.getToken()},
          body: params.toJson());
      var responseJson = responseHandler(response);
      return Right(UserMealHistoryModel.fromJson(responseJson));
    } catch (ex) {
      Log.error(ex.toString());
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
