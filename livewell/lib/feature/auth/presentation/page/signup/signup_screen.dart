import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:livewell/core/localization/Languages.dart';
import 'package:livewell/feature/auth/presentation/controller/signup_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/questionnaire_screen.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

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
  SignUpController controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: '',
        backgroundColor: Colors.white,
        body: Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(AppStringsKeys.createNewAccount.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF171433),
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600)),
              ),
              Text(AppStringsKeys.enterYourDetails.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color(0xFF171433).withOpacity(0.7),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600)),
              20.verticalSpace,
              LiveWellTextField(
                  controller: controller.firstName,
                  hintText: null,
                  labelText: AppStringsKeys.firstName.tr,
                  errorText: null,
                  obscureText: false),
              20.verticalSpace,
              LiveWellTextField(
                  controller: controller.lastName,
                  hintText: null,
                  labelText: AppStringsKeys.lastName.tr,
                  errorText: null,
                  obscureText: false),
              20.verticalSpace,
              LiveWellTextField(
                  controller: controller.email,
                  hintText: null,
                  labelText: AppStringsKeys.email.tr,
                  errorText: null,
                  isEmail: true,
                  obscureText: false),
              20.verticalSpace,
              LiveWellTextField(
                  controller: controller.password,
                  hintText: null,
                  labelText: AppStringsKeys.password.tr,
                  errorText: null,
                  obscureText: true),
              20.verticalSpace,
              LiveWellButton(
                  label: AppStringsKeys.signUp.tr,
                  color: const Color(0xFFDDF235),
                  onPressed: () {
                    Get.to(() => QuestionnaireScreen());
                  }),
              20.verticalSpace,
              Center(
                child: Text(
                  AppStringsKeys.orSignUpWith.tr,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF171433),
                      fontWeight: FontWeight.w500),
                ),
              ),
              16.verticalSpace,

              Center(
                child: SignInButton(
                  Buttons.Google,
                  onPressed: () {},
                  text: "Sign up with Google",
                ),
              ),
              //Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStringsKeys.alreadyHaveAccount.tr,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF171433),
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        AppStringsKeys.signIn.tr,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF8F01DF),
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
