import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/primary_button.dart';
import 'package:livewell/widgets/textfield/primary_textfield.dart';
import 'package:pinput/pinput.dart';

import '../../../feature/auth/presentation/controller/login_controller.dart';
import '../../../feature/auth/presentation/page/new_password/new_password_screen.dart';

class ForgotPasswordBottomSheet extends StatelessWidget {
  final LoginController controller = Get.find();

  ForgotPasswordBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
      ),
      child: Obx(() {
        if (controller.showOtpInput.value) {
          return OtpInput(controller: controller);
        } else {
          return ForgotPasswordInput(controller: controller);
        }
      }),
    );
  }
}

class OtpInput extends StatelessWidget {
  final LoginController controller;

  const OtpInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            'Forgot Password',
            style: TextStyles.bodyStrong(color: AppColors.textLoEm),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Center(
          child: Pinput(
            length: 4,
            controller: controller.pin,
            obscureText: false,
            defaultPinTheme: PinTheme(
                width: 60,
                height: 60,
                textStyle: TextStyles.subTitleHiEm(color: Colors.black),
                decoration: BoxDecoration(
                  color: AppColors.primary5,
                  borderRadius: BorderRadius.circular(8),
                )),
            separatorPositions: const [1, 2, 3],
            separator: const SizedBox(
              width: 32.0,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          width: double.infinity,
          child: Text('Enter verification code you received in your email',
              textAlign: TextAlign.start,
              style: TextStyles.bodySmall(color: AppColors.primary75)),
        ),
        const SizedBox(
          height: 12.0,
        ),
        PrimaryButton(
          label: 'Verify',
          color: AppColors.primary100,
          onPressed: () {
            Get.to(NewPasswordScreen());
          },
        ),
        const SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}

showDialog() {
  Get.dialog(WillPopScope(
    onWillPop: () async => false,
    child: const Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColors.primary100,
        color: AppColors.primary25,
      ),
    ),
  ));
}

closeDialog() {
  Get.back();
}

class ForgotPasswordInput extends StatelessWidget {
  const ForgotPasswordInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Forgot Password',
            style: TextStyles.bodyStrong(color: AppColors.textLoEm),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        PrimaryTextField(
            controller: controller.forgotPasswordEmail,
            hintText: "user@mail.com",
            errorText: "",
            obscureText: false,
            labelText: "email address"),
        const SizedBox(
          height: 12.0,
        ),
        Center(
          child: Text('We\'ll send you verification code through your email :)',
              style: TextStyles.bodySmall(color: AppColors.primary75)),
        ),
        const SizedBox(
          height: 12.0,
        ),
        PrimaryButton(
            label: 'Send Verification Code',
            color: AppColors.primary100,
            onPressed: () {
              controller.sendVerification();
            }),
        const SizedBox(
          height: 12.0,
        )
      ],
    );
  }
}
