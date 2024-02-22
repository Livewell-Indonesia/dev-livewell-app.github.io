import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/sleep/data/model/sleep_activity_model.dart';
import 'package:livewell/feature/sleep/data/model/sleep_history_model.dart';
import 'package:livewell/feature/sleep/domain/repository/sleep_repository.dart';
import 'package:livewell/feature/sleep/domain/usecase/get_sleep_history.dart';
import 'package:livewell/feature/sleep/domain/usecase/get_sleep_list.dart';

class SleepRepositoryImpl with NetworkModule implements SleepRepository {
  SleepRepositoryImpl._();

  static SleepRepositoryImpl getInstance() => SleepRepositoryImpl._();

  @override
  Future<Either<Failure, List<SleepActivityModel>>> getSleepData(
      GetSleepParams params) async {
    try {
      final response = await postMethod(Endpoint.getSleeps,
          headers: {authorization: await SharedPref.getToken()},
          body: params.toJson());
      final json = responseHandler(response);
      final hasil = List<SleepActivityModel>.from(
          json.map((x) => SleepActivityModel.fromJson(x)));
      return Right(hasil);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, SleepHistoryModel>> getSleepHistory(
      GetSleepHistoryParams params) async {
    try {
      final response = await postMethod(Endpoint.getSleepHistory,
          headers: {authorization: await SharedPref.getToken()},
          body: params.toJson());
      final json = responseHandler(response);

      final hasil = SleepHistoryModel.fromJson(json);
      return Right(hasil);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
