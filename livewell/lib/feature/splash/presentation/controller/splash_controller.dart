import 'package:get/get.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';

import '../../../../routes/app_navigator.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 1000))
        .then((value) => checkUserSession());
    super.onReady();
  }

  void checkUserSession() async {
    final isLoggedIn = await SharedPref.getToken();
    if (isLoggedIn.isEmpty) {
      AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
    } else {
      AppNavigator.pushAndRemove(routeName: AppPages.home);
    }
  }
}
