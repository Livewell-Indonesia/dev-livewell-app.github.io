import 'package:flutter/material.dart';
import 'package:livewell/feature/dashboard/presentation/widget/coachmark/coachmark_widget.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

enum DashboardCoachmarkType { nutricoPlus, taskRecommendation, finishTaskRecommendation, wellnessScoreWidget }

extension DashboardCoachmarkTypeExtension on DashboardCoachmarkType {
  String get title {
    switch (this) {
      case DashboardCoachmarkType.nutricoPlus:
        return 'Snap, NutriCo+';
      case DashboardCoachmarkType.taskRecommendation:
        return 'At-a-Glance Insight For Today!';
      case DashboardCoachmarkType.finishTaskRecommendation:
        return 'See the Full Picture';
      case DashboardCoachmarkType.wellnessScoreWidget:
        return 'Need More Time?';
    }
  }

  String get description {
    switch (this) {
      case DashboardCoachmarkType.nutricoPlus:
        return 'Now you can discover quick tips to improve your day only in seconds.';
      case DashboardCoachmarkType.taskRecommendation:
        return 'Now you can discover quick tips to improve your day only in seconds.';
      case DashboardCoachmarkType.finishTaskRecommendation:
        return 'Uncover detailed insights and recommendations with a single click.';
      case DashboardCoachmarkType.wellnessScoreWidget:
        return 'You still can find the full recommendation here.';
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
