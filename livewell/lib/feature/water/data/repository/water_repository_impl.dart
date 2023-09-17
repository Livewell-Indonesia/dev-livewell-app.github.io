import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/water/data/model/water_list_model.dart';
import 'package:livewell/feature/water/domain/repository/water_repository.dart';
import 'package:livewell/feature/water/domain/usecase/post_water_data.dart';

import '../../../../core/network/api_url.dart';

class WaterRepositoryImpl with NetworkModule implements WaterRepository {
  WaterRepositoryImpl._();

  static WaterRepositoryImpl getInstance() => WaterRepositoryImpl._();

  @override
  Future<Either<Failure, RegisterModel>> postWaterData(
      PostWaterParams params) async {
    try {
      final response = await postMethod(Endpoint.postWater,
          headers: {authorization: await SharedPref.getToken()},
          body: params.toJson());
      final json = responseHandler(response);
      return Right(RegisterModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, WaterListModel>> getWaterData() async {
    try {
      final response = await getMethod(Endpoint.getWater,
          headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      return Right(WaterListModel.fromJson(json));
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
