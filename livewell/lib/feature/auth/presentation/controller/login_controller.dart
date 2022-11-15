import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/auth/domain/usecase/post_forgot_password.dart';
import 'package:livewell/feature/auth/domain/usecase/post_google_auth.dart';
import 'package:livewell/feature/auth/domain/usecase/post_login.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/routes/app_navigator.dart';

import '../../../../core/log.dart';

class LoginController extends BaseController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController forgotPasswordEmail = TextEditingController();
  Rx<String> passwordError = ''.obs;
  Rx<String> emailError = ''.obs;

  var showOtpInput = false.obs;

  PostLogin postLogin = PostLogin.instance();
  PostForgotPassword postForgotPassword = PostForgotPassword.instance();
  PostAuthGoogle postAuthGoogle = PostAuthGoogle.instance();

  // create function when button sendveritication tapped
  void sendVerification() {
    showOtpInput.value = true;
  }

  void verifyOTP() {}

  void doLogin() async {
    if (!email.text.isEmail) {
      emailError.value = 'Email Not Valid';
      return;
    }
    if (password.text.isEmpty) {
      passwordError.value = 'Password Empty';
      return;
    }
    await EasyLoading.show();
    final result = await postLogin(
        ParamsLogin(email: email.text, password: password.text));
    await EasyLoading.dismiss();
    result.fold((l) {
      if (l.message!.contains("404")) {
        Get.snackbar('Error', 'Please verify your email first');
      } else {
        Get.snackbar('Authentication Failed',
            'Your authentication information is incorrect. Please try again.');
      }
    }, (r) {
      SharedPref.saveToken(r.accessToken!);
      SharedPref.saveRefreshToken(r.refreshToken!);
      AppNavigator.pushAndRemove(routeName: AppPages.home);
    });
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

  void onGoogleLoginTapped() async {
    var result = await postAuthGoogle();
    result.fold((l) {
      if (l.message!.contains("404")) {
        Get.snackbar('Error', 'Please verify your email first');
      } else {
        Get.snackbar('Authentication Failed',
            'Your authentication information is incorrect. Please try again.');
      }
    }, (r) {
      SharedPref.saveToken(r.accessToken!);
      SharedPref.saveRefreshToken(r.refreshToken!);
      AppNavigator.pushAndRemove(routeName: AppPages.home);
    });
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
      Get.snackbar('Authentication Failed',
          'Your authentication information is incorrent. Please try again.');
    }, (r) {
      Get.snackbar('Password Email Sent', 'Check your Email for your OTP');
      AppNavigator.push(routeName: AppPages.changePassword);
    });
  }
}

extension PasswordChecker on String {
  bool isPasswordValid() {
    if (length <= 8) {
      return false;
    }
    if (!contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (!contains(RegExp(r'[0-9]'))) {
      return false;
    }
    if (!contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    return true;
  }
}
