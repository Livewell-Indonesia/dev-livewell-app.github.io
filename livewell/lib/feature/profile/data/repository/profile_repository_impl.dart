import 'package:dartz/dartz.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/local_storage/shared_pref.dart';
import '../../../auth/data/model/register_model.dart';
import '../../domain/repository/profile_repository.dart';
import '../../domain/usecase/update_user_info.dart';

class UserProfileRepositoryImpl extends NetworkModule
    implements UserProfileRepository {
  UserProfileRepositoryImpl._();

  static UserProfileRepositoryImpl getInstance() =>
      UserProfileRepositoryImpl._();

  @override
  Future<Either<Failure, RegisterModel>> updateUserProfile(
      UpdateUserInfoParams params) async {
    try {
      final response = await postMethod(Endpoint.user,
          body: params.toJson(),
          headers: {authorization: await SharedPref.getToken()});
      final data = responseHandler(response);
      return Right(RegisterModel.fromJson(data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
