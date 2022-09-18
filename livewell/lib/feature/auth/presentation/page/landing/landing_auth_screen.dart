import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/localization/Languages.dart';
import 'package:livewell/feature/auth/presentation/page/signup/signup_screen.dart';
import 'package:livewell/feature/food/domain/usecase/get_food_history.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

import '../login/login_screen.dart';

class LandingAuthScreen extends StatelessWidget {
  const LandingAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Flexible(
            flex: 78,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(Constant.loginIllustration),
                    fit: BoxFit.cover,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40).r,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          40.verticalSpace,
                          Image.asset(
                            Constant.imgLogo,
                            width: 165.w,
                            height: 80.h,
                          ),
                          Text(AppStringsKeys.welcomeToLiveWell.tr,
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF171433))),
                          8.verticalSpace,
                          Text(AppStringsKeys.letsYourNewHealth.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF171433)
                                      .withOpacity(0.7))),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 22,
            child: Column(
              children: [
                LiveWellButton(
                    label: AppStringsKeys.getStarted.tr,
                    color: const Color(0xFFDDF235),
                    onPressed: () {
                      Get.to(() => SignUpScreen());
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStringsKeys.alreadyHaveAccount.tr,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF171433))),
                    TextButton(
                        onPressed: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Text(
                          AppStringsKeys.signIn.tr,
                          style: TextStyle(
                            color: const Color(0xFF8F01DF),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
