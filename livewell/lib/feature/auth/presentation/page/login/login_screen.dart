import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/auth_textfield.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  void initState() {
    controller.trackEvent(LivewellAuthEvent.signInPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: controller.localization.signInPage?.signIn ?? "Sign In",
        backgroundColor: Colors.white,
        onBack: () {
          Get.back();
          controller.trackEvent(LivewellAuthEvent.signInPageBack);
        },
        body: Expanded(
          child: Column(
            children: [
              48.verticalSpace,
              SvgPicture.asset(
                "assets/images/FA_Livewell_Logo_2.svg",
                fit: BoxFit.cover,
                color: const Color(0xFF34EAB2),
                width: 112.w,
                height: 24.h,
              ),
              68.verticalSpace,
              AuthTextField(
                  controller: controller.email, hintText: null, labelText: controller.localization.signInPage?.emailAddress ?? "Email Address", errorText: null, obscureText: false, isEmail: true),
              16.verticalSpace,
              Obx(() {
                return AuthTextField(
                    controller: controller.password,
                    hintText: null,
                    labelText: controller.localization.signInPage?.password ?? "Password",
                    errorText: controller.passwordError.isEmpty ? null : controller.passwordError.value,
                    obscureText: true);
              }),
              32.verticalSpace,
              LiveWellButton(
                  label: controller.localization.signInPage?.signIn ?? "Sign In",
                  color: const Color(0xFFDDF235),
                  onPressed: () {
                    controller.trackEvent(LivewellAuthEvent.signInPageSignInButton);
                    controller.doLogin();
                  }),
              20.verticalSpace,
              TextButton(
                  onPressed: () {
                    AppNavigator.push(routeName: AppPages.forgotPassword);
                  },
                  child: Text(
                    controller.localization.signInPage?.forgotPassword ?? "Forgot Password?",
                    style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 16.sp, fontWeight: FontWeight.w500),
                  )),
              20.verticalSpace,
              Text(controller.localization.signInPage?.orSignInWith ?? "Or Sign in with", style: TextStyle(fontSize: 16.sp)),
              20.verticalSpace,
              SigninThridPartyButton(
                  type: SignInButtonType.google,
                  onPressed: () {
                    controller.trackEvent(LivewellAuthEvent.signInPageSignInGoogle);
                    controller.onGoogleLoginTapped();
                  }),
              4.verticalSpace,
              GetPlatform.isIOS
                  ? SigninThridPartyButton(
                      type: SignInButtonType.apple,
                      onPressed: () async {
                        controller.trackEvent(LivewellAuthEvent.signInPageSignInApple);
                        controller.onAppleIdTapped();
                      })
                  : Container(),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.localization.signInPage?.dontHaveAccount ?? "Don't have account?",
                      style: TextStyle(color: const Color(0xFF171433).withOpacity(0.7), fontSize: 16.sp, fontWeight: FontWeight.w400)),
                  TextButton(
                      onPressed: () {
                        controller.trackEvent(LivewellAuthEvent.signInPageSignUp);
                        AppNavigator.push(routeName: AppPages.signup);
                      },
                      child: Text(
                        controller.localization.signInPage?.signUp ?? "Sign Up",
                        style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 16.sp, fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              24.verticalSpace,
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: controller.localization.signInPage?.bySigningInAgreeToTermsAndConditions ?? "By signing in above, I agree to Livewell's ",
                        style: TextStyle(color: const Color(0xFF171433).withOpacity(0.7), fontSize: 14.sp, fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "${controller.localization.signInPage?.termsAndConditions ?? "Terms & Conditions"} ",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.trackEvent(LivewellAuthEvent.signInPageTnc);
                                Get.to(() => const WebView(
                                      initialUrl: 'https://livewellindo.com/terms',
                                      javascriptMode: JavascriptMode.unrestricted,
                                    ));
                              },
                            style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: '${controller.localization.signInPage?.and ?? "and"} ',
                            style: TextStyle(color: const Color(0xFF171433).withOpacity(0.7), fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: controller.localization.signInPage?.privacyPolicy ?? "Privacy Policy",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.trackEvent(LivewellAuthEvent.signInPagePrivacyPolicy);
                                Get.to(() => const WebView(
                                      initialUrl: 'https://livewellindo.com/privacy',
                                      javascriptMode: JavascriptMode.unrestricted,
                                    ));
                              },
                            style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                        ])),
              ),
            ],
          ),
        ));
  }
}

class SigninThridPartyButton extends StatelessWidget {
  const SigninThridPartyButton({
    Key? key,
    required this.type,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final SignInButtonType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MaterialButton(
        //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        color: type.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              type.asset,
              fit: BoxFit.cover,
              width: 14,
              height: 16,
            ),
            const Spacer(),
            Text(
              type.title,
              style: TextStyle(color: type.textColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            const Spacer()
          ],
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}

enum SignInButtonType {
  google,
  apple,
  googleRegister,
  appleRegister,
}

extension SignInButtonTypeExtension on SignInButtonType {
  String get title {
    switch (this) {
      case SignInButtonType.google:
        return "Sign in with Google";
      case SignInButtonType.apple:
        return "Sign in with Apple";
      case SignInButtonType.googleRegister:
        return "Sign up with Google";
      case SignInButtonType.appleRegister:
        return "Sign up with Apple";
    }
  }

  Color get textColor {
    switch (this) {
      case SignInButtonType.google:
        return Colors.black.withOpacity(0.54);
      case SignInButtonType.googleRegister:
        return Colors.black.withOpacity(0.54);
      case SignInButtonType.apple:
        return Colors.white;
      case SignInButtonType.appleRegister:
        return Colors.white;
    }
  }

  String get asset {
    switch (this) {
      case SignInButtonType.google:
        return "assets/images/logo_googleg_48dp.svg";
      case SignInButtonType.apple:
        return "assets/images/icons8-apple-logo.svg";
      case SignInButtonType.googleRegister:
        return "assets/images/logo_googleg_48dp.svg";
      case SignInButtonType.appleRegister:
        return "assets/images/icons8-apple-logo.svg";
    }
  }

  Color get color {
    switch (this) {
      case SignInButtonType.google:
        return Colors.white;
      case SignInButtonType.apple:
        return Colors.black;
      case SignInButtonType.googleRegister:
        return Colors.white;
      case SignInButtonType.appleRegister:
        return Colors.black;
    }
  }
}
