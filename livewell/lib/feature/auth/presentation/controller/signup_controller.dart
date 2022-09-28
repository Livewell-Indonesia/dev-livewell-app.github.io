import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/auth/domain/usecase/post_register.dart';
import 'package:livewell/routes/app_navigator.dart';

class SignUpController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  PostRegister postRegister = PostRegister.instance();

  void onRegisterTapped() {
    doRegister();
  }

  void doRegister() async {
    EasyLoading.show();
    final result = await postRegister.call(ParamsRegister(
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        password: password.text));
    EasyLoading.dismiss();
    result.fold((l) {}, (r) {
      AppNavigator.pushReplacement(routeName: AppPages.login);
      Get.snackbar("Success Register", "Verify your email");
    });
  }
}
