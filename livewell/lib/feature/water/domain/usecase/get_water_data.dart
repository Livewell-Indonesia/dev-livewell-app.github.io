import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/water/data/model/water_list_model.dart';
import 'package:livewell/feature/water/data/repository/water_repository_impl.dart';
import 'package:livewell/feature/water/domain/repository/water_repository.dart';

class GetWaterData extends UseCase<WaterListModel, NoParams> {
  late WaterRepository repository;

  GetWaterData.instance() {
    repository = WaterRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, WaterListModel>> call(NoParams params) async {
    return await repository.getWaterData();
  }
}
