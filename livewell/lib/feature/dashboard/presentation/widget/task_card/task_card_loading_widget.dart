import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:lottie/lottie.dart';

class TaskCardLoadingWidget extends StatelessWidget {
  const TaskCardLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 57.h,
                height: 57.w,
                child: Lottie.asset('assets/jsons/loading dot.json', repeat: true),
              ),
              8.verticalSpace,
              Text(Get.find<DashboardController>().localization.homePage?.preparingRecommendationForYou ?? "Preparing recommendation for you...",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.textLoEm,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ),
        Positioned(
          left: 10.w,
          child: SvgPicture.asset('assets/icons/ic_task_card_star.svg'),
        )
      ],
    );
  }
}
