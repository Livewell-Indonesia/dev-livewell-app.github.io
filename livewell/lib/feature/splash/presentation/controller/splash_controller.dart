import 'package:get/get.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/auth/presentation/page/landing/landing_auth_screen.dart';
import 'package:livewell/feature/auth/presentation/page/login/login_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 2000))
        .then((value) => checkUserSession());
    super.onReady();
  }

  void checkUserSession() async {
    final isLoggedIn = await SharedPref.getToken();
    if (isLoggedIn.isEmpty) {
      Get.offAll(LandingAuthScreen());
    } else {
      Get.offAll(FoodScreen());
    }
  }
}
