import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/app_config_model.dart';
import '../../data/repository/dashboard_repository_impl.dart';
import '../repository/dashboard_repository.dart';

class GetAppConfig extends UseCase<AppConfigModel, NoParams> {
  late DashBoardRepository repository;
  GetAppConfig.instance() {
    repository = DashboardRepostoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, AppConfigModel>> call(NoParams params) async {
    return await repository.getAppConfig();
  }
}
