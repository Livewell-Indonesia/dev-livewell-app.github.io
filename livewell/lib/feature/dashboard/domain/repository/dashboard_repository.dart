import 'package:dartz/dartz.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/dashboard/data/model/app_config_model.dart';
import 'package:livewell/feature/dashboard/data/model/dashboard_model.dart';
import 'package:livewell/feature/dashboard/data/model/popup_assets_model.dart';
import 'package:livewell/feature/dashboard/data/model/task_recommendation_model.dart';
import 'package:livewell/feature/dashboard/data/model/user_model.dart';
import 'package:livewell/feature/dashboard/domain/entity/feature_limit_entity.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card/task_card_widget.dart';

import '../../../../core/error/failures.dart';

abstract class DashBoardRepository {
  Future<Either<Failure, UserModel>> getUser();
  Future<Either<Failure, DashboardModel>> getDashboardData();
  Future<Either<Failure, AppConfigModel>> getAppConfig();
  Future<Either<Failure, PopupAssetsModel>> getPopupAssets();
  Future<Either<Failure, RegisterModel>> registerDevice(String fcmToken);
  Future<Either<Failure, RegisterModel>> postMood(int value, {DateTime? dateTime});
  Future<Either<Failure, TaskRecommendationModel>> getTaskRecommendation(int wellnessScore);

  Future<Either<Failure, FeatureLimitEntity>> getFeatureLimit();
}
