import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:livewell/core/localization/Languages.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';
import 'package:livewell/feature/auth/presentation/controller/signup_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
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
        title: '',
        backgroundColor: Colors.white,
        body: Expanded(child: Obx(() {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(AppStringsKeys.createNewAccount.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xFF171433),
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
                  errorText: controller.firstNameError.value,
                  obscureText: false),
              20.verticalSpace,
              LiveWellTextField(
                  controller: controller.lastName,
                  hintText: null,
                  labelText: AppStringsKeys.lastName.tr,
                  errorText: controller.lastNameError.value,
                  obscureText: false),
              20.verticalSpace,
              LiveWellTextField(
                  controller: controller.email,
                  hintText: null,
                  labelText: AppStringsKeys.email.tr,
                  errorText: controller.emailError.value,
                  isEmail: true,
                  obscureText: false),
              20.verticalSpace,
              LiveWellTextField(
                  controller: controller.password,
                  hintText: AppStringsKeys.password.tr,
                  labelText: AppStringsKeys.password.tr,
                  errorText: controller.passwordError.value,
                  obscureText: true),
              20.verticalSpace,
              LiveWellButton(
                  label: AppStringsKeys.signUp.tr,
                  color: const Color(0xFFDDF235),
                  onPressed: () {
                    controller.onRegisterTapped();
                    //AppNavigator.push(routeName: AppPages.questionnaire);
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
                  onPressed: () {
                    controller.onGoogleLoginTapped();
                  },
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
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              'By clicking "Sign Up / Sign up with google" above, you acknowledge that you have read and understood, and agree to LIVEWELL\'s\n ',
                          style: TextStyle(
                              color: const Color(0xFF171433).withOpacity(0.7),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: 'Terms & condition',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const WebView(
                                  initialUrl: 'https://livewellindo.com/terms',
                                  javascriptMode: JavascriptMode.unrestricted,
                                ));
                          },
                        style: TextStyle(
                            color: const Color(0xFF171433).withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                            color: const Color(0xFF171433).withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: 'Privacy policy',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const WebView(
                                  initialUrl:
                                      'https://livewellindo.com/privacy',
                                  javascriptMode: JavascriptMode.unrestricted,
                                ));
                            //AppNavigator.push(routeName: AppPages.privacyPolicy);
                          },
                        style: TextStyle(
                            color: const Color(0xFF171433).withOpacity(0.7),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline),
                      )
                    ])),
              ),
            ],
          );
        })));
  }
}
