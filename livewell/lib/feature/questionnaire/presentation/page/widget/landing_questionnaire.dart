import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class LandingQuestionnaire extends StatelessWidget {
  LandingQuestionnaire({super.key});
  final QuestionnaireController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            Constant.imgLandingQuestionnaire,
            width: 240.w,
            height: 240.h,
          ),
          32.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              controller.localization.onboardingPage?.letsStartByCompletingYourProfile ?? "Let's start by completing your profile",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryDarkBlue,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          8.verticalSpace,
          Text(
            controller.localization.onboardingPage?.personalizedPlanWillBeCraftedBasedOnYourCurrentCondition ?? "Personalized plan will be crafted based on your current condition",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.disabled,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          LiveWellButton(
            label: controller.localization.onboardingPage?.startNow ?? "Start Now",
            color: Theme.of(context).colorScheme.primaryPurple,
            textColor: Colors.white,
            onPressed: () {
              controller.onStartNowTapped();
              controller.trackEvent(LivewellAuthEvent.onboardingLandingPageNext);
            },
          ),
          32.verticalSpace,
        ],
      ),
    );
  }
}
