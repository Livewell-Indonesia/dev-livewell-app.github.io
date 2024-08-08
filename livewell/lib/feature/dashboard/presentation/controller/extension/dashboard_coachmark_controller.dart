import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/controller/extension/dashboard_task_card_controller.dart';
import 'package:livewell/feature/dashboard/presentation/enums/dashboard_coachmark_type.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

extension DashboardCoachmarkControllerX on DashboardController {
  TutorialCoachMark createCoachmark() {
    return TutorialCoachMark(
      targets: createTargets(),
      colorShadow: Colors.black,
      textSkip: "SKIP",
      hideSkip: true,
      pulseEnable: false,
      paddingFocus: 0,
      opacityShadow: 0.7,
      alignSkip: Alignment.topRight,
      focusAnimationDuration: const Duration(milliseconds: 300),
      unFocusAnimationDuration: const Duration(milliseconds: 300),
      onSkip: () {
        onSkipTap();
        return true;
      },
      onClickTarget: (p0) {},
      onClickTargetWithTapPosition: ((p0, p1) {}),
      onFinish: () {
        return true;
      },
    );
  }

  void initiateCoachmark() async {
    if (await SharedPref.getDoneWithRecommendation()) {
      isShowCoachmark.value = false;
      return;
    } else {
      tutorialCoachMark = createCoachmark();
      Future.delayed(const Duration(milliseconds: 100), () {
        coachmarkType.value = DashboardCoachmarkType.nutricoPlus;
        isShowCoachmark.value = true;
        if (!tutorialCoachMark.isShowing) {
          tutorialCoachMark.show(context: Get.context!);
        }
      });
    }
  }

  void onSkipTap() {
    isShowCoachmark.value = false;
    tutorialCoachMark.skip();
  }

  void onCoachmarkNextTap() {
    var currentCoachmarkType = coachmarkType.value;
    coachmarkType.value = DashboardCoachmarkType.values[currentCoachmarkType.index + 1];
    Future.delayed(const Duration(milliseconds: 100), () {
      tutorialCoachMark.next();
    });
  }

  void onCoachmarkPrevTap() {
    var currentCoachmarkType = coachmarkType.value;
    coachmarkType.value = DashboardCoachmarkType.values[currentCoachmarkType.index - 1];
    tutorialCoachMark.previous();
  }

  void onCoachmarkDoneTap() async {
    isShowCoachmark.value = false;
    Get.find<HomeController>().nutricoKey = null;
    Get.find<HomeController>().taskRecommendationKey = null;
    Get.find<HomeController>().wellnessScoreWidgetKey = null;
    Get.find<HomeController>().finishTaskRecommendationKey = null;
    tutorialCoachMark.finish();
    await SharedPref.saveDoneWithRecommendation(true);
  }

  List<TargetFocus> createTargets() {
    List<TargetFocus> targets = DashboardCoachmarkType.values.map((e) {
      return e.createTargetFocus(
        getKey(e),
        onPrevTap: onCoachmarkPrevTap,
        onNextTap: onCoachmarkNextTap,
        onDoneTap: onCoachmarkDoneTap,
      );
    }).toList();
    return targets;
  }

  GlobalKey? getKey(DashboardCoachmarkType type) {
    switch (type) {
      case DashboardCoachmarkType.nutricoPlus:
        return Get.find<HomeController>().nutricoKey;
      case DashboardCoachmarkType.taskRecommendation:
        return Get.find<HomeController>().taskRecommendationKey;
      case DashboardCoachmarkType.finishTaskRecommendation:
        return Get.find<HomeController>().finishTaskRecommendationKey;
      case DashboardCoachmarkType.wellnessScoreWidget:
        return Get.find<HomeController>().wellnessScoreWidgetKey;
    }
  }
}
