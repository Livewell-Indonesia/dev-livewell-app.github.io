import 'package:dartz/dartz.dart';
import 'package:livewell/feature/dashboard/data/model/app_config_model.dart';
import 'package:livewell/feature/dashboard/data/model/dashboard_model.dart';
import 'package:livewell/feature/dashboard/data/model/popup_assets_model.dart';
import 'package:livewell/feature/dashboard/data/model/user_model.dart';

import '../../../../core/error/failures.dart';

abstract class DashBoardRepository {
  Future<Either<Failure, UserModel>> getUser();
  Future<Either<Failure, DashboardModel>> getDashboardData();
  Future<Either<Failure, AppConfigModel>> getAppConfig();
  Future<Either<Failure, PopupAssetsModel>> getPopupAssets();
}
