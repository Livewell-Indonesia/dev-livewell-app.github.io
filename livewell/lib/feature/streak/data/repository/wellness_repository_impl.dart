import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/streak/data/model/wellness_batch_data_model.dart';
import 'package:livewell/feature/streak/data/model/wellness_detail_model.dart';
import 'package:livewell/feature/streak/domain/repository/wellness_repository.dart';
import 'package:livewell/feature/streak/domain/usecase/get_wellness_data_batch.dart';

class WellnessRepositoryImpl extends WellnessRepository with NetworkModule {
  WellnessRepositoryImpl._();

  static WellnessRepositoryImpl getInstance() => WellnessRepositoryImpl._();

  @override
  Future<Either<Failure, WellnessBatchModel>> getWellnessBatch(GetWellnessDataBatchParams params) async {
    try {
      final response = await getMethod(Endpoint.wellness, param: params.toJson(), headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      return Right(WellnessBatchModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, WellnessDetailModel>> getWellnessDetail(DateTime date) async {
    try {
      final response = await getMethod(Endpoint.wellnessDetail, param: {'date': DateFormat('yyyy-MM-dd').format(date)}, headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      return Right(WellnessDetailModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> refreshWellness(String type) async {
    try {
      await postMethod(Endpoint.wellnessRefresh, body: {'type': type, 'record_at': DateFormat('yyyy-MM-dd').format(DateTime.now())}, headers: {authorization: await SharedPref.getToken()});
      return const Right('Success');
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getStreakTotal() async {
    try {
      final response = await getMethod(Endpoint.streakTotal, headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      return Right(json['response']['total']);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  Future<Either<Failure, String>> getWellnessRecommendation() async {
    try {
      final response = await postMethod(Endpoint.wellnessRecommendation, headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      return Right(json['response']['content']);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
