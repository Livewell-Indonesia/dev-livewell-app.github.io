import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_task_recommendation.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';

extension DashboardTaskCardControllerX on DashboardController {
  void removeTaskCard() {
    taskCardModel.removeAt(0);
  }

  void getTaskRecommendation() async {
    isLoadingTaskRecommendation.value = true;
    final result = await GetTaskRecommendation.instance().call(NoParams());
    isLoadingTaskRecommendation.value = false;
    result.fold((l) {}, (r) {
      taskRecommendationModel.value = r;
    });
  }
}
