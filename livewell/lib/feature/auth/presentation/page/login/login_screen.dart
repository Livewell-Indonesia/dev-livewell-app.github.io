import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/localization/Languages.dart';
import 'package:livewell/feature/auth/presentation/controller/login_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/auth_textfield.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Sign In',
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
                  labelText: AppStringsKeys.email.tr,
                  errorText: null,
                  obscureText: false,
                  isEmail: true),
              16.verticalSpace,
              Obx(() {
                return AuthTextField(
                    controller: controller.password,
                    hintText: null,
                    labelText: AppStringsKeys.password.tr,
                    errorText: controller.passwordError.isEmpty
                        ? null
                        : controller.passwordError.value,
                    obscureText: true);
              }),
              32.verticalSpace,
              LiveWellButton(
                  label: AppStringsKeys.signIn.tr,
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
                    AppStringsKeys.forgotPassword.tr,
                    style: TextStyle(
                        color: const Color(0xFF8F01DF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  )),
              20.verticalSpace,
              Text(AppStringsKeys.orSignInWith.tr,
                  style: TextStyle(fontSize: 16.sp)),
              20.verticalSpace,
              SigninThridPartyButton(
                  type: SignInButtonType.google,
                  onPressed: () {
                    controller.onGoogleLoginTapped();
                  }),
              4.verticalSpace,
              SigninThridPartyButton(
                  type: SignInButtonType.apple,
                  onPressed: () async {
                    final credential =
                        await SignInWithApple.getAppleIDCredential(scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ]);
                    print(credential);
                  }),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStringsKeys.dontHaveAccount.tr,
                      style: TextStyle(
                          color: const Color(0xFF171433).withOpacity(0.7),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400)),
                  TextButton(
                      onPressed: () {
                        AppNavigator.push(routeName: AppPages.signup);
                      },
                      child: Text(
                        AppStringsKeys.signUp.tr,
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
                        text: AppStringsKeys.bySigninAbove.tr,
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
