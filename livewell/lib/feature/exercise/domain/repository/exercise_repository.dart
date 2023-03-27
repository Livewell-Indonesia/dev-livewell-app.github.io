import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/exercise/data/model/activity_data_model.dart';
import 'package:livewell/feature/exercise/data/model/activity_history_model.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_activity_histories.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_exercise_list.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';

abstract class ExerciseRepository {
  Future<Either<Failure, RegisterModel>> postExerciseData(
      PostExerciseParams params);

  Future<Either<Failure, ActivityDataModel>> getExerciseData(
      GetExerciseParams params);
  Future<Either<Failure, List<ActivityHistoryModel>>> getActivityHistory(
      GetActivityHistoryParam params);
}
