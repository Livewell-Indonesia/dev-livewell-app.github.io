import 'dart:developer';

import 'package:get/get.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/localization/localization_model.dart';
import 'package:livewell/feature/splash/domain/usecase/get_localization_data.dart';

import '../../../../core/base/usecase.dart';
import '../../../../routes/app_navigator.dart';
import 'package:livewell/core/base/base_controller.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 300))
        .then((value) => getLocalization());
    super.onReady();
  }

  void checkUserSession() async {}

  void getLocalization() async {
    LanguageController controller = Get.put(LanguageController());

    final result = await controller.getLocalizationData.call(NoParams());
    result.fold((l) {}, (r) async {
      // check user locale
      final isLoggedIn = await SharedPref.getToken();
      if (isLoggedIn.isEmpty) {
        AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
      } else {
        AppNavigator.pushAndRemove(routeName: AppPages.home);
      }
    });
  }
}
