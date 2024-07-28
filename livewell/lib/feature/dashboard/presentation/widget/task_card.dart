import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card_widget.dart';
import 'package:livewell/theme/design_system.dart';

class TaskCard extends StatelessWidget {
  final TaskCardModel taskCardModel;
  final bool isDummy;
  final int index;
  final int totalLength;
  final controller = Get.find<DashboardController>();
  TaskCard({super.key, required this.taskCardModel, this.isDummy = false, this.index = 0, this.totalLength = 0});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: Text(
                  taskCardModel.title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: Theme.of(context).colorScheme.textLoEm),
                ),
              ),
              8.verticalSpace,
              Text(
                taskCardModel.description,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Theme.of(context).colorScheme.textLoEm,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        !isDummy
            ? Positioned(
                left: 10.w,
                child: SvgPicture.asset('assets/icons/ic_task_card_star.svg'),
              )
            : const SizedBox(),
        Positioned(
          right: 24.w,
          top: 12.h,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF2FF),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 18.w,
                    color: Theme.of(context).colorScheme.primaryPurple,
                  ),
                  8.horizontalSpace,
                  RichText(
                      text: TextSpan(
                    text: (index + 1).toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.neutral90,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: ' / $totalLength',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.neutral90,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )),
                ],
              )),
        ),
      ],
    );
  }
}
