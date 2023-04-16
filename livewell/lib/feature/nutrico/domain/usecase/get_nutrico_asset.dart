import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_asset_model.dart';
import 'package:livewell/feature/nutrico/data/repository/nutrico_repository_impl.dart';
import 'package:livewell/feature/nutrico/domain/repository/nutrico_repository.dart';
import 'package:livewell/feature/nutrico/domain/usecase/post_nutrico.dart';

class GetNutricoAsset extends UseCase<NutricoAsset, NoParams> {
  late NutricoRepository repository;

  GetNutricoAsset.instance() {
    repository = NutricoRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, NutricoAsset>> call(NoParams params) async {
    return await repository.getNutricoAsset();
  }
}
