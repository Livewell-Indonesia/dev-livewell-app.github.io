import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/notification/firebase_notification.dart';
import 'package:livewell/feature/auth/domain/usecase/post_apple_auth.dart';
import 'package:livewell/feature/auth/domain/usecase/post_google_auth.dart';
import 'package:livewell/feature/auth/domain/usecase/post_register.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_user.dart';
import 'package:livewell/feature/dashboard/domain/usecase/register_device_token.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';

class SignUpController extends BaseController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  Rxn<String?> passwordError = Rxn<String>();
  Rxn<String?> confirmPasswordError = Rxn<String>();
  Rxn<String?> emailError = Rxn<String>();
  Rx<bool> isButtonEnabled = false.obs;

  PostRegister postRegister = PostRegister.instance();
  PostAppleAuth postAuthApple = PostAppleAuth.instance();

  void onRegisterTapped() {
    doRegister();
  }

  @override
  void onInit() {
    email.addListener(() {
      validateInput();
    });
    password.addListener(() {
      validateInput();
    });
    confirmPassword.addListener(() {
      validateInput();
    });
    super.onInit();
  }

  void validateInput() {
    if (email.text.isEmpty) {
      emailError.value = 'Email Cannot Empty';
      isButtonEnabled.value = false;
    } else if (!email.text.isEmail) {
      emailError.value = 'Email Not Valid';
      isButtonEnabled.value = false;
    } else {
      emailError.value = null;
      isButtonEnabled.value = true;
      if (password.text.isEmpty) {
        passwordError.value = 'Password Cannot Empty';
        isButtonEnabled.value = false;
      } else if (!password.text.isPasswordValid()) {
        passwordError.value = 'Password must contains 1 uppercase, 1 number and 1 symbol';
        isButtonEnabled.value = false;
      } else {
        passwordError.value = null;
        isButtonEnabled.value = true;
        if (confirmPassword.text.isEmpty) {
          confirmPasswordError.value = 'Password Cannot Empty';
          isButtonEnabled.value = false;
        } else if (confirmPassword.text != password.text) {
          confirmPasswordError.value = 'Password does not match';
          isButtonEnabled.value = false;
        } else {
          confirmPasswordError.value = null;
          isButtonEnabled.value = true;
        }
      }
    }
  }

  void onGoogleLoginTapped() async {
    PostAuthGoogle postAuthGoogle = PostAuthGoogle.instance();
    EasyLoading.show();
    var result = await postAuthGoogle();
    EasyLoading.dismiss();
    result.fold((l) {
      if (l.message!.contains("404")) {
        Get.snackbar('Error', 'Please verify your email first');
      } else {
        Get.snackbar('Authentication Failed', 'Your authentication information is incorrect. Please try again.');
      }
    }, (r) async {
      await SharedPref.saveToken(r.accessToken!);
      await SharedPref.saveRefreshToken(r.refreshToken!);
      GetUser getUser = GetUser.instance();
      final result = await getUser(NoParams());
      result.fold((l) {}, (r) async {
        await LivewellNotification().init();
        await registerDeviceToken();
        changeLocalization(LanguagefromLocale(r.language!)!).then((value) async {
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
        Get.snackbar('Authentication Failed', 'Your authentication information is incorrect. Please try again.');
      }
    }, (r) async {
      await SharedPref.saveToken(r.accessToken!);
      await SharedPref.saveRefreshToken(r.refreshToken!);
      GetUser getUser = GetUser.instance();
      final result = await getUser(NoParams());
      result.fold((l) {}, (r) async {
        await LivewellNotification().init();
        await registerDeviceToken();
        changeLocalization(LanguagefromLocale(r.language!)!).then((value) async {
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

  void doRegister() async {
    await EasyLoading.show();
    final result = await postRegister.call(ParamsRegister(email: email.text, password: password.text, confirmPassword: confirmPassword.text));
    await EasyLoading.dismiss();
    result.fold((l) {}, (r) {
      AppNavigator.pushReplacement(routeName: AppPages.login);
      Get.snackbar("Success Register", "Verify your email");
    });
  }
}
