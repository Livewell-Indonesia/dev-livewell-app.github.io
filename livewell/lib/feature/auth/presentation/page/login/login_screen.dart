import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';
import 'package:livewell/widgets/appBar/large_appbar.dart';

import '../../../../../theme/design_system.dart';
import '../../../../../widgets/buttons/primary_button.dart';
import '../../../../../widgets/textfield/primary_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const LargeAppBar(title: 'Login'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 64.0,
                  ),
                  PrimaryTextField(
                    controller: controller.email,
                    hintText: 'Email',
                    labelText: 'Email',
                    obscureText: false,
                    errorText: 'Error',
                  ),
                  const SizedBox(
                    height: Insets.spacingMedium,
                  ),
                  PrimaryTextField(
                    controller: controller.password,
                    hintText: 'Password',
                    labelText: 'Password',
                    obscureText: true,
                    errorText: 'Error',
                  ),
                  const SizedBox(
                    height: Insets.spacingLarge,
                  ),
                  PrimaryButton(
                      label: 'Login',
                      color: AppColors.primary100,
                      onPressed: () {}),
                  const SizedBox(
                    height: Insets.spacingLarge,
                  ),
                  Text(
                    'Or, continue with',
                    style: TextStyles.body(color: AppColors.textLoEm),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Have a Livewell account?',
                          style: TextStyles.body(color: AppColors.textLoEm)),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Sign up',
                            style: TextStyles.bodyStrong(
                                color: AppColors.secondary100),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
