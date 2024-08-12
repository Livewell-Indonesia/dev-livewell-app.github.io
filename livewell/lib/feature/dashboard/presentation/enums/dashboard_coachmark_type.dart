import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/widget/coachmark/coachmark_widget.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

enum DashboardCoachmarkType { nutricoPlus, taskRecommendation, finishTaskRecommendation, wellnessScoreWidget }

extension DashboardCoachmarkTypeExtension on DashboardCoachmarkType {
  String get title {
    switch (this) {
      case DashboardCoachmarkType.nutricoPlus:
        return Get.find<DashboardController>().localization.tooltipHomePage?.nutricoPlusTitle ?? "NutriCo+";
      case DashboardCoachmarkType.taskRecommendation:
        return Get.find<DashboardController>().localization.tooltipHomePage?.taskRecommendationTitle ?? "At-a-Glance Insight For Today!";
      case DashboardCoachmarkType.finishTaskRecommendation:
        return Get.find<DashboardController>().localization.tooltipHomePage?.finishTaskRecommendationTitle ?? "See the Full Picture";
      case DashboardCoachmarkType.wellnessScoreWidget:
        return Get.find<DashboardController>().localization.tooltipHomePage?.wellnessScoreTitle ?? "Need More Time?";
    }
  }

  String get description {
    switch (this) {
      case DashboardCoachmarkType.nutricoPlus:
        return Get.find<DashboardController>().localization.tooltipHomePage?.nutricoPlusDescription ?? "Now you can discover quick tips to improve your day only in seconds.";
      case DashboardCoachmarkType.taskRecommendation:
        return Get.find<DashboardController>().localization.tooltipHomePage?.taskRecommendationDescription ?? "Now you can discover quick tips to improve your day only in seconds.";
      case DashboardCoachmarkType.finishTaskRecommendation:
        return Get.find<DashboardController>().localization.tooltipHomePage?.finishTaskRecommendationDescription ?? "Uncover detailed insights and recommendations with a single click.";
      case DashboardCoachmarkType.wellnessScoreWidget:
        return Get.find<DashboardController>().localization.tooltipHomePage?.wellnessScoreDescription ?? "You still can find the full recommendation here.";
    }
  }

  TargetFocus createTargetFocus(GlobalKey? keyTarget, {VoidCallback? onPrevTap, VoidCallback? onNextTap, VoidCallback? onDoneTap}) {
    switch (this) {
      case DashboardCoachmarkType.nutricoPlus:
        return TargetFocus(identify: name, keyTarget: keyTarget, shape: ShapeLightFocus.Circle, enableOverlayTab: false, enableTargetTab: false, color: Colors.black, contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return DashboardCoachmarkWidget(coachmarkType: this, onNextTap: onNextTap, onPrevTap: onPrevTap, onDoneTap: onDoneTap);
              })
        ]);
      case DashboardCoachmarkType.finishTaskRecommendation:
      case DashboardCoachmarkType.wellnessScoreWidget:
      case DashboardCoachmarkType.taskRecommendation:
        return TargetFocus(identify: name, keyTarget: keyTarget, shape: ShapeLightFocus.RRect, radius: 20, enableOverlayTab: false, enableTargetTab: false, color: Colors.black, contents: [
          TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return DashboardCoachmarkWidget(coachmarkType: this, onNextTap: onNextTap, onPrevTap: onPrevTap, onDoneTap: onDoneTap);
              })
        ]);
    }
  }
}
