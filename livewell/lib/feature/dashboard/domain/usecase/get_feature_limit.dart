import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:livewell/feature/dashboard/domain/entity/feature_limit_entity.dart';
import 'package:livewell/feature/dashboard/domain/repository/dashboard_repository.dart';

class GetFeatureLimit extends UseCase<FeatureLimitEntity, NoParams> {
  late DashBoardRepository repository;
  GetFeatureLimit.instance() {
    repository = DashboardRepostoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, FeatureLimitEntity>> call(NoParams params) async {
    return await repository.getFeatureLimit();
  }
}
