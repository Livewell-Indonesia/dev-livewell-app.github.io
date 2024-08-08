import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class FinishQuestionnaireScreen extends StatelessWidget {
  const FinishQuestionnaireScreen({Key? key}) : super(key: key);

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
            const Spacer(),
            Center(child: SizedBox(width: 240.w, height: 253.h, child: SvgPicture.asset(Constant.imgFinishQuestionnaireSVG))),
            32.verticalSpace,
            Text(
              QuestionnairePage.finish.title(),
              style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            8.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: Text(
                QuestionnairePage.finish.subtitle(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue.withOpacity(0.7), fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
            LiveWellButton(
                label: Get.find<HomeController>().localization.onboardingPage?.getStarted ?? "Get Started!",
                color: Theme.of(context).colorScheme.primaryPurple,
                textColor: Colors.white,
                onPressed: () {
                  if (Get.isRegistered<DashboardController>()) {
                    Get.find<DashboardController>().getUsersData();
                    Get.find<DashboardController>().trackEvent(LivewellAuthEvent.onboardingThankYouPageGetStarted);
                  }
                  AppNavigator.pushAndRemove(routeName: AppPages.home);
                }),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }
}
