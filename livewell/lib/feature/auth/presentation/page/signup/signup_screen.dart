import 'package:flutter/material.dart';

import '../../../../../theme/design_system.dart';
import '../../../../../widgets/appBar/large_appbar.dart';
import '../../../../../widgets/buttons/primary_button.dart';
import '../../../../../widgets/textfield/primary_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            const LargeAppBar(
              title: 'Sign Up',
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(
                    height: Insets.spacingLarge,
                  ),
                  PrimaryTextField(
                    controller: email,
                    hintText: 'Email',
                    labelText: 'Email',
                    obscureText: false,
                    errorText: 'Error',
                  ),
                  const SizedBox(
                    height: Insets.spacingMedium,
                  ),
                  PrimaryTextField(
                    controller: fullName,
                    hintText: 'Full Name',
                    labelText: 'John Doe',
                    obscureText: true,
                    errorText: 'Error',
                  ),
                  const SizedBox(
                    height: Insets.spacingMedium,
                  ),
                  PrimaryTextField(
                    controller: password,
                    hintText: 'Password',
                    labelText: 'Password',
                    obscureText: true,
                    errorText: 'Error',
                  ),
                  const SizedBox(
                    height: Insets.spacingLarge,
                  ),
                  PrimaryButton(
                      label: 'Sign Up',
                      color: AppColors.primary100,
                      onPressed: () {}),
                  const SizedBox(
                    height: Insets.spacingLarge,
                  ),
                  Text(
                    'Or, continue with',
                    style: TextStyles.body(color: AppColors.textLoEm),
                  ),
                  // TODO: Add social media buttons
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
              )),
            ),
          ],
        ),
      ),
    );
  }
}
