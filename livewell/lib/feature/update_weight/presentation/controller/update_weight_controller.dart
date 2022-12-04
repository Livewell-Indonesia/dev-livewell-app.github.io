import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../../../questionnaire/domain/usecase/post_questionnaire.dart';

class UpdateWeightController extends GetxController {
  TextEditingController weightController = TextEditingController();

  @override
  void onInit() {
    getCurrentWeight();
    super.onInit();
  }

  void getCurrentWeight() {
    if (Get.isRegistered<DashboardController>()) {
      var user = Get.find<DashboardController>().user.value;
      weightController.text = user.weight.toString();
    }
  }

  void onUpdateTapped() async {
    PostQuestionnaire postQuestionnaire = PostQuestionnaire.instance();
    if (Get.isRegistered<DashboardController>()) {
      var user = Get.find<DashboardController>().user.value;
      user.weight = int.parse(weightController.text);
      EasyLoading.show();

      final result = await postQuestionnaire.call(QuestionnaireParams.asParams(
        user.firstName,
        user.lastName,
        user.gender,
        user.birthDate ?? "",
        user.weight,
        user.height,
        user.weightTarget,
        user.onboardingQuestionnaire?.glassesOfWaterDaily ?? "",
        user.onboardingQuestionnaire?.sleepDuration ?? "",
        user.onboardingQuestionnaire?.dietaryRestrictions?.first ?? "",
        user.onboardingQuestionnaire?.targetImprovement?.first ?? "",
      ));
    }
  }
}
