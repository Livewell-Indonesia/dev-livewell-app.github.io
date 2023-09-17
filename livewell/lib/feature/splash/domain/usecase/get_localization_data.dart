import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/core/localization/localization_model.dart';

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
