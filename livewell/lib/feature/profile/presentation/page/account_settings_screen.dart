import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/profile/presentation/controller/account_settings_controller.dart';
import 'package:livewell/feature/profile/presentation/page/user_settings_screen.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

import '../controller/user_settings_controller.dart';

class AccountSettingsScreen extends StatelessWidget {
  final AccountSettingsController controller =
      Get.put(AccountSettingsController());
  AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          color: const Color(0xFFF1F1F1),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const ProfileBackground(),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          //behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 16).r,
                            width: 31.w,
                            height: 31.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const SizedBox(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 210.h,
                        height: 210.h,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Container(
                          width: 180.h,
                          height: 180.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      13.verticalSpace,
                    ],
                  ),
                ],
              ),
              30.verticalSpace,
              Container(
                width: 1.sw,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    // Top Section
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 15.h),
                      height: 55.h,
                      width: 1.sw,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.r),
                              topRight: Radius.circular(30.r))),
                      child: Row(
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                                color: const Color(0xFF171433),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.edit_outlined,
                            size: 15.h,
                            color: const Color(0xFF8F01DF),
                          ),
                          Text(
                            ' Edit',
                            style: TextStyle(
                                color: const Color(0xFF8401DF),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    30.verticalSpace,
                    AccountSettingsTextField(
                      textEditingController: controller.firstName,
                      hintText: 'First Name',
                    ),
                    20.verticalSpace,
                    AccountSettingsTextField(
                      textEditingController: controller.lastName,
                      hintText: 'Last Name',
                    ),
                    20.verticalSpace,
                    AccountSettingsTextField(
                      textEditingController: controller.email,
                      hintText: 'Email',
                      enabled: false,
                    )
                  ],
                ),
              ),
              20.verticalSpace,
              LiveWellButton(
                  label: 'Update',
                  color: const Color(0xFF8F01DF),
                  textColor: Colors.white,
                  onPressed: () {
                    controller.validate();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class AccountSettingsTextField extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  bool enabled;
  TextInputType inputType;
  AccountSettingsTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.enabled = true,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0).r,
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(36.r),
        border: Border.all(
          color: const Color(0xFFDDF235),
          width: 3,
        ),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        keyboardType: inputType,
        enabled: enabled,
        textAlign: TextAlign.end,
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 16.h),
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hintText,
                style: TextStyle(
                    color: Color(0xFF171433).withOpacity(0.5),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          border: InputBorder.none,
          labelStyle: TextStyle(
              color: const Color(0xFF171433),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
