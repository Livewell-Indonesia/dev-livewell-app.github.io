import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final LoginController controller = Get.find();
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        backgroundColor: Colors.white,
        title: controller.localization.forgotPasswordText!,
        body: Expanded(
          child: Column(
            children: [
              26.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).r,
                child: Text(
                  controller.localization.pleaseEnterEmailToResetPassword!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
              ),
              30.verticalSpace,
              Obx(() {
                return LiveWellTextField(
                  controller: controller.forgotPasswordEmail,
                  hintText: null,
                  labelText: controller.localization.emailAddress!,
                  errorText: null,
                  obscureText: false,
                  isEmail: controller.isEmailValid.value,
                );
              }),
              20.verticalSpace,
              Obx(() {
                return LiveWellButton(
                    label: controller.localization.submit!,
                    color: const Color(0xFFDDF235),
                    onPressed: (controller.isEmailValid.value ?? false)
                        ? () {
                            controller.sendForgotPassword();
                          }
                        : null);
              })
            ],
          ),
        ));
  }
}
