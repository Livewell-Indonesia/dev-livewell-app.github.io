import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final LoginController controller = Get.find();

  @override
  void initState() {
    controller.trackEvent(LivewellAuthEvent.forgotPasswordPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        backgroundColor: Colors.white,
        title: controller.localization.forgotPasswordPage?.forgotPassword ?? "Forgot Password",
        onBack: () {
          Get.back();
          controller.trackEvent(LivewellAuthEvent.forgotPasswordBack);
        },
        body: Expanded(
          child: Column(
            children: [
              26.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).r,
                child: Text(
                  controller.localization.forgotPasswordPage?.pleaseEnterEmailToResetPassword ?? "Please enter your email address. You will receive a link to create a new password via email.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
              ),
              30.verticalSpace,
              Obx(() {
                return LiveWellTextField(
                  controller: controller.forgotPasswordEmail,
                  hintText: null,
                  labelText: controller.localization.forgotPasswordPage?.emailAddress ?? "Email Address",
                  errorText: null,
                  obscureText: false,
                  isEmail: controller.isEmailValid.value,
                );
              }),
              20.verticalSpace,
              Obx(() {
                return LiveWellButton(
                    label: controller.localization.forgotPasswordPage?.submit ?? "Submit",
                    color: const Color(0xFFDDF235),
                    onPressed: (controller.isEmailValid.value ?? false)
                        ? () {
                            controller.trackEvent(LivewellAuthEvent.forgotPasswordSubmit);
                            controller.sendForgotPassword();
                          }
                        : null);
              })
            ],
          ),
        ));
  }
}
