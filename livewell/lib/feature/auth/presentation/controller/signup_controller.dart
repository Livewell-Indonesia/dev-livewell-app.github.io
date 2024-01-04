import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/auth/domain/usecase/post_google_auth.dart';
import 'package:livewell/feature/auth/domain/usecase/post_register.dart';
import 'package:livewell/feature/dashboard/domain/usecase/register_device_token.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';

class SignUpController extends BaseController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Rxn<String?> firstNameError = Rxn<String>();
  Rxn<String?> lastNameError = Rxn<String>();
  Rxn<String?> passwordError = Rxn<String>();
  Rxn<String?> emailError = Rxn<String>();

  PostRegister postRegister = PostRegister.instance();

  void onRegisterTapped() {
    doRegister();
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
      await registerDeviceToken();
      SharedPref.saveToken(r.accessToken!);
      SharedPref.saveRefreshToken(r.refreshToken!);
      AppNavigator.pushAndRemove(routeName: AppPages.home);
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
    if (!email.text.isEmail) {
      emailError.value = 'Email Not Valid';
      return;
    }
    emailError.value = null;
    if (password.text.isEmpty) {
      passwordError.value = 'Password Cannot Empty';
      return;
    }
    if (!password.text.isPasswordValid()) {
      passwordError.value = 'Password must contains 1 uppercase, 1 number and 1 symbol';
      return;
    }
    passwordError.value = null;

    await EasyLoading.show();
    final result = await postRegister.call(ParamsRegister(firstName: firstName.text, lastName: lastName.text, email: email.text, password: password.text));
    await EasyLoading.dismiss();
    result.fold((l) {}, (r) {
      AppNavigator.pushReplacement(routeName: AppPages.login);
      Get.snackbar("Success Register", "Verify your email");
    });
  }
}
