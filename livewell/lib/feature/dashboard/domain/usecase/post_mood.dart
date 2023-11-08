import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:livewell/feature/dashboard/domain/repository/dashboard_repository.dart';

class PostMood extends UseCase<RegisterModel, PostMoodParams> {
  late DashBoardRepository repository;
  PostMood.instance() {
    repository = DashboardRepostoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, RegisterModel>> call(PostMoodParams params) async {
    return await repository.postMood(params.value, dateTime: params.dateTime);
  }
}

class PostMoodParams {
  final int value;
  final DateTime? dateTime;
  PostMoodParams({required this.value, this.dateTime});
}
