import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/dashboard/data/model/user_model.dart';
import 'package:livewell/feature/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:livewell/feature/dashboard/domain/repository/dashboard_repository.dart';

class GetUser extends UseCase<UserModel, NoParams> {
  late DashBoardRepository repository;
  GetUser.instance() {
    repository = DashboardRepostoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.getUser();
  }
}
