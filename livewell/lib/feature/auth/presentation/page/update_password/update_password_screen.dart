import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/auth/presentation/controller/update_password_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  UpdatePasswordController controller = Get.put(UpdatePasswordController());

  @override
  void initState() {
    controller.trackEvent(LivewellProfileEvent.changePasswordPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: 'Change Password',
      body: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              24.verticalSpace,
              Text(
                'Enter New Password',
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryDarkBlue
                      .withOpacity(0.7),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              80.verticalSpace,
              Obx(() {
                return LivewellTextFieldWithError(
                  controller: controller.newPassword,
                  hintText: 'New Password',
                  errorText: controller.newPasswordError.value,
                );
              }),
              16.verticalSpace,
              Obx(() {
                return LivewellTextFieldWithError(
                  controller: controller.confirmPassword,
                  hintText: 'New Password Confirmation',
                  errorText: controller.confirmPasswordError.value,
                );
              }),
              const Spacer(),
              Obx(() {
                return LiveWellButton(
                    label: 'Change',
                    color: Theme.of(context).colorScheme.primaryGreen,
                    onPressed: controller.isButtonEnabled.value
                        ? () {
                            controller.trackEvent(LivewellProfileEvent
                                .changePasswordPageChangeButton);
                            controller.onButtonTapped(context);
                          }
                        : null);
              }),
              32.verticalSpace,
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class BottomsheetSuccessChangePassword extends StatelessWidget {
  const BottomsheetSuccessChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 32.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/icons/ic_update_password_success.png',
            width: 240.w,
            height: 240.h,
          ),
          32.verticalSpace,
          Text(
            'Password has been successfully changed',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryDarkBlue,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600),
          ),
          8.verticalSpace,
          Text(
            'Please login again to use the LiveWell application.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.disabled,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
          32.verticalSpace,
          LiveWellButton(
            label: 'Login',
            color: Theme.of(context).colorScheme.primaryGreen,
            onPressed: () {
              AppNavigator.pushAndRemove(routeName: AppPages.landingLogin);
            },
          ),
        ],
      ),
    );
  }
}

class LivewellTextFieldWithError extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  const LivewellTextFieldWithError(
      {super.key,
      required this.controller,
      required this.hintText,
      this.errorText});

  @override
  State<LivewellTextFieldWithError> createState() =>
      _LivewellTextFieldWithErrorState();
}

class _LivewellTextFieldWithErrorState
    extends State<LivewellTextFieldWithError> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          obscureText: isObscure,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                isObscure ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context)
                    .colorScheme
                    .secondaryDarkBlue
                    .withOpacity(0.7),
              ),
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
            ),
            hintText: widget.hintText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primaryGreen,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primaryGreen,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primaryGreen,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            hintStyle: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryDarkBlue
                  .withOpacity(0.5),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            errorText: widget.errorText,
            errorMaxLines: 2,
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        8.verticalSpace,
      ],
    );
  }
}
