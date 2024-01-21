import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/notification/firebase_notification.dart';
import 'package:livewell/feature/auth/domain/usecase/post_apple_auth.dart';
import 'package:livewell/feature/auth/domain/usecase/post_forgot_password.dart';
import 'package:livewell/feature/auth/domain/usecase/post_google_auth.dart';
import 'package:livewell/feature/auth/domain/usecase/post_login.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_user.dart';
import 'package:livewell/feature/dashboard/domain/usecase/register_device_token.dart';
import 'package:livewell/routes/app_navigator.dart';

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
  PostAppleAuth postAuthApple = PostAppleAuth.instance();

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
    }, (r) async {
      await SharedPref.saveToken(r.accessToken!);
      await SharedPref.saveRefreshToken(r.refreshToken!);
      GetUser getUser = GetUser.instance();
      final result = await getUser(NoParams());
      result.fold((l) {}, (r) async {
        await LivewellNotification().init();
        await registerDeviceToken();
        changeLocalization(LanguagefromLocale(r.language!)!)
            .then((value) async {
          AppNavigator.pushAndRemove(routeName: AppPages.home);
        });
      });
    });
  }

  Future<void> registerDeviceToken() async {
    RegisterDevice registerDevice = RegisterDevice.instance();
    final token = await SharedPref.getFCMToken();
    final result = await registerDevice.call(token ?? "");
    result.fold((l) {
      Log.error(l);
    }, (r) {
      Log.colorGreen(r);
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
    EasyLoading.show();
    var result = await postAuthGoogle();
    EasyLoading.dismiss();
    result.fold((l) {
      if (l.message!.contains("404")) {
        Get.snackbar('Error', 'Please verify your email first');
      } else {
        Get.snackbar('Authentication Failed',
            'Your authentication information is incorrect. Please try again.');
      }
    }, (r) async {
      await SharedPref.saveToken(r.accessToken!);
      await SharedPref.saveRefreshToken(r.refreshToken!);
      GetUser getUser = GetUser.instance();
      final result = await getUser(NoParams());
      result.fold((l) {}, (r) async {
        await LivewellNotification().init();
        await registerDeviceToken();
        changeLocalization(LanguagefromLocale(r.language!)!)
            .then((value) async {
          AppNavigator.pushAndRemove(routeName: AppPages.home);
        });
      });
    });
  }

  void onAppleIdTapped() async {
    EasyLoading.show();
    var result = await postAuthApple();
    EasyLoading.dismiss();
    result.fold((l) {
      if (l.message!.contains("404")) {
        Get.snackbar('Error', 'Please verify your email first');
      } else {
        Get.snackbar('Authentication Failed',
            'Your authentication information is incorrect. Please try again.');
      }
    }, (r) async {
      await SharedPref.saveToken(r.accessToken!);
      await SharedPref.saveRefreshToken(r.refreshToken!);
      GetUser getUser = GetUser.instance();
      final result = await getUser(NoParams());
      result.fold((l) {}, (r) async {
        await LivewellNotification().init();
        await registerDeviceToken();
        changeLocalization(LanguagefromLocale(r.language!)!)
            .then((value) async {
          AppNavigator.pushAndRemove(routeName: AppPages.home);
        });
      });
    });
  }

  void sendForgotPassword() async {
    if (email.text.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return;
    }
    if (!email.text.isEmail) {
      Get.snackbar('Error', 'Email is not valid');
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
