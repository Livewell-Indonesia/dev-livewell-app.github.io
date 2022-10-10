import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/auth/domain/usecase/post_forgot_password.dart';
import 'package:livewell/feature/auth/domain/usecase/post_login.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/routes/app_navigator.dart';

class LoginController extends BaseController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController forgotPasswordEmail = TextEditingController();
  Rx<String> passwordError = ''.obs;

  var showOtpInput = false.obs;

  PostLogin postLogin = PostLogin.instance();
  PostForgotPassword postForgotPassword = PostForgotPassword.instance();

  // create function when button sendveritication tapped
  void sendVerification() {
    showOtpInput.value = true;
  }

  void verifyOTP() {}

  void doLogin() async {
    if (password.text.isEmpty) {
      passwordError.value = 'Password Empty';
      return;
    } else {
      await EasyLoading.show();
      final result = await postLogin(
          ParamsLogin(email: email.text, password: password.text));
      await EasyLoading.dismiss();
      result.fold((l) {
        if (l.message!.contains("404")) {
          Get.snackbar('Error', 'Please verify your email first');
        } else {
          Get.snackbar('Error', l.message ?? 'Error');
        }
      }, (r) {
        SharedPref.saveToken(r.accessToken!);
        SharedPref.saveRefreshToken(r.refreshToken!);
        AppNavigator.pushAndRemove(routeName: AppPages.home);
      });
    }
  }

  void validateEmailAndPassword() {
    if (email.text.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return;
    }
    if (password.text.isEmpty) {
      Get.snackbar('Error', 'Password is required');
      return;
    }
    doLogin();
  }

  void sendForgotPassword() async {
    if (email.text.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return;
    }
    await EasyLoading.show();
    final result =
        await postForgotPassword(ParamsForgotPassword(email: email.text));
    await EasyLoading.dismiss();
    result.fold((l) {
      Get.snackbar('Error', l.message ?? 'Error');
    }, (r) {
      Get.snackbar('Success',
          r.message ?? 'Success reset password. Please check your email');
      AppNavigator.push(routeName: AppPages.changePassword);
    });
  }
}
