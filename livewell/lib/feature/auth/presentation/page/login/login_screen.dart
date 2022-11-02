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
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 1.sw,
          height: 1.sh,
          color: Colors.white,
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.only(left: 0.2.sw),
            height: 0.32.sh,
            child: Transform.scale(
                scale: 2,
                child: SvgPicture.asset(
                  "assets/images/FA_Livewell_Supergraphic.svg",
                  color: const Color(0xFF8F01DF).withOpacity(0.05),
                )),
          ),
        ),
        LiveWellScaffold(
            title: '',
            backgroundColor: Colors.transparent,
            body: Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  AspectRatio(
                    aspectRatio: 5,
                    child: SvgPicture.asset(
                      "assets/images/FA_Livewell_Logo.svg",
                      fit: BoxFit.cover,
                      color: const Color(0xFF34EAB2),
                    ),
                  ),
                  Text(AppStringsKeys.letsYourNewHealth.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF171433).withOpacity(0.7))),
                  const Spacer(),
                  LiveWellTextField(
                      controller: controller.email,
                      hintText: null,
                      labelText: AppStringsKeys.email.tr,
                      errorText: null,
                      obscureText: false,
                      isEmail: true),
                  12.verticalSpace,
                  Obx(() {
                    return LiveWellTextField(
                        controller: controller.password,
                        hintText: null,
                        labelText: AppStringsKeys.password.tr,
                        errorText: controller.passwordError.isEmpty
                            ? null
                            : controller.passwordError.value,
                        obscureText: true);
                  }),
                  20.verticalSpace,
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
                            fontWeight: FontWeight.w400),
                      )),
                  20.verticalSpace,
                  Text(AppStringsKeys.orSignInWith.tr,
                      style: const TextStyle(fontSize: 16)),
                  20.verticalSpace,
                  SignInButton(Buttons.Google, onPressed: () {
                    controller.onGoogleLoginTapped();
                  }),
                  20.verticalSpace,
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
                  11.verticalSpace,
                ],
              ),
            )),
      ],
    );
  }
}
