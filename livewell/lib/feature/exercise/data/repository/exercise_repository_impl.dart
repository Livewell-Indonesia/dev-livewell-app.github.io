import 'package:health/health.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/exercise/data/model/activity_data_model.dart';
import 'package:livewell/feature/exercise/domain/repository/exercise_repository.dart';
import 'package:livewell/feature/exercise/domain/usecase/get_exercise_list.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';

class ExerciseRepositoryImpl extends NetworkModule
    implements ExerciseRepository {
  ExerciseRepositoryImpl._();

  static ExerciseRepositoryImpl getInstance() => ExerciseRepositoryImpl._();
  @override
  Future<Either<Failure, RegisterModel>> postExerciseData(
      PostExerciseParams data) async {
    try {
      final response = await postMethod(Endpoint.postBulkActivities,
          headers: {authorization: await SharedPref.getToken()},
          body: data.toJson());
      Log.colorGreen(data.toJson());
      final json = responseHandler(response);
      return Right(RegisterModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, ActivityDataModel>> getExerciseData(
      GetExerciseParams params) async {
    try {
      final response = await postMethod(Endpoint.getActivities,
          headers: {authorization: await SharedPref.getToken()},
          body: params.toJson());
      final json = responseHandler(response);
      return Right(ActivityDataModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
