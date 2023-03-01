import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/profile/presentation/controller/user_settings_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';

class UserSettingsScreen extends StatelessWidget {
  final UserSettingsController controller = Get.put(UserSettingsController());
  UserSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      color: const Color(0xFFF1F1F1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const ProfileBackground(),
                Column(
                  children: [
                    Navigator.of(context).canPop()
                        ? Align(
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
                          )
                        : const SizedBox(),
                    Container(
                      width: 210.w,
                      height: 210.h,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: Container(
                          width: 180.w,
                          height: 180.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Obx(() {
                            return SvgPicture.asset(
                              (controller.user.value.gender ?? Gender.male.name)
                                          .toLowerCase() ==
                                      "male"
                                  ? Constant.imgMaleSVG
                                  : Constant.imgFemaleSVG,
                            );
                          }),
                        ),
                      ),
                    ),
                    13.verticalSpace,
                    Obx(() {
                      return Text(
                        "${controller.user.value.firstName ?? ""} ${controller.user.value.lastName ?? ""}",
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF171433)),
                      );
                    })
                    // Text(
                    //   'Indonesia ${flagEmoji('ID')}',
                    //   style: TextStyle(fontSize: 18.sp),
                    // ),
                  ],
                ),
              ],
            ),
            57.verticalSpace,
            ProfileSettingsItem(
                title: 'Account Settings'.tr,
                icon: Image.asset(Constant.icAccountSetting),
                onPressed: () {
                  controller.accountSettingsTap();
                }),
            20.verticalSpace,
            ProfileSettingsItem(
                title: 'Daily Journal'.tr,
                icon: Icon(
                  Icons.class_outlined,
                  size: 20.w,
                ),
                onPressed: () {
                  controller.dailyJournalTapped();
                }),
            20.verticalSpace,
            ProfileSettingsItem(
                title: 'Physical Information'.tr,
                icon: Icon(
                  Icons.accessibility_new,
                  size: 20.w,
                ),
                onPressed: () {
                  controller.physicalInformationTapped();
                }),
            20.verticalSpace,
            ProfileSettingsItem(
                title: 'Exercise'.tr,
                icon: Image.asset(Constant.icExerciseBlack3),
                onPressed: () {
                  controller.exerciseInformationTapped();
                }),
            20.verticalSpace,
            ProfileSettingsItem(
              title: 'Logout'.tr,
              icon: Image.asset(Constant.icLogout),
              onPressed: () {
                controller.logoutTapped();
              },
            ),
            100.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class ProfileSettingsItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onPressed;

  const ProfileSettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        width: 335.w,
        height: 72.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30).r,
        ),
        child: Row(
          children: [
            Container(
              width: 43.h,
              height: 43.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(15).r),
              child: SizedBox(
                width: 20.w,
                height: 20.h,
                child: icon,
              ),
            ),
            18.horizontalSpace,
            Text(
              title,
              style: TextStyle(
                  color: const Color(0xFF171433).withOpacity(0.8),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 380.h,
          width: 1.sw,
          child: Stack(
            children: [
              Container(
                height: 380.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF34EAB2),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 209.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8F01DF),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String flagEmoji(String country) {
  int base = 0x1F1E6;
  int a = 'A'.codeUnitAt(0);
  int offset = country.codeUnitAt(0) - a;
  int first = base + offset;
  offset = country.codeUnitAt(1) - a;
  int second = base + offset;
  return String.fromCharCode(first) + String.fromCharCode(second);
}
