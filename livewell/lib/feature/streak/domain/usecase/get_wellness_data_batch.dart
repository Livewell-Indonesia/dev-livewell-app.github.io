import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/streak/data/model/wellness_batch_data_model.dart';
import 'package:livewell/feature/streak/data/repository/wellness_repository_impl.dart';
import 'package:livewell/feature/streak/domain/repository/wellness_repository.dart';

class GetWellnessDataBatch extends UseCase<WellnessBatchModel, GetWellnessDataBatchParams> {
  late WellnessRepository repository;

  GetWellnessDataBatch.instance() {
    repository = WellnessRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, WellnessBatchModel>> call(GetWellnessDataBatchParams params) async {
    return await repository.getWellnessBatch(params);
  }
}

class GetWellnessDataBatchParams {
  final DateTime dateFrom;
  final DateTime dateTo;

  GetWellnessDataBatchParams({required this.dateFrom, required this.dateTo});

  Map<String, dynamic> toJson() {
    return {
      'date_from': DateFormat('yyyy-MM-dd').format(dateFrom),
      'date_to': DateFormat('yyyy-MM-dd').format(dateTo),
    };
  }
}
