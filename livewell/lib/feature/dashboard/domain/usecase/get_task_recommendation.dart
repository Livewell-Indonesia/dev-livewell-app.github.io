import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/dashboard/data/model/task_recommendation_model.dart';
import 'package:livewell/feature/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:livewell/feature/dashboard/domain/repository/dashboard_repository.dart';

class GetTaskRecommendation extends UseCase<TaskRecommendationModel, int> {
  late DashBoardRepository repository;
  GetTaskRecommendation.instance() {
    repository = DashboardRepostoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, TaskRecommendationModel>> call(int params) async {
    return await repository.getTaskRecommendation(params);
  }
}
