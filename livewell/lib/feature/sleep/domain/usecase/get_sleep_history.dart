import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/sleep/data/model/sleep_history_model.dart';
import 'package:livewell/feature/sleep/data/repository/sleep_repository_impl.dart';
import 'package:livewell/feature/sleep/domain/repository/sleep_repository.dart';

class GetSleepHistory
    extends UseCase<SleepHistoryModel, GetSleepHistoryParams> {
  late SleepRepository repository;
  GetSleepHistory.instance() {
    repository = SleepRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, SleepHistoryModel>> call(
      GetSleepHistoryParams params) async {
    return await repository.getSleepHistory(params);
  }
}

class GetSleepHistoryParams {
  String dateFrom;
  String dateTo;

  GetSleepHistoryParams({
    required this.dateFrom,
    required this.dateTo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateFrom'] = dateFrom;
    data['dateTo'] = dateTo;
    return data;
  }
}
