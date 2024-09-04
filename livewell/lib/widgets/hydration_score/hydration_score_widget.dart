import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';
import 'package:livewell/theme/design_system.dart';

class HydrationScoreWidget extends StatelessWidget {
  final StreakItemType type;
  final double value;
  final HomeController controller = Get.find();

  HydrationScoreWidget({super.key, required this.type, required this.value});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget emptyState(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/icons/ic_hydration_score.svg', width: 64.w, height: 64.h),
        16.verticalSpace,
        Text(controller.localization.waterPage?.yourHydrationScoreStillEmpty ?? 'Your Hydration Score is still empty!',
            style: TextStyle(color: Theme.of(context).colorScheme.neutral100, fontWeight: FontWeight.w600, fontSize: 14.sp)),
        8.verticalSpace,
        Text(controller.localization.waterPage?.letsHelpYourBodyStayHydrated ?? 'Let\'s help your body stay hydrated and track your hydration progress by logging your glasses of water today!',
            textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontWeight: FontWeight.w400, fontSize: 12.sp)),
      ],
    );
  }

  Widget content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/icons/ic_hydration_score.svg', width: 36.w, height: 36.h),
            8.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.localization.waterPage?.hydrationScoreToday ?? "Hydration Score Today",
                    style: TextStyle(color: Theme.of(context).colorScheme.neutral70, fontWeight: FontWeight.w400, fontSize: 12.sp)),
                Obx(() {
                  return Text(scoreToDescription(Get.find<DashboardController>().wellnessData.value?.hydrationScore ?? 0),
                      style: TextStyle(color: Theme.of(context).colorScheme.neutral100, fontWeight: FontWeight.w600, fontSize: 16.sp));
                })
              ],
            ),
          ],
        ),
        16.verticalSpace,
        Text(controller.localization.waterPage?.youreDoingWellInStayingHydrated ?? 'You\'re doing well in staying hydrated! Keep it up by drinking water regularly to maintain optimal health.',
            style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontWeight: FontWeight.w500, fontSize: 12.sp)),
        16.verticalSpace,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: controller.localization.waterPage?.seeHowDoHydrationScoreCalculated ?? 'See how do Hydration Score calculated ',
                style: TextStyle(color: Theme.of(context).colorScheme.disabled, fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showModalBottomSheet(
                        context: context,
                        shape: shapeBorder(),
                        isScrollControlled: true,
                        builder: (context) {
                          return Wrap(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.localization.waterPage?.seeHowDoHydrationScoreCalculated ?? 'How do Hydration Score calculated?',
                                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutral100),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: controller.wellnessCalculationModel.details.where((element) => element.type == StreakItemType.hydration).map((e) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              16.verticalSpace,
                                              Text(
                                                e.title,
                                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutral100),
                                              ),
                                              8.verticalSpace,
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Theme.of(context).colorScheme.neutral30,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      color: Theme.of(context).colorScheme.neutral20,
                                                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 5,
                                                            child: Text(
                                                              controller.localization.wellnessCalculation?['ranges'] ?? "Ranges",
                                                              style: TextStyle(color: Theme.of(context).colorScheme.black600, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              controller.localization.wellnessCalculation?['scores'] ?? "Scores",
                                                              style: TextStyle(color: Theme.of(context).colorScheme.black600, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 5,
                                                            child: Text(
                                                              controller.localization.wellnessCalculation?['category'] ?? "Category",
                                                              style: TextStyle(color: Theme.of(context).colorScheme.black600, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    ListView.separated(
                                                      shrinkWrap: true,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, index) {
                                                        return Container(
                                                          color: index % 2 == 0 ? Colors.transparent : Theme.of(context).colorScheme.neutral20,
                                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 5,
                                                                child: Text(
                                                                  e.descriptions[index].range,
                                                                  style: TextStyle(color: Theme.of(context).colorScheme.black600, fontSize: 14.sp),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  e.descriptions[index].score,
                                                                  style: TextStyle(color: Theme.of(context).colorScheme.black600, fontSize: 14.sp),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 5,
                                                                child: Text(
                                                                  e.descriptions[index].description,
                                                                  style: TextStyle(color: Theme.of(context).colorScheme.black600, fontSize: 14.sp),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder: (context, index) {
                                                        return const SizedBox();
                                                      },
                                                      itemCount: e.descriptions.length,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                text: " ${controller.localization.waterPage?.here ?? 'here'}",
                style: TextStyle(color: Theme.of(context).colorScheme.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String scoreToDescription(int score) {
    var details = controller.wellnessCalculationModel.details.where((element) => element.type == type).first;
    var description = details.descriptions.firstWhere((element) {
      return score == int.parse(element.score);
    });
    return description.description;
  }
}
