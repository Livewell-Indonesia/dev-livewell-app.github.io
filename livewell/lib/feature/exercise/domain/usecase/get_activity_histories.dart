import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/exercise/data/model/activity_history_model.dart';
import 'package:livewell/feature/exercise/data/repository/exercise_repository_impl.dart';
import 'package:livewell/feature/exercise/domain/repository/exercise_repository.dart';

class GetActivityHistory
    extends UseCase<List<ActivityHistoryModel>, GetActivityHistoryParam> {
  late ExerciseRepository repository;
  GetActivityHistory.instance() {
    repository = ExerciseRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, List<ActivityHistoryModel>>> call(
      GetActivityHistoryParam params) async {
    return await repository.getActivityHistory(params);
  }
}

class GetActivityHistoryParam {
  List<String> type;
  DateTime dateFrom;
  DateTime dateTo;

  GetActivityHistoryParam({
    required this.type,
    required this.dateFrom,
    required this.dateTo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['types'] = type;
    data['dateFrom'] = DateFormat('yyyy-MM-dd HH:mm:ss.sss').format(dateFrom);
    data['dateTo'] = DateFormat('yyyy-MM-dd HH:mm:ss.sss').format(dateTo);
    return data;
  }
}
