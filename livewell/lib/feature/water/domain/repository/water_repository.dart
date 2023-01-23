import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/water/data/model/water_list_model.dart';
import 'package:livewell/feature/water/domain/usecase/post_water_data.dart';

abstract class WaterRepository {
  Future<Either<Failure, RegisterModel>> postWaterData(PostWaterParams params);
  Future<Either<Failure, WaterListModel>> getWaterData();
}
