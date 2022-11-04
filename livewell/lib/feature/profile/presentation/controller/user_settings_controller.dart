import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/routes/app_navigator.dart';

import '../page/physical_information_screen.dart';
import 'dart:io' show Platform;

class UserSettingsController extends GetxController {
  var state = UserSettingsState.initial.obs;
  var user = Get.find<DashboardController>().user;

  void accountSettingsTap() {
    AppNavigator.push(routeName: AppPages.accountSetting);
  }

  void dailyJournalTapped() {
    AppNavigator.push(routeName: AppPages.dailyJournal, arguments: true);
  }

  void physicalInformationTapped() {
    //AppNavigator.push(routeName: AppPages.questionnaire);
    Get.to(() => PhysicalInformationScreen());
  }

  void logoutTapped() async {
    await SharedPref.removeToken();
    await SharedPref.clearToken();
    if (Platform.isIOS) {
      await GoogleSignIn(
              clientId:
                  "649229634613-l8tqhjbf9o0lmu3mcs3ouhndi0aj5brk.apps.googleusercontent.com")
          .signOut();
    } else if (Platform.isAndroid) {
      await GoogleSignIn().signOut();
    }
    AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
  }
}

enum UserSettingsState { initial, editProfile }
