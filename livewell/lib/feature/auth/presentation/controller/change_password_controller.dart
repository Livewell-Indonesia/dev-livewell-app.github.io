import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/auth/domain/usecase/post_change_password.dart';
import 'package:livewell/widgets/dialog/success_reset_password_dialog.dart';

class ChangePasswordController extends GetxController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var pin = ''.obs;

  Rxn<String> passwordError = Rxn<String>();
  Rxn<String> pinError = Rxn<String>();

  PostChangePassword postChangePassword = PostChangePassword.getInstance();

  void onChangePressed() {
    if (newPassword.text.isEmpty) {
      passwordError.value = 'Password Empty';
      return;
    } else {
      passwordError.value = null;
    }
    if (confirmPassword.text.isEmpty) {
      passwordError.value = 'Confirm Password Empty';
      return;
    } else {
      passwordError.value = null;
    }
    if (pin.value.isEmpty) {
      pinError.value = 'Pin Empty';
      return;
    } else {
      pinError.value = null;
    }
    if (newPassword.text != confirmPassword.text) {
      passwordError.value = 'Password not match';
      return;
    } else {
      passwordError.value = null;
    }
    changePassword();
  }

  void changePassword() async {
    final result = await postChangePassword(
        ChangePasswordParams(code: pin.value, newPassword: newPassword.text));
    result.fold((l) {
      Get.snackbar("Error", l.toString());
    }, (r) {
      Get.dialog(const SuccessChangePasswordDialog(),
          barrierDismissible: false,
          barrierColor: const Color(0xFF555555).withOpacity(0.9));
    });
  }
}
