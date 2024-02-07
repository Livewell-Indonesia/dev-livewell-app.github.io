import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:pinput/pinput.dart';

import '../../../../../widgets/buttons/livewell_button.dart';
import '../../../../../widgets/textfield/livewell_textfield.dart';
import '../../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController controller =
      Get.put(ChangePasswordController());

  final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 50.w,
      textStyle: TextStyle(
          fontSize: 16.sp,
          color: const Color(0xFF171433),
          fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(14.r),
      ));
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: controller.localization.changePassword!,
        backgroundColor: const Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: Column(
            children: [
              50.verticalSpace,
              Text(
                controller.localization.enterYourOtp!,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF171433).withOpacity(0.7),
                    fontWeight: FontWeight.w500),
              ),
              20.verticalSpace,
              Pinput(
                length: 4,
                forceErrorState: true,
                errorText: null,
                defaultPinTheme: defaultPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                onCompleted: (val) {
                  controller.pin.value = val;
                },
              ),
              20.verticalSpace,
              Text(
                controller.localization.enterNewPassword!,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF171433).withOpacity(0.7),
                    fontWeight: FontWeight.w500),
              ),
              20.verticalSpace,
              LiveWellTextField(
                  controller: controller.newPassword,
                  hintText: null,
                  labelText: controller.localization.newPassword!,
                  errorText: null,
                  obscureText: true,
                  isEmail: false),
              20.verticalSpace,
              LiveWellTextField(
                  controller: controller.confirmPassword,
                  hintText: null,
                  labelText: controller.localization.confirmPassword!,
                  errorText: null,
                  obscureText: true,
                  isEmail: false),
              36.verticalSpace,
              LiveWellButton(
                  label: controller.localization.change!,
                  color: const Color(0xFFDDF235),
                  onPressed: () {
                    controller.onChangePressed();
                  }),
            ],
          ),
        ));
  }
}
