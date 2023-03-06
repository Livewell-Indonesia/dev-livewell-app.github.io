import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/update_weight/data/repository/update_weight_repository_impl.dart';
import 'package:livewell/feature/update_weight/domain/model/weight_history.dart';
import 'package:livewell/feature/update_weight/domain/repository/update_weight_repository.dart';

class GetUserHistory extends UseCase<List<WeightHistory>, NoParams> {
  late UpdateWeightRepository repository;

  GetUserHistory.instance() {
    repository = UpdateWeightRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, List<WeightHistory>>> call(NoParams params) async {
    return await repository.getWeightHistory();
  }
}
