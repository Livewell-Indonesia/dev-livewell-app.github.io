import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/update_weight/domain/usecase/update_user_weight.dart';

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
    UpdateUserWeight updateUserWeight = UpdateUserWeight.instance();
    if (Get.isRegistered<DashboardController>()) {
      EasyLoading.show();
      final result = await updateUserWeight(
          UpdateWeightParams(weight: num.parse(weightController.text)));
      EasyLoading.dismiss();
      result.fold((l) {
        print("something went wrong");
      }, (r) {
        Get.find<DashboardController>().getUsersData();
      });
    }
  }
}
