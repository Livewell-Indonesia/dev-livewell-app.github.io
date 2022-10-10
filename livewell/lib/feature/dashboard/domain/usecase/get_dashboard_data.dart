import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/dashboard/data/model/dashboard_model.dart';
import 'package:livewell/feature/dashboard/domain/repository/dashboard_repository.dart';

import '../../data/repository/dashboard_repository_impl.dart';

class GetDashboardData extends UseCase<DashboardModel, NoParams> {
  late DashBoardRepository repository;
  GetDashboardData.instance() {
    repository = DashboardRepostoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, DashboardModel>> call(NoParams params) async {
    return await repository.getDashboardData();
  }
}
