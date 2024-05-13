import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/streak/data/model/wellness_detail_model.dart';
import 'package:livewell/feature/streak/data/repository/wellness_repository_impl.dart';
import 'package:livewell/feature/streak/domain/repository/wellness_repository.dart';

class GetWellnessDetail extends UseCase<WellnessDetailModel, DateTime> {
  late WellnessRepository repository;

  GetWellnessDetail.instance() {
    repository = WellnessRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, WellnessDetailModel>> call(DateTime date) async {
    return await repository.getWellnessDetail(date);
  }
}
