import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme/design_system.dart';
import '../../../../../widgets/appBar/large_appbar.dart';
import '../../../../../widgets/buttons/primary_button.dart';
import '../../../../../widgets/textfield/primary_textfield.dart';
import '../../controller/new_password_controller.dart';

class NewPasswordScreen extends StatelessWidget {
  final NewPasswordController controller = Get.put(NewPasswordController());
  NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            const LargeAppBar(
              title: 'New Password',
              backgroundColor: Colors.white,
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 64.0,
                  ),
                  PrimaryTextField(
                    controller: controller.newPassword,
                    hintText: 'Enter new password',
                    labelText: 'Enter new password',
                    obscureText: false,
                    errorText: 'Error',
                  ),
                  const SizedBox(
                    height: Insets.spacingMedium,
                  ),
                  PrimaryTextField(
                    controller: controller.confirmPassword,
                    hintText: 'Password',
                    labelText: 'Password',
                    obscureText: true,
                    errorText: 'Error',
                  ),
                  const SizedBox(
                    height: Insets.spacingLarge,
                  ),
                  PrimaryButton(
                      label: 'Submit & Login',
                      color: AppColors.primary100,
                      onPressed: () {})
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
