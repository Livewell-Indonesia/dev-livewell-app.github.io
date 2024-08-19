import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:lottie/lottie.dart';

class TaskCardFinishWidget extends StatelessWidget {
  final VoidCallback onTap;
  const TaskCardFinishWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 57.h,
              height: 57.w,
              child: LottieBuilder.asset('assets/jsons/done.json'),
            ),
            8.verticalSpace,
            Text(
              'You\'re all set',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.textLoEm),
            ),
            8.verticalSpace,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Curious about the full picture? Explore your detailed wellness insights ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.neutral90,
                    ),
                  ),
                  TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = onTap,
                      text: 'here',
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primaryPurple)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DummyTaskCardFinishWidget extends StatelessWidget {
  const DummyTaskCardFinishWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        key: Get.find<HomeController>().finishTaskRecommendationKey,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 57.h,
              height: 57.w,
              child: LottieBuilder.asset('assets/jsons/done.json'),
            ),
            8.verticalSpace,
            Text(
              Get.find<HomeController>().localization.homePage?.youreAllSet ?? 'You\'re all set',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.textLoEm),
            ),
            8.verticalSpace,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Get.find<HomeController>().localization.homePage?.curiousAboutFullPicture ?? 'Curious about the full picture? Explore your detailed wellness insights ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.neutral90,
                    ),
                  ),
                  TextSpan(
                      text: Get.find<HomeController>().localization.homePage?.here ?? 'here',
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primaryPurple)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
