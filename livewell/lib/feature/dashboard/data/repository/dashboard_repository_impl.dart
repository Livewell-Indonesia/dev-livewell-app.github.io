import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/dashboard/data/model/app_config_model.dart';
import 'package:livewell/feature/dashboard/data/model/dashboard_model.dart';
import 'package:livewell/feature/dashboard/data/model/feature_limit_model.dart';
import 'package:livewell/feature/dashboard/data/model/popup_assets_model.dart';
import 'package:livewell/feature/dashboard/data/model/task_recommendation_model.dart';
import 'package:livewell/feature/dashboard/domain/entity/feature_limit_entity.dart';
import 'package:livewell/feature/dashboard/domain/repository/dashboard_repository.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card_widget.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/local_storage/shared_pref.dart';
import '../model/user_model.dart';

class DashboardRepostoryImpl with NetworkModule implements DashBoardRepository {
  DashboardRepostoryImpl._();

  static DashboardRepostoryImpl getInstance() => DashboardRepostoryImpl._();

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      final response = await getMethod(Endpoint.user, headers: {
        authorization: await SharedPref.getToken(),
      });
      final json = responseHandler(response);
      return Right(UserModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, DashboardModel>> getDashboardData() async {
    try {
      final response = await getMethod(Endpoint.dashboard, headers: {
        authorization: await SharedPref.getToken(),
      });
      final json = responseHandler(response);
      return Right(DashboardModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, AppConfigModel>> getAppConfig() async {
    try {
      final response = await getMethod(Endpoint.appConfig, headers: {
        authorization: await SharedPref.getToken(),
      });
      final json = responseHandler(response);
      return Right(AppConfigModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, PopupAssetsModel>> getPopupAssets() async {
    try {
      final response = await getMethod(Endpoint.popupAssets, headers: {
        authorization: await SharedPref.getToken(),
      });
      final json = responseHandler(response);
      return Right(PopupAssetsModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> registerDevice(String fcmToken) async {
    try {
      final response = await postMethod(Endpoint.registerDevice, body: {
        "fcm_token": fcmToken,
      }, headers: {
        authorization: await SharedPref.getToken(),
      });
      final json = responseHandler(response);
      return Right(RegisterModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterModel>> postMood(int value, {DateTime? dateTime}) async {
    try {
      final response = await postMethod(Endpoint.postMood, body: {
        "date": DateFormat('yyyy-MM-dd').format(dateTime ?? DateTime.now()),
        "value": value,
      }, headers: {
        authorization: await SharedPref.getToken(),
      });
      final json = responseHandler(response);
      return Right(RegisterModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, FeatureLimitEntity>> getFeatureLimit() async {
    try {
      final response = await getMethod(Endpoint.featureLimit, headers: {
        authorization: await SharedPref.getToken(),
      });
      final json = responseHandler(response);
      final model = FeatureLimitModel.fromJson(json);
      return Right(FeatureLimitEntity.fromRemote(model));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskRecommendationModel>> getTaskRecommendation() async {
    try {
      final response = await postMethod(Endpoint.taskRecommendation, headers: {
        authorization: await SharedPref.getToken(),
      });
      final json = responseHandler(response);
      final model = TaskRecommendationModel.fromJson(json);
      return Right(model);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
