import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
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
    return LiveWellScaffold(
        title: '',
        backgroundColor: Colors.white,
        body: Expanded(
          child: Column(
            children: [
              const Spacer(),
              Image.asset(Constant.imgLogo),
              const Spacer(),
              LiveWellTextField(
                  controller: controller.email,
                  hintText: null,
                  labelText: AppStringsKeys.email.tr,
                  errorText: null,
                  obscureText: false,
                  isEmail: true),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              LiveWellButton(
                  label: AppStringsKeys.signIn.tr,
                  color: const Color(0xFFDDF235),
                  onPressed: () {
                    controller.doLogin();
                  }),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    AppNavigator.push(routeName: AppPages.forgotPassword);
                  },
                  child: Text(
                    AppStringsKeys.forgotPassword.tr,
                    style: const TextStyle(
                        color: Color(0xFF8F01DF),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),
              const SizedBox(height: 20),
              Text(AppStringsKeys.orSignInWith.tr,
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              SignInButton(Buttons.Google, onPressed: () {
                controller.onGoogleLoginTapped();
              }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStringsKeys.dontHaveAccount.tr,
                      style: TextStyle(
                          color: const Color(0xFF171433).withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  TextButton(
                      onPressed: () {
                        AppNavigator.push(routeName: AppPages.signup);
                      },
                      child: Text(
                        AppStringsKeys.signUp.tr,
                        style: const TextStyle(
                            color: Color(0xFF8F01DF),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              SizedBox(
                height: 11,
              ),
            ],
          ),
        ));
  }
}
