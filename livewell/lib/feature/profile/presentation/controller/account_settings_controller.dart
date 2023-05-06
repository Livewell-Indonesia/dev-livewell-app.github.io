import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/auth/domain/usecase/delete_account.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/profile/domain/usecase/update_user_info.dart';
import 'package:livewell/routes/app_navigator.dart';

class AccountSettingsController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();

  final DashboardController dashboardController = Get.find();

  UpdateUserInfo updateUserInfo = UpdateUserInfo.instance();

  @override
  void onInit() {
    firstName.text = dashboardController.user.value.firstName ?? "";
    lastName.text = dashboardController.user.value.lastName ?? "";
    email.text = dashboardController.user.value.email ?? "";
    super.onInit();
  }

  void validate() async {
    EasyLoading.show();
    final result = await updateUserInfo.call(
      UpdateUserInfoParams(
          firstName: firstName.text,
          lastName: lastName.text,
          height: dashboardController.user.value.height ?? 0,
          weight: dashboardController.user.value.weight ?? 0,
          gender: dashboardController.user.value.gender ?? "",
          dob: DateFormat('yyyy-MM-dd').format(
              DateTime.parse(dashboardController.user.value.birthDate ?? "")),
          weightTarget: dashboardController.user.value.weightTarget ?? 0,
          exerciseGoalKcal:
              dashboardController.user.value.exerciseGoalKcal ?? 0),
    );
    EasyLoading.dismiss();
    Get.back();
    result.fold((l) {
      Get.snackbar('Failed', 'Failed Update User Info');
    }, (r) {
      Get.snackbar('Success', 'Success Update User Info');
      dashboardController.getUsersData();
    });
  }

  void requestAccountDeletion() async {
    final deleteAccount = DeleteAccount.instance();
    final result = await deleteAccount.call();
    result.fold((l) {
      Get.snackbar('Failed', 'Failed Delete Account');
    }, (r) {
      Get.snackbar('Success', 'Request To Delete Account Successful');
      Get.offAllNamed(AppPages.landingLogin);
    });
  }
}
