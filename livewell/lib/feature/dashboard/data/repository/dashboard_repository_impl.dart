import 'package:dartz/dartz.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/dashboard/domain/repository/dashboard_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/local_storage/shared_pref.dart';
import '../model/user_model.dart';

class DashboardRepostoryImpl extends NetworkModule
    implements DashBoardRepository {
  DashboardRepostoryImpl._();

  static DashboardRepostoryImpl getInstance() => DashboardRepostoryImpl._();

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      final response = await getMethod(Endpoint.user, headers: {
        'Authorization': await SharedPref.getToken(),
      });
      final json = responseHandler(response);
      return Right(UserModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
