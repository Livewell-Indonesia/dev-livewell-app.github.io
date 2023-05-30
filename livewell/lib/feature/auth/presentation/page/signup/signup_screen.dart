import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/localization/languages.dart';
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
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Create New Account'.tr,
        backgroundColor: Colors.white,
        body: Expanded(child: Obx(() {
          return ListView(
            children: [
              Center(
                child: Text(
                  'Enter your details to register'.tr,
                  style: TextStyle(
                      color: const Color(0xB2171433),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
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
                  labelText: 'Email Address'.tr,
                  errorText: controller.emailError.value,
                  isEmail: true,
                  obscureText: false),
              16.verticalSpace,
              AuthTextField(
                  controller: controller.password,
                  hintText: 'Password'.tr,
                  labelText: 'Password'.tr,
                  errorText: controller.passwordError.value,
                  obscureText: true),
              32.verticalSpace,
              LiveWellButton(
                  label: 'Sign Up'.tr,
                  color: const Color(0xFFDDF235),
                  onPressed: () {
                    controller.onRegisterTapped();
                    //AppNavigator.push(routeName: AppPages.questionnaire);
                  }),
              32.verticalSpace,
              Center(
                child: Text(
                  'Or '.tr,
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
              // 4.verticalSpace,
              // SigninThridPartyButton(
              //     type: SignInButtonType.appleRegister, onPressed: () {}),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have account?'.tr,
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
                        'Sign In'.tr,
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
                        text: 'By signing up, I agree to Livewell’s \n'.tr,
                        style: TextStyle(
                            color: const Color(0xFF171433).withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions '.tr,
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
                            text: "and".tr,
                            style: TextStyle(
                                color: const Color(0xFF171433).withOpacity(0.7),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: 'Privacy Policy '.tr,
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
