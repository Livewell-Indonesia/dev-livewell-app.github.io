import 'package:dartz/dartz.dart';
import 'package:health/health.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/exercise/domain/repository/exercise_repository.dart';

import '../../data/repository/exercise_repository_impl.dart';

class PostExerciseData extends UseCase<RegisterModel, PostExerciseParams> {
  late ExerciseRepository repository;
  PostExerciseData.instance() {
    repository = ExerciseRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, RegisterModel>> call(PostExerciseParams params) async {
    return await repository.postExerciseData(params);
  }
}

class PostExerciseParams {
  final List<HealthDataPoint> activities;
  PostExerciseParams({required this.activities});

  Map<String, dynamic> toJson() {
    return {
      'activities': activities,
    };
  }
}
