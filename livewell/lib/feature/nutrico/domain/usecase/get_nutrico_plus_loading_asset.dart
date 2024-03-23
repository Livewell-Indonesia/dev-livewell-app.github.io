import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_plus_asset_loading_model.dart';
import 'package:livewell/feature/nutrico/data/repository/nutrico_repository_impl.dart';
import 'package:livewell/feature/nutrico/domain/repository/nutrico_repository.dart';

class GetNutricoPlusLoadingAssets extends UseCase<List<NutricoPlusAssetLoadingModel>, NoParams> {
  late NutricoRepository repository;

  GetNutricoPlusLoadingAssets(this.repository);

  GetNutricoPlusLoadingAssets.instance() {
    repository = NutricoRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, List<NutricoPlusAssetLoadingModel>>> call(NoParams params) async {
    return await repository.getNutricoLoadingAsset();
  }
}
