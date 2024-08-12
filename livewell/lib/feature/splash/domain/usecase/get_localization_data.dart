import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/core/localization/localization_model.dart';
import 'package:livewell/core/localization/localization_model_v2.dart';

import '../../data/repository/splash_repository_impl.dart';
import '../repository/splash_repository.dart';

class GetLocalizationData extends UseCase<Localization, NoParams> {
  late SplashRepository repository;

  GetLocalizationData.instance() {
    repository = SplashRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, Localization>> call(NoParams params) async {
    return await repository.getLocalizationData();
  }
}

class GetLocalizationDataV2 extends UseCase<LocalizationModelV2, NoParams> {
  late SplashRepository repository;

  GetLocalizationDataV2.instance() {
    repository = SplashRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, LocalizationModelV2>> call(NoParams params) async {
    return await repository.getLocalizationDataV2();
  }
}
