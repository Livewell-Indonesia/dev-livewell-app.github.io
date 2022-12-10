import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/exercise/data/model/activity_data_model.dart';
import 'package:livewell/feature/exercise/data/repository/exercise_repository_impl.dart';
import 'package:livewell/feature/exercise/domain/repository/exercise_repository.dart';

class GetExerciseData
    extends UseCase<List<ActivityDataModel>, GetExerciseParams> {
  late ExerciseRepository repository;
  GetExerciseData.instance() {
    repository = ExerciseRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, List<ActivityDataModel>>> call(
      GetExerciseParams params) async {
    return await repository.getExerciseData(params);
  }
}

class GetExerciseParams {
  String type;

  GetExerciseParams({required this.type});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}
