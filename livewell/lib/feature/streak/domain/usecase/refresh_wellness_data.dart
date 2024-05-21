import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/streak/data/repository/wellness_repository_impl.dart';
import 'package:livewell/feature/streak/domain/repository/wellness_repository.dart';

class RefreshWellnessData extends UseCase<void, String> {
  late WellnessRepository repository;

  RefreshWellnessData.instance() {
    repository = WellnessRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.refreshWellness(params);
  }
}
