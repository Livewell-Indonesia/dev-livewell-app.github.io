import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/core/localization/localization_model.dart';
import 'package:livewell/core/localization/localization_model_v2.dart';

abstract class SplashRepository {
  Future<Either<Failure, Localization>> getLocalizationData();
  Future<Either<Failure, LocalizationModelV2>> getLocalizationDataV2();
}
