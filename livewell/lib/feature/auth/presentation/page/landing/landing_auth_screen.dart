import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/localization/languages.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class LandingAuthScreen extends StatelessWidget {
  const LandingAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
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
                            AspectRatio(
                              aspectRatio: 4,
                              child: SvgPicture.asset(
                                "assets/images/FA_Livewell_Logo.svg",
                                fit: BoxFit.cover,
                                color: const Color(0xFF34EAB2),
                              ),
                            ),
                            // Image.asset(
                            //   Constant.imgLogo,
                            //   width: 165.w,
                            //   height: 80.h,
                            // ),
                            Text('Welcome to Livewell'.tr,
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF171433))),
                            8.verticalSpace,
                            Text('Better Health Through Better Living'.tr,
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
                      label: 'Get Started'.tr,
                      color: const Color(0xFFDDF235),
                      onPressed: () {
                        AppNavigator.push(routeName: AppPages.signup);
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have account?'.tr,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF171433))),
                      TextButton(
                          onPressed: () {
                            AppNavigator.push(routeName: AppPages.login);
                          },
                          child: Text(
                            'Sign In'.tr,
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
      ),
    );
  }
}
