import 'package:dartz/dartz.dart';
import 'package:health/health.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';

abstract class ExerciseRepository {
  Future<Either<Failure, RegisterModel>> postExerciseData(
      PostExerciseParams params);
}
