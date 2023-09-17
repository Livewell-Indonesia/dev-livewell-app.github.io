import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:livewell/feature/dashboard/domain/repository/dashboard_repository.dart';

import '../../../auth/data/model/register_model.dart';

class RegisterDevice extends UseCase<RegisterModel, String> {
  late DashBoardRepository repository;
  RegisterDevice.instance() {
    repository = DashboardRepostoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, RegisterModel>> call(String params) async {
    return await repository.registerDevice(params);
  }
}
