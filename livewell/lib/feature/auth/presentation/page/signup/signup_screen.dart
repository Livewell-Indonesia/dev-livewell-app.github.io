import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:livewell/core/localization/Languages.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';
import 'package:livewell/feature/auth/presentation/controller/signup_controller.dart';
import 'package:livewell/feature/auth/presentation/page/login/login_screen.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/auth_textfield.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        title: 'Create New Account',
        backgroundColor: Colors.white,
        body: Expanded(child: Obx(() {
          return ListView(
            children: [
              Center(
                child: Text(
                  AppStringsKeys.enterYourDetails.tr,
                  style: TextStyle(
                      color: const Color(0xB2171433),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
              24.verticalSpace,
              AuthTextField(
                  controller: controller.firstName,
                  hintText: null,
                  labelText: AppStringsKeys.firstName.tr,
                  errorText: controller.firstNameError.value,
                  obscureText: false),
              16.verticalSpace,
              AuthTextField(
                  controller: controller.lastName,
                  hintText: null,
                  labelText: AppStringsKeys.lastName.tr,
                  errorText: controller.lastNameError.value,
                  obscureText: false),
              16.verticalSpace,
              AuthTextField(
                  controller: controller.email,
                  hintText: null,
                  labelText: AppStringsKeys.email.tr,
                  errorText: controller.emailError.value,
                  isEmail: true,
                  obscureText: false),
              16.verticalSpace,
              AuthTextField(
                  controller: controller.password,
                  hintText: AppStringsKeys.password.tr,
                  labelText: AppStringsKeys.password.tr,
                  errorText: controller.passwordError.value,
                  obscureText: true),
              32.verticalSpace,
              LiveWellButton(
                  label: AppStringsKeys.signUp.tr,
                  color: const Color(0xFFDDF235),
                  onPressed: () {
                    controller.onRegisterTapped();
                    //AppNavigator.push(routeName: AppPages.questionnaire);
                  }),
              32.verticalSpace,
              Center(
                child: Text(
                  AppStringsKeys.or.tr,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF171433),
                      fontWeight: FontWeight.w500),
                ),
              ),
              16.verticalSpace,
              SigninThridPartyButton(
                  type: SignInButtonType.googleRegister,
                  onPressed: () {
                    controller.onGoogleLoginTapped();
                  }),
              4.verticalSpace,
              SigninThridPartyButton(
                  type: SignInButtonType.appleRegister, onPressed: () {}),
              24.verticalSpace,
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
              24.verticalSpace,
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: AppStringsKeys.bySigningUp.tr,
                        style: TextStyle(
                            color: const Color(0xFF171433).withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: AppStringsKeys.termsAndConditions.tr,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => const WebView(
                                      initialUrl:
                                          'https://livewellindo.com/terms',
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                    ));
                              },
                            style: TextStyle(
                                color: const Color(0xFF8F01DF),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: AppStringsKeys.and.tr,
                            style: TextStyle(
                                color: const Color(0xFF171433).withOpacity(0.7),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: AppStringsKeys.privacyPolicy.tr,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => const WebView(
                                      initialUrl:
                                          'https://livewellindo.com/privacy',
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                    ));
                              },
                            style: TextStyle(
                                color: const Color(0xFF8F01DF),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ])),
              ),
            ],
          );
        })));
  }
}
