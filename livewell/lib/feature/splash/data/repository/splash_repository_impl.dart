import 'dart:convert';

import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/localization/localization_model.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/localization/localization_model_v2.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImpl with NetworkModule implements SplashRepository {
  SplashRepositoryImpl._();

  static SplashRepositoryImpl getInstance() => SplashRepositoryImpl._();
  @override
  Future<Either<Failure, Localization>> getLocalizationData() async {
    try {
      var isLocalAvail = await SharedPref.getLocalizationJson();
      if (isLocalAvail != null) {
        return Right(Localization.fromJson(jsonDecode(isLocalAvail)));
      }
      final response = await getMethod('config/internationalization');
      final data = responseHandler(response);
      await SharedPref.saveLocalizationJson(jsonEncode(data));
      return Right(Localization.fromJson(data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocalizationModelV2>> getLocalizationDataV2() async {
    try {
      final response = await getMethod('config/internationalization');
      final data = responseHandler(response);
      return Right(LocalizationModelV2.fromJson(data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
