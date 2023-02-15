import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/localization/languages.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class FinishQuestionnaireScreen extends StatelessWidget {
  const FinishQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDF235),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            const Spacer(),
            Center(
                child: SizedBox(
                    width: 280.w,
                    height: 296.h,
                    child:
                        SvgPicture.asset(Constant.imgFinishQuestionnaireSVG))),
            50.verticalSpace,
            Text(
              AppStringsKeys.youReadyToGo.tr,
              style: TextStyle(
                  color: const Color(0xFF171433),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600),
            ),
            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: Text(
                AppStringsKeys.thanksForTakingYourTime.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFF171433).withOpacity(0.7),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            50.verticalSpace,
            LiveWellButton(
                label: AppStringsKeys.getStarted2.tr,
                color: const Color(0xFF8F01DF),
                textColor: Colors.white,
                onPressed: () {
                  if (!Get.isRegistered<DashboardController>() ||
                      Get.find<DashboardController>().user.value.dailyJournal ==
                          null ||
                      Get.find<DashboardController>()
                          .user
                          .value
                          .dailyJournal!
                          .isEmpty) {
                    AppNavigator.push(
                        routeName: AppPages.dailyJournal, arguments: false);
                  } else {
                    AppNavigator.pushAndRemove(routeName: AppPages.home);
                  }
                }),
            31.verticalSpace,
          ],
        ),
      ),
    );
  }
}
