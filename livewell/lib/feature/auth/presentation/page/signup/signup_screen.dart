import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/auth/presentation/controller/signup_controller.dart';
import 'package:livewell/feature/auth/presentation/page/login/login_screen.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/auth_textfield.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController controller = Get.put(SignUpController());

  @override
  void initState() {
    controller.trackEvent(LivewellAuthEvent.signUpPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: controller.localization.signUpPage?.createNewAccount ?? "Create New Account",
        backgroundColor: Colors.white,
        onBack: () {
          Get.back();
          controller.trackEvent(LivewellAuthEvent.signUpPageBack);
        },
        body: Expanded(child: Obx(() {
          return ListView(
            children: [
              Center(
                child: Text(
                  controller.localization.signUpPage?.enterYourDetailsToRegister ?? "Enter Your Details To Register",
                  style: TextStyle(color: const Color(0xB2171433), fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
              24.verticalSpace,
              // AuthTextField(
              //     controller: controller.firstName,
              //     hintText: null,
              //     labelText: 'First Name'.tr,
              //     errorText: controller.firstNameError.value,
              //     obscureText: false),
              // 16.verticalSpace,
              // AuthTextField(
              //     controller: controller.lastName,
              //     hintText: null,
              //     labelText: 'Last Name'.tr,
              //     errorText: controller.lastNameError.value,
              //     obscureText: false),
              // 16.verticalSpace,
              AuthTextField(
                  controller: controller.email,
                  hintText: null,
                  labelText: controller.localization.signUpPage?.emailAddress ?? "Email Address",
                  errorText: controller.emailError.value,
                  isEmail: true,
                  obscureText: false),
              16.verticalSpace,
              AuthTextField(
                  controller: controller.password,
                  hintText: controller.localization.signUpPage?.password ?? "Password",
                  labelText: controller.localization.signUpPage?.password ?? "Password",
                  errorText: controller.passwordError.value,
                  obscureText: true),
              16.verticalSpace,
              AuthTextField(
                  controller: controller.confirmPassword,
                  hintText: controller.localization.signUpPage?.confirmPassword ?? "Confirm Password",
                  labelText: controller.localization.signUpPage?.confirmPassword ?? "Confirm Password",
                  errorText: controller.confirmPasswordError.value,
                  obscureText: true),
              32.verticalSpace,
              Obx(() {
                return LiveWellButton(
                    label: controller.localization.signUpPage?.signUp ?? "Sign Up",
                    color: const Color(0xFFDDF235),
                    onPressed: controller.isButtonEnabled.value ? () => controller.onRegisterTapped() : null);
              }),
              32.verticalSpace,
              Center(
                child: Text(
                  'Or '.tr,
                  style: const TextStyle(fontSize: 16, color: Color(0xFF171433), fontWeight: FontWeight.w500),
                ),
              ),
              16.verticalSpace,
              SigninThridPartyButton(
                  type: SignInButtonType.google,
                  onPressed: () {
                    controller.onGoogleLoginTapped();
                    controller.trackEvent(LivewellAuthEvent.signUpPageSignUpGoogle);
                  }),
              4.verticalSpace,
              GetPlatform.isIOS
                  ? SigninThridPartyButton(
                      type: SignInButtonType.apple,
                      onPressed: () async {
                        controller.onAppleIdTapped();
                        controller.trackEvent(LivewellAuthEvent.signUpPageSignUpApple);
                      })
                  : Container(),
              // 4.verticalSpace,
              // SigninThridPartyButton(
              //     type: SignInButtonType.appleRegister, onPressed: () {}),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.localization.signUpPage?.alreadyHaveAccount ?? "Already have account?",
                    style: const TextStyle(fontSize: 16, color: Color(0xFF171433), fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.back();
                        controller.trackEvent(LivewellAuthEvent.signUpPageSignIn);
                      },
                      child: Text(
                        controller.localization.signUpPage?.signIn ?? "Sign In",
                        style: const TextStyle(fontSize: 16, color: Color(0xFF8F01DF), fontWeight: FontWeight.w500),
                      ))
                ],
              ),
              24.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: controller.localization.signUpPage?.bySigningUpIAgreeToLivewellS ?? "By signing up, I agree to Livewell's ",
                          style: TextStyle(color: const Color(0xFF171433).withOpacity(0.7), fontSize: 14.sp, fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: " ${controller.localization.signUpPage?.termsAndConditions ?? "Terms & Conditions"} ",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  controller.trackEvent(LivewellAuthEvent.signUpPageTnc);
                                  Get.to(() => const WebView(
                                        initialUrl: 'https://livewellindo.com/terms',
                                        javascriptMode: JavascriptMode.unrestricted,
                                      ));
                                },
                              style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: "${controller.localization.signUpPage?.and ?? "and"} ",
                              style: TextStyle(color: const Color(0xFF171433).withOpacity(0.7), fontSize: 14.sp, fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: controller.localization.signUpPage?.privacyPolicy ?? "Privacy Policy",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  controller.trackEvent(LivewellAuthEvent.signUpPagePrivacyPolicy);
                                  Get.to(
                                      () => const WebView(
                                            initialUrl: 'https://livewellindo.com/privacy',
                                            javascriptMode: JavascriptMode.unrestricted,
                                          ),
                                      transition: Transition.cupertino);
                                },
                              style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ])),
                ),
              ),
            ],
          );
        })));
  }
}
