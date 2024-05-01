import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_plus_tutorial_asset_model.dart';
import 'package:livewell/feature/nutrico/data/repository/nutrico_repository_impl.dart';
import 'package:livewell/feature/nutrico/domain/repository/nutrico_repository.dart';

class GetNutricoPlusTutorialAsset extends UseCase<NutricoPlusTutorialAssetModel, NoParams> {
  late NutricoRepository repository;

  GetNutricoPlusTutorialAsset(this.repository);

  GetNutricoPlusTutorialAsset.instance() {
    repository = NutricoRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, NutricoPlusTutorialAssetModel>> call(NoParams params) async {
    return await repository.getNutricoPlusTutorialAsset();
  }
}
