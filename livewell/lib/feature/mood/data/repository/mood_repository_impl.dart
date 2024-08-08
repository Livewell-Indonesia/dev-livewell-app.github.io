import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/mood/data/model/mood_detail_model.dart';
import 'package:livewell/feature/mood/data/model/mood_model.dart';
import 'package:livewell/feature/mood/domain/repository/mood_repository.dart';

class MoodRepositoryImpl with NetworkModule implements MoodRepository {
  MoodRepositoryImpl._();

  static MoodRepositoryImpl getInstance() => MoodRepositoryImpl._();
  @override
  Future<Either<Failure, MoodsModel>> getMoods(int value) async {
    try {
      final response = await getMethod(Endpoint.getListMood, headers: {
        authorization: await SharedPref.getToken(),
      }, param: {
        "limit": value
      });
      final json = responseHandler(response);
      return Right(MoodsModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, MoodDetail>> getSingleMood(String date) async {
    try {
      final response = await getMethod(Endpoint.getDetailMood, headers: {
        authorization: await SharedPref.getToken(),
      }, param: {
        "date": date
      });
      final json = responseHandler(response);
      return Right(MoodDetail.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
