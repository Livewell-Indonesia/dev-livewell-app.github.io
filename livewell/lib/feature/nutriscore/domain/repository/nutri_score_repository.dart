import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_detail_model.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';

abstract class NutriscoreRepository {
  Future<Either<Failure, NutriScoreModel>> getNutriscore();
  Future<Either<Failure, List<NutriscoreDetailModel>>> getNutriscoreDetail();
}
