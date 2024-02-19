import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/sleep/data/model/sleep_activity_model.dart';
import 'package:livewell/feature/sleep/data/model/sleep_history_model.dart';
import 'package:livewell/feature/sleep/domain/usecase/get_sleep_history.dart';
import 'package:livewell/feature/sleep/domain/usecase/get_sleep_list.dart';

abstract class SleepRepository {
  Future<Either<Failure, List<SleepActivityModel>>> getSleepData(
      GetSleepParams params);
  Future<Either<Failure, SleepHistoryModel>> getSleepHistory(
      GetSleepHistoryParams params);
}
