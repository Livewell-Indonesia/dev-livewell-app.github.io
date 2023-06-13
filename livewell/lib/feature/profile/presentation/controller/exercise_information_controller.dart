import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/profile/domain/usecase/update_user_info.dart';
import 'package:livewell/core/base/base_controller.dart';

class ExerciseInformationController extends BaseController {
  var exerciseController = TextEditingController();

  @override
  void onInit() {
    assignExerciseController();
    super.onInit();
  }

  void assignExerciseController() {
    if (Get.isRegistered<DashboardController>()) {
      var userData = Get.find<DashboardController>().user.value;
      exerciseController.text = userData.exerciseGoalKcal.toString();
    }
  }

  void save() async {
    if (Get.isRegistered<DashboardController>()) {
      var newUserData = Get.find<DashboardController>().user.value;
      newUserData.exerciseGoalKcal = int.parse(exerciseController.text);
      UpdateUserInfo updateUserInfo = UpdateUserInfo.instance();
      EasyLoading.show();
      final result = await updateUserInfo.call(
        UpdateUserInfoParams(
            firstName: newUserData.firstName ?? "",
            lastName: newUserData.lastName ?? "",
            height: newUserData.height ?? 0,
            weight: newUserData.weight ?? 0,
            gender: newUserData.gender ?? "",
            dob: DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(newUserData.birthDate ?? "")),
            weightTarget: newUserData.weightTarget ?? 0,
            exerciseGoalKcal: newUserData.exerciseGoalKcal ?? 0),
      );
      EasyLoading.dismiss();
      result.fold((l) => Log.error(l), (r) {
        Get.find<DashboardController>().getUsersData();
        Get.back();
      });
    }
  }
}
