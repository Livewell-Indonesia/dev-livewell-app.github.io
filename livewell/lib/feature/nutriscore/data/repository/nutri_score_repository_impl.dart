import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_detail_model.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';
import 'package:livewell/feature/nutriscore/domain/repository/nutri_score_repository.dart';

class NutriscoreRepositoryImpl extends NetworkModule
    implements NutriscoreRepository {
  NutriscoreRepositoryImpl._();
  static NutriscoreRepositoryImpl getInstance() => NutriscoreRepositoryImpl._();
  @override
  Future<Either<Failure, NutriScoreModel>> getNutriscore() async {
    try {
      var response = await getMethod(Endpoint.getNutriscore, headers: {
        authorization: await SharedPref.getToken(),
      });
      var responseJson = responseHandler(response);
      return Right(NutriScoreModel.fromJson(responseJson));
    } catch (ex) {
      Log.error(ex.toString());
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NutriscoreDetailModel>>>
      getNutriscoreDetail() async {
    try {
      var response = await getMethod(Endpoint.getNutriscoreDetail, headers: {
        authorization: await SharedPref.getToken(),
      });
      var responseJson = responseHandler(response);
      return Right(List<NutriscoreDetailModel>.from(
          responseJson.map((x) => NutriscoreDetailModel.fromJson(x))));
    } catch (ex) {
      Log.error(ex.toString());
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
