import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/feature/auth/domain/usecase/post_update_password.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';
import 'package:livewell/feature/auth/presentation/page/update_password/update_password_screen.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';

class UpdatePasswordController extends BaseController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Rxn<String> newPasswordError = Rxn<String>();
  Rxn<String> confirmPasswordError = Rxn<String>();
  Rx<bool> isButtonEnabled = false.obs;

  PostUpdatePassword postUpdatePassword = PostUpdatePassword.instance();

  void validateButton() {
    if (newPassword.text.isEmpty) {
      newPasswordError.value = 'Please enter new password';
      isButtonEnabled.value = false;
    } else if (!newPassword.text.isPasswordValid()) {
      newPasswordError.value = 'Password must contains 1 uppercase, 1 number and 1 symbol';
      isButtonEnabled.value = false;
    } else {
      newPasswordError.value = null;
      if (confirmPassword.text.isEmpty) {
        confirmPasswordError.value = 'Please enter confirm password';
        isButtonEnabled.value = false;
      } else if (confirmPassword.text != newPassword.text) {
        confirmPasswordError.value = 'Password does not match';
        isButtonEnabled.value = false;
      } else {
        confirmPasswordError.value = null;
        isButtonEnabled.value = true;
      }
    }
  }

  void onButtonTapped(BuildContext context) async {
    if (isButtonEnabled.value) {
      EasyLoading.show();
      var result = await postUpdatePassword(UpdatePasswordParams(password: newPassword.text, confirmPassword: confirmPassword.text));
      EasyLoading.dismiss();
      result.fold((l) {
        Get.snackbar("Failed Change Password", l.message.toString());
      }, (r) {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            enableDrag: false,
            shape: shapeBorder(),
            builder: (context) {
              return const Wrap(
                children: [
                  BottomsheetSuccessChangePassword(),
                ],
              );
            });
      });
    }
  }

  @override
  void onInit() {
    newPassword.addListener(() {
      validateButton();
    });

    confirmPassword.addListener(() {
      validateButton();
    });
    super.onInit();
  }
}
