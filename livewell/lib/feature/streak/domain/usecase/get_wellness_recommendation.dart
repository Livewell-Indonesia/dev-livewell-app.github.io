import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/streak/data/repository/wellness_repository_impl.dart';
import 'package:livewell/feature/streak/domain/repository/wellness_repository.dart';

class GetWellnessRecommendation extends UseCase<String, NoParams> {
  late WellnessRepository repository;

  GetWellnessRecommendation.instance() {
    repository = WellnessRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.getWellnessRecommendation();
  }
}
