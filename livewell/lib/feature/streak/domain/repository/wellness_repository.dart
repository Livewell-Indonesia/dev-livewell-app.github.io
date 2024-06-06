import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/streak/data/model/wellness_batch_data_model.dart';
import 'package:livewell/feature/streak/data/model/wellness_detail_model.dart';
import 'package:livewell/feature/streak/domain/usecase/get_wellness_data_batch.dart';

abstract class WellnessRepository {
  Future<Either<Failure, WellnessBatchModel>> getWellnessBatch(GetWellnessDataBatchParams params);
  Future<Either<Failure, WellnessDetailModel>> getWellnessDetail(DateTime date);
  Future<Either<Failure, String>> refreshWellness(String type);
  Future<Either<Failure, int>> getStreakTotal();
}
