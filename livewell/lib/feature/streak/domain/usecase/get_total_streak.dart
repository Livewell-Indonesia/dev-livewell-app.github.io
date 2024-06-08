import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/streak/data/repository/wellness_repository_impl.dart';
import 'package:livewell/feature/streak/domain/repository/wellness_repository.dart';

class GetTotalStreak extends UseCase<int, NoParams> {
  late WellnessRepository repository;

  GetTotalStreak.instance() {
    repository = WellnessRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.getStreakTotal();
  }
}