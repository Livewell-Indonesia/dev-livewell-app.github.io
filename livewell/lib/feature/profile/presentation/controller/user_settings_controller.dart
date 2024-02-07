import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/profile/domain/usecase/update_user_info.dart';
import 'package:livewell/feature/profile/presentation/page/exercise_information_screen.dart';
import 'package:livewell/routes/app_navigator.dart';

import '../page/physical_information_screen.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'dart:io' show Platform;

class UserSettingsController extends BaseController {
  var state = UserSettingsState.initial.obs;
  var user = Get.find<DashboardController>().user;
  var language = AvailableLanguage.en.obs;

  @override
  void onInit() {
    language.value = LanguagefromLocale(user.value.language!)!;
    super.onInit();
  }

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

  void exerciseInformationTapped() {
    Get.to(() => ExerciseInformationScreen());
  }

  void setValue(String value) async {
    language.value = LanguagefromLocale(value)!;
  }

  void updateData() async {
    UpdateUserInfo updateUserInfo = UpdateUserInfo.instance();
    EasyLoading.show();
    inspect(language.value.locale);
    final data = await updateUserInfo.call(UpdateUserInfoParams(
        firstName: user.value.firstName ?? "",
        lastName: user.value.lastName ?? "",
        dob: DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(user.value.birthDate ?? "")),
        gender: user.value.gender ?? "",
        height: user.value.height ?? 0,
        weight: user.value.weight ?? 0,
        weightTarget: user.value.weightTarget ?? 0,
        exerciseGoalKcal: user.value.exerciseGoalKcal ?? 0,
        language: language.value.locale));
    EasyLoading.dismiss();
    data.fold((l) {}, (r) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        AppNavigator.pushAndRemove(routeName: '/');
      });
    });
  }

  void logoutTapped() async {
    await SharedPref.removeToken();
    //await SharedPref.clearToken();
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
