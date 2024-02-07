import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/core/localization/localization_model.dart';

abstract class SplashRepository {
  Future<Either<Failure, Localization>> getLocalizationData();
}
