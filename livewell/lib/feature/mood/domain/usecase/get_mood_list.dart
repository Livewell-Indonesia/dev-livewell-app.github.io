import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/mood/data/model/mood_model.dart';

import '../../data/repository/mood_repository_impl.dart';
import '../repository/mood_repository.dart';

class GetMoodList extends UseCase<MoodsModel, int> {
  late MoodRepository repository;

  GetMoodList.instance() {
    repository = MoodRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, MoodsModel>> call(int params) async {
    return await repository.getMoods(params);
  }
}
