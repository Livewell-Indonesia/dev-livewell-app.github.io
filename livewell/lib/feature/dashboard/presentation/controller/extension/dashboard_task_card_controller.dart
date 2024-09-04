import 'dart:async';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_task_recommendation.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/enums/task_card_type.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card/task_card_widget.dart';

extension DashboardTaskCardControllerX on DashboardController {
  void removeTaskCard() {
    taskCardModel.removeAt(0);
  }

  void removeAllTaskCard() {
    taskCardModel.clear();
  }

  void onDoneTap() {
    removeAllTaskCard();
    showDoneRecommendation.value = true;
    Timer(const Duration(seconds: 5), () async {
      await SharedPref.saveDoneWithRecommendation(true);
      // await markTaskAsRead(taskRecommendationReferenceId.value);
      showDoneRecommendation.value = false;
    });
  }

  void getTaskRecommendation() async {
    isLoadingTaskRecommendation.value = true;
    taskCardModel.clear();
    final result = await GetTaskRecommendation.instance().call(wellnessScore.value);
    isLoadingTaskRecommendation.value = false;
    result.fold((l) {}, (r) async {
      var lastWellnessScore = await SharedPref.getLastWellnessScore();
      var isDoneWithRecommendation = await SharedPref.getDoneWithRecommendation();
      taskRecommendationModel.value = r;
      if (lastWellnessScore == wellnessScore.value && isDoneWithRecommendation) {
        return;
      } else {
        taskRecommendationModel.value.response?.list?.forEach((element) {
          taskCardModel.add(TaskCardModel(title: element.title ?? "", description: element.text ?? "", type: TaskCardTypeX.fromString(element.type ?? "")));
        });
        taskRecommendationReferenceId.value = r.response?.referenceId ?? "";
        await SharedPref.saveLastWellnessScore(wellnessScore.value);
      }
    });
  }
}
