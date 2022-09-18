import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/auth/domain/usecase/post_login.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';

class LoginController extends BaseController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController forgotPasswordEmail = TextEditingController();

  PostLogin postLogin = PostLogin.instance();
  var showOtpInput = false.obs;

  // create function when button sendveritication tapped
  void sendVerification() {
    showOtpInput.value = true;
  }

  void verifyOTP() {}

  void doLogin() async {
    final result = await postLogin(
        ParamsLogin(email: email.text, password: password.text));
    result.fold((l) {
      Get.snackbar('Error', l.message ?? 'Error');
    }, (r) {
      SharedPref.saveToken(r.accessToken!);
      SharedPref.saveRefreshToken(r.refreshToken!);
      Get.offAll(FoodScreen());
    });
  }
}
