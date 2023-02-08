import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/localization/languages.dart';
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
        title: AppStringsKeys.forgotPassword2.tr,
        body: Expanded(
          child: Column(
            children: [
              26.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).r,
                child: Text(
                  AppStringsKeys.forgotPasswordDesc.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
              ),
              30.verticalSpace,
              LiveWellTextField(
                controller: controller.email,
                hintText: null,
                labelText: AppStringsKeys.email,
                errorText: null,
                obscureText: false,
                isEmail: true,
              ),
              20.verticalSpace,
              LiveWellButton(
                  label: AppStringsKeys.submit,
                  color: const Color(0xFFDDF235),
                  onPressed: () {
                    controller.sendForgotPassword();
                  })
            ],
          ),
        ));
  }
}
