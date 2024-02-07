import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/mood/data/model/mood_detail_model.dart';
import 'package:livewell/feature/mood/data/repository/mood_repository_impl.dart';

import '../repository/mood_repository.dart';

class GetSingleMood extends UseCase<MoodDetail, String> {
  late MoodRepository repository;

  GetSingleMood.instance() {
    repository = MoodRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, MoodDetail>> call(String params) async {
    return await repository.getSingleMood(params);
  }
}
