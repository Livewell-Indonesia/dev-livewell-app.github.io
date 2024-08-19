import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/enums/dashboard_coachmark_type.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/theme/design_system.dart';

class DashboardCoachmarkWidget extends StatelessWidget {
  final DashboardCoachmarkType coachmarkType;
  final VoidCallback? onNextTap;
  final VoidCallback? onPrevTap;
  final VoidCallback? onDoneTap;
  const DashboardCoachmarkWidget({super.key, required this.coachmarkType, this.onNextTap, this.onPrevTap, this.onDoneTap});

  @override
  Widget build(BuildContext context) {
    return GeneralCoachmarkWidget(
      title: coachmarkType.title,
      description: coachmarkType.description,
      onNextTap: onNextTap,
      onPrevTap: onPrevTap,
      onDoneTap: onDoneTap,
      contentLength: DashboardCoachmarkType.values.length,
      currentIndex: DashboardCoachmarkType.values.indexOf(coachmarkType),
    );
  }
}

class GeneralCoachmarkWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onNextTap;
  final VoidCallback? onPrevTap;
  final VoidCallback? onDoneTap;
  final int contentLength;
  final int currentIndex;
  const GeneralCoachmarkWidget({super.key, required this.title, required this.description, this.onNextTap, required this.contentLength, required this.currentIndex, this.onPrevTap, this.onDoneTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: const Color(0xFF171433), fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          4.verticalSpace,
          Text(
            description,
            style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
          20.verticalSpace,
          Row(
            children: [
              CoachmarkIndicator(
                position: currentIndex,
                length: contentLength,
              ),
              const Spacer(),
              currentIndex != 0 ? coachMarkPrevButton(context) : Container(),
              currentIndex != contentLength - 1 ? coachMarkNextButton(context) : Container(),
              currentIndex == contentLength - 1 ? coachmarkDoneButton(context) : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget coachMarkPrevButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: InkWell(
        onTap: onPrevTap,
        child: Text(
          Get.find<HomeController>().localization.homePage?.prev ?? "Prev",
          style: TextStyle(color: Theme.of(context).colorScheme.disabled, fontSize: 12.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget coachMarkNextButton(BuildContext context) {
    return InkWell(
      onTap: onNextTap,
      child: Text(
        Get.find<HomeController>().localization.homePage?.next ?? "Next",
        style: TextStyle(color: Theme.of(context).colorScheme.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget coachmarkDoneButton(BuildContext context) {
    return InkWell(
      onTap: onDoneTap,
      child: Text(
        'Done',
        style: TextStyle(color: Theme.of(context).colorScheme.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
