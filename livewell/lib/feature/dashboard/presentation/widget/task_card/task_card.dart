import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card/task_card_widget.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/theme/design_system.dart';

class TaskCard extends StatelessWidget {
  final TaskCardModel taskCardModel;
  final bool isDummy;
  final int index;
  final int totalLength;
  final controller = Get.find<DashboardController>();
  final VoidCallback onNextTap;
  final VoidCallback onPrevTap;
  final VoidCallback onDoneTap;
  TaskCard({super.key, required this.taskCardModel, this.isDummy = false, this.index = 0, this.totalLength = 0, required this.onNextTap, required this.onPrevTap, required this.onDoneTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.textLoEm,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                8.verticalSpace,
                const Spacer(),
                Row(
                  children: [
                    Text('${(index + 1).toString()}' " of $totalLength ${Get.find<HomeController>().localization.homePage?.insights ?? "insights"}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Theme.of(context).colorScheme.textLoEm,
                          fontWeight: FontWeight.w400,
                        )),
                    const Spacer(),
                    if (index > 0)
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: PrevButton(onPrevTap: onPrevTap),
                      )
                    else
                      const SizedBox(),
                    if (index == totalLength - 1) DoneButton(onDoneTap: onDoneTap) else const SizedBox(),
                    if (index != totalLength - 1) NextButton(onNextTap: onNextTap) else const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
        !isDummy
            ? Positioned(
                left: 10.w,
                child: SvgPicture.asset('assets/icons/ic_task_card_star.svg'),
              )
            : const SizedBox(),
      ],
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onNextTap,
  });

  final VoidCallback onNextTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onNextTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r))),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.neutral10),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w)),
      ),
      child: Text(
        Get.find<HomeController>().localization.homePage?.next ?? "Next",
        style: TextStyle(color: Theme.of(context).colorScheme.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class PrevButton extends StatelessWidget {
  const PrevButton({
    super.key,
    required this.onPrevTap,
  });

  final VoidCallback onPrevTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPrevTap,
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r))),
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.neutral10),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w)),
      ),
      child: Text(
        Get.find<HomeController>().localization.homePage?.prev ?? "Prev",
        style: TextStyle(color: Theme.of(context).colorScheme.neutral80, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class DoneButton extends StatelessWidget {
  const DoneButton({
    super.key,
    required this.onDoneTap,
  });

  final VoidCallback onDoneTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onDoneTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r))),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.neutral10),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check,
            size: 18.w,
            color: Theme.of(context).colorScheme.primaryPurple,
          ),
          8.horizontalSpace,
          Text(
            Get.find<HomeController>().localization.homePage?.done ?? "Done",
            style: TextStyle(color: Theme.of(context).colorScheme.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class DummyTaskCard extends StatelessWidget {
  final TaskCardModel taskCardModel;
  final bool isDummy;
  final int index;
  final int totalLength;
  const DummyTaskCard({super.key, required this.taskCardModel, this.isDummy = false, this.index = 0, this.totalLength = 1});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
            key: Get.find<HomeController>().taskRecommendationKey,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.textLoEm,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                8.verticalSpace,
                const Spacer(),
                Row(
                  children: [
                    Text('${(index + 1).toString()}' " of $totalLength ${Get.find<HomeController>().localization.homePage?.insights ?? "insights"}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Theme.of(context).colorScheme.textLoEm,
                          fontWeight: FontWeight.w400,
                        )),
                    const Spacer(),
                    if (index > 0)
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: PrevButton(onPrevTap: () {}),
                      )
                    else
                      const SizedBox(),
                    if (index == totalLength - 1) DoneButton(onDoneTap: () {}) else const SizedBox(),
                    if (index != totalLength - 1) NextButton(onNextTap: () {}) else const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
        !isDummy
            ? Positioned(
                left: 10.w,
                child: SvgPicture.asset('assets/icons/ic_task_card_star.svg'),
              )
            : const SizedBox(),
      ],
    );
  }
}
