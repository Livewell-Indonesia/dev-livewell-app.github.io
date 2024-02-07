import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/nutriscore/data/repository/nutri_score_repository_impl.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_model.dart';
import 'package:livewell/feature/nutriscore/domain/repository/nutri_score_repository.dart';

class GetNutriScore extends UseCase<NutriScoreModel, NoParams> {
  late NutriscoreRepository repository;

  GetNutriScore.instance() {
    repository = NutriscoreRepositoryImpl.getInstance();
  }

  Future<Either<Failure, NutriScoreModel>> call(NoParams params) async {
    return await repository.getNutriscore();
  }
}
