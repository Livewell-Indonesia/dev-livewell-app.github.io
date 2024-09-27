import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_user.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/force_update/domain/repository/force_update_repository.dart';
import 'package:livewell/feature/force_update/domain/usecase/get_force_update_status.dart';
import 'package:livewell/feature/force_update/presentation/widget/major_update_bottom_sheet.dart';
import 'package:livewell/feature/force_update/presentation/widget/minor_update_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/base/usecase.dart';
import '../../../../routes/app_navigator.dart';
import 'package:livewell/core/base/base_controller.dart';

class SplashController extends BaseController {
  LanguageController controller = Get.put(LanguageController());
  var language = AvailableLanguage.en.obs;
  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      getForceUpdateStatus();
      trackEvent(LivewellAuthEvent.splashScreen);
    });
    super.onReady();
  }

  // @override
  // void onInit() {
  //   Future.delayed(const Duration(milliseconds: 100))
  //       .then((value) => getLocalization());
  //   super.onInit();
  // }

  void checkUserSession() async {}

  void _launchStore() async {
    // Replace 'your_app_id' with your app's ID or package name
    final Uri appStoreUrl = Uri.parse('itms-apps://apple.com/app/id6444037227');
    final Uri playStoreUrl = Uri.parse('market://details?id=com.livewellindo.app');

    if (GetPlatform.isIOS) {
      if (await canLaunchUrl(appStoreUrl)) {
        await launchUrl(appStoreUrl);
      } else {
        throw 'Could not launch App Store';
      }
    } else if (GetPlatform.isAndroid) {
      if (await canLaunchUrl(playStoreUrl)) {
        await launchUrl(playStoreUrl);
      } else {
        throw 'Could not launch Play Store';
      }
    }
  }

  void getForceUpdateStatus() async {
    final result = await GetForceUpdateStatus.instance().call();
    switch (result) {
      case ForceUpdateStatus.none:
        getLocalization();
      case ForceUpdateStatus.optional:
        showModalBottomSheet(
            isDismissible: false,
            enableDrag: false,
            context: Get.context!,
            shape: shapeBorder(),
            isScrollControlled: true,
            builder: (context) {
              return MinorUpdateBottomSheet(
                onUpdateTapped: () {
                  _launchStore();
                },
                onLaterTapped: () {
                  Get.back();
                  getLocalization();
                },
              );
            });
      case ForceUpdateStatus.required:
        showModalBottomSheet(
            isDismissible: false,
            enableDrag: false,
            context: Get.context!,
            shape: shapeBorder(),
            isScrollControlled: true,
            builder: (context) {
              return MajorUpdateBottomSheet(
                onUpdateTapped: () {
                  _launchStore();
                },
              );
            });
    }
  }

  void getLocalization() async {
    final result = await controller.getLocalizationData.call(NoParams());
    result.fold((l) {}, (r) async {
      // check user locale
      getUserData();
    });
    // final result = await controller.getLocalizationDataV2.call(NoParams());
    // result.fold((l) {}, (r) async {
    //   // check user locale
    //   getUserData();
    // });
  }

  void getUserData() async {
    final isLoggedIn = await SharedPref.getToken();
    if (isLoggedIn.isEmpty) {
      controller.changeLocalization(AvailableLanguage.id).then((value) {
        AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
        Get.delete<SplashController>();
      });
    } else {
      GetUser getUser = GetUser.instance();
      final result = await getUser.call(NoParams());
      result.fold((l) {
        if (l is UnauthorizedException) {
          controller.changeLocalization(AvailableLanguage.id).then((value) {
            AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
          });
        }
      }, (r) async {
        await SharedPref.getToken();
        await SharedPref.saveUserLocale(r.language!);
        controller.changeLocalization(controller.LanguagefromLocale(r.language)!).then((value) {
          AppNavigator.pushAndRemove(routeName: AppPages.home);
          Get.delete<SplashController>();
        });
      });
    }
  }
}
