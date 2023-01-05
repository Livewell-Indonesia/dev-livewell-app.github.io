import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/auth/domain/usecase/post_register.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';

class SignUpController extends GetxController {
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

  void doRegister() async {
    if (firstName.text.isEmpty) {
      firstNameError.value = 'First Name Cannot Empty';
      return;
    }
    firstNameError.value = null;
    if (lastName.text.isEmpty) {
      lastNameError.value = 'Last Name Cannot Empty';
      return;
    }
    lastNameError.value = null;
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
      passwordError.value =
          'Password must contains 1 uppercase, 1 number and 1 symbol';
      return;
    }
    passwordError.value = null;

    await EasyLoading.show();
    final result = await postRegister.call(ParamsRegister(
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        password: password.text));
    await EasyLoading.dismiss();
    result.fold((l) {}, (r) {
      AppNavigator.pushReplacement(routeName: AppPages.login);
      Get.snackbar("Success Register", "Verify your email");
    });
  }
}
