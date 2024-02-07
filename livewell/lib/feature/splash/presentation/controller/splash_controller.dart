import 'package:get/get.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_user.dart';

import '../../../../core/base/usecase.dart';
import '../../../../routes/app_navigator.dart';
import 'package:livewell/core/base/base_controller.dart';

class SplashController extends GetxController {
  LanguageController controller = Get.put(LanguageController());
  var language = AvailableLanguage.en.obs;
  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 300))
        .then((value) => getLocalization());
    super.onReady();
  }

  // @override
  // void onInit() {
  //   Future.delayed(const Duration(milliseconds: 100))
  //       .then((value) => getLocalization());
  //   super.onInit();
  // }

  void checkUserSession() async {}

  void getLocalization() async {
    final result = await controller.getLocalizationData.call(NoParams());
    result.fold((l) {}, (r) async {
      // check user locale
      getUserData();
    });
  }

  void getUserData() async {
    final isLoggedIn = await SharedPref.getToken();
    if (isLoggedIn.isEmpty) {
      controller.changeLocalization(AvailableLanguage.en).then((value) {
        AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
        Get.delete<SplashController>();
      });
    } else {
      GetUser getUser = GetUser.instance();
      final result = await getUser.call(NoParams());
      result.fold((l) {}, (r) async {
        await SharedPref.getToken();
        await SharedPref.saveUserLocale(r.language!);
        controller
            .changeLocalization(controller.LanguagefromLocale(r.language)!)
            .then((value) {
          AppNavigator.pushAndRemove(routeName: AppPages.home);
          Get.delete<SplashController>();
        });
      });
    }
  }
}
