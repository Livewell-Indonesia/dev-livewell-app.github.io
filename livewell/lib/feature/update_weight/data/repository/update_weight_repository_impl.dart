import 'package:livewell/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/update_weight/domain/repository/update_weight_repository.dart';
import 'package:livewell/feature/update_weight/domain/usecase/update_user_weight.dart';

class UpdateWeightRepositoryImpl extends NetworkModule
    implements UpdateWeightRepository {
  static UpdateWeightRepositoryImpl? _instance;

  UpdateWeightRepositoryImpl._internal();

  static UpdateWeightRepositoryImpl getInstance() {
    _instance ??= UpdateWeightRepositoryImpl._internal();
    return _instance!;
  }

  @override
  Future<Either<Failure, RegisterModel>> updateWeight(
      UpdateWeightParams params) async {
    try {
      final response = await postMethod(Endpoint.updateWeight,
          body: params.toJson(),
          headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      final data = RegisterModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      return const Left(ServerFailure());
    }
  }
}
