import 'package:get/get.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/routes/app_navigator.dart';

class UserSettingsController extends GetxController {
  var state = UserSettingsState.initial.obs;
  var user = Get.find<DashboardController>().user;

  void accountSettingsTap() {
    AppNavigator.push(routeName: AppPages.accountSetting);
  }

  void dailyJournalTapped() {
    AppNavigator.push(routeName: AppPages.dailyJournal);
  }

  void physicalInformationTapped() {
    AppNavigator.push(routeName: AppPages.questionnaire);
  }

  void logoutTapped() async {
    await SharedPref.removeToken();
    await SharedPref.clearToken();
    AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
  }
}

enum UserSettingsState { initial, editProfile }
