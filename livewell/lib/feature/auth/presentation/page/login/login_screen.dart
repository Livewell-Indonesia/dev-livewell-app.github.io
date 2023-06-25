import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/localization/languages.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/auth_textfield.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: controller.localization.signIn!,
        backgroundColor: Colors.white,
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
                  controller: controller.email,
                  hintText: null,
                  labelText: controller.localization.emailAddress!,
                  errorText: null,
                  obscureText: false,
                  isEmail: true),
              16.verticalSpace,
              Obx(() {
                return AuthTextField(
                    controller: controller.password,
                    hintText: null,
                    labelText: controller.localization.password!,
                    errorText: controller.passwordError.isEmpty
                        ? null
                        : controller.passwordError.value,
                    obscureText: true);
              }),
              32.verticalSpace,
              LiveWellButton(
                  label: controller.localization.signIn!,
                  color: const Color(0xFFDDF235),
                  onPressed: () {
                    controller.doLogin();
                  }),
              20.verticalSpace,
              TextButton(
                  onPressed: () {
                    AppNavigator.push(routeName: AppPages.forgotPassword);
                  },
                  child: Text(
                    controller.localization.forgotPassword!,
                    style: TextStyle(
                        color: const Color(0xFF8F01DF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  )),
              20.verticalSpace,
              Text(controller.localization.orSignInWith!,
                  style: TextStyle(fontSize: 16.sp)),
              20.verticalSpace,
              SigninThridPartyButton(
                  type: SignInButtonType.google,
                  onPressed: () {
                    controller.onGoogleLoginTapped();
                  }),
              4.verticalSpace,
              Platform.isIOS
                  ? SigninThridPartyButton(
                      type: SignInButtonType.apple,
                      onPressed: () async {
                        controller.onAppleIdTapped();
                      })
                  : Container(),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.localization.dontHaveAccount!,
                      style: TextStyle(
                          color: const Color(0xFF171433).withOpacity(0.7),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400)),
                  TextButton(
                      onPressed: () {
                        AppNavigator.push(routeName: AppPages.signup);
                      },
                      child: Text(
                        controller.localization.signUp!,
                        style: TextStyle(
                            color: const Color(0xFF8F01DF),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              24.verticalSpace,
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: controller
                            .localization.bySigningInAgreeToTermsAndConditions!,
                        style: TextStyle(
                            color: const Color(0xFF171433).withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text:
                                "${controller.localization.termsAndConditions} ",
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
                            text: '${controller.localization.and!} ',
                            style: TextStyle(
                                color: const Color(0xFF171433).withOpacity(0.7),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: controller.localization.privacyPolicy!,
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
              style: TextStyle(
                  color: type.textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
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
