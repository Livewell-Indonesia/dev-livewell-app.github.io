import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/food/domain/repository/food_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/repository/food_repository.dart';

class GetCameras extends UseCase<List<CameraDescription>, NoParams> {
  late FoodRepository repository;

  GetCameras.instance() {
    repository = FoodRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, List<CameraDescription>>> call(NoParams params) async {
    return repository.getCameras();
  }
}
