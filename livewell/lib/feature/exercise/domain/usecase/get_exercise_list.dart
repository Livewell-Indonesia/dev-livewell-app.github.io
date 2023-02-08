import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/exercise/data/model/activity_data_model.dart';
import 'package:livewell/feature/exercise/data/repository/exercise_repository_impl.dart';
import 'package:livewell/feature/exercise/domain/repository/exercise_repository.dart';

class GetExerciseData extends UseCase<ActivityDataModel, GetExerciseParams> {
  late ExerciseRepository repository;
  GetExerciseData.instance() {
    repository = ExerciseRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, ActivityDataModel>> call(
      GetExerciseParams params) async {
    return await repository.getExerciseData(params);
  }
}

class GetExerciseParams {
  String type;
  DateTime dateFrom;
  DateTime dateTo;

  GetExerciseParams({
    required this.type,
    required this.dateFrom,
    required this.dateTo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['dateFrom'] = DateFormat('yyyy-MM-dd HH:mm:ss.sss').format(dateFrom);
    data['dateTo'] = DateFormat('yyyy-MM-dd HH:mm:ss.sss').format(dateTo);
    return data;
  }
}
