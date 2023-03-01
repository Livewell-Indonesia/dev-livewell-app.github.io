import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/nutriscore/data/repository/nutri_score_repository_impl.dart';
import 'package:livewell/feature/nutriscore/domain/entity/nutri_score_detail_model.dart';
import 'package:livewell/feature/nutriscore/domain/repository/nutri_score_repository.dart';

class GetNutriscoreDetail
    extends UseCase<List<NutriscoreDetailModel>, NoParams> {
  late NutriscoreRepository repository;

  GetNutriscoreDetail.instance() {
    repository = NutriscoreRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, List<NutriscoreDetailModel>>> call(
      NoParams params) async {
    return await repository.getNutriscoreDetail();
  }
}
