import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:livewell/feature/streak/data/model/wellness_batch_data_model.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';
import 'package:livewell/theme/design_system.dart';

class WellnessScoreScreen extends StatefulWidget {
  const WellnessScoreScreen({super.key});

  @override
  State<WellnessScoreScreen> createState() => _WellnessScoreScreenState();
}

class _WellnessScoreScreenState extends State<WellnessScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 60.h, left: 16.w, right: 16.w),
                height: 154.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFddf235),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Wellness Score',
                        style: TextStyles.navbarTitle(context),
                      ),
                    ),
                    const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.transparent,
                        )),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
          RefreshIndicator(
            onRefresh: () {
              return Future.value();
            },
            child: Padding(
              padding: EdgeInsets.only(top: 116.h),
              child: SizedBox(
                height: 1.sh - 116.h,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      WellnessScoreWidget(
                        score: Get.find<DashboardController>().wellnessScore.value,
                      ),
                      24.verticalSpace,
                      Container(
                        alignment: Alignment.centerRight,
                        width: 1.sw,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 254.w,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Low',
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'Optimal',
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'High',
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              8.verticalSpace,
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 254.w,
                                  child: Row(
                                    children: [
                                      Text(
                                        '0',
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 10.sp, fontWeight: FontWeight.w400),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '4',
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 10.sp, fontWeight: FontWeight.w400),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '8',
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 10.sp, fontWeight: FontWeight.w400),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '12',
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 10.sp, fontWeight: FontWeight.w400),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '16',
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 10.sp, fontWeight: FontWeight.w400),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '20',
                                        style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 10.sp, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              18.verticalSpace,
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    if (Get.find<DashboardController>().wellnessData.value == null) {
                                      return const SizedBox();
                                    } else {
                                      return Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: 80.w,
                                            child: Text(
                                              StreakItemType.values[index].wellnessTitle,
                                              style: TextStyle(color: Theme.of(context).colorScheme.secondaryDarkBlue, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          8.horizontalSpace,
                                          Obx(() {
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                color: calculateColor(getValueByType(Get.find<DashboardController>().wellnessData.value!, StreakItemType.values[index])),
                                              ),
                                              width: calculateWidth(getValueByType(Get.find<DashboardController>().wellnessData.value!, StreakItemType.values[index])).w,
                                              height: 12.h,
                                            );
                                          })
                                        ],
                                      );
                                    }
                                  },
                                  separatorBuilder: (context, index) {
                                    return 28.verticalSpace;
                                  },
                                  itemCount: StreakItemType.values.reversed.length),
                            ],
                          ),
                        ),
                      ),
                      24.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateWidth(int score) {
    // Assuming the maximum score is 20
    const int maxScore = 20;
    const double maxWidth = 254.0;

    // Calculate the width based on the score
    double width = (score / maxScore) * maxWidth;

    // Ensure the width is at least 0 and at most maxWidth
    width = width.clamp(0, maxWidth);

    return width;
  }

  int getValueByType(WellnessData model, StreakItemType type) {
    switch (type) {
      case StreakItemType.hydration:
        return model.hydrationScore ?? 0;
      case StreakItemType.sleep:
        return model.sleepScore ?? 0;
      case StreakItemType.mood:
        return model.moodScore ?? 0;
      case StreakItemType.nutrition:
        return model.nutritionScore ?? 0;
      case StreakItemType.activity:
        return model.activityScore ?? 0;
    }
  }

  Color calculateColor(int score) {
    // if score is less than 4, return 808080
    if (score <= 4) {
      return const Color(0xFF808080);
    }
    // if score is less than 16 return 80A4A9
    if (score <= 16) {
      return const Color(0xFF80A4A9);
    }

    // if score is less than 20 return 80A4A9
    if (score <= 20) {
      return const Color(0xFFFA6F6F);
    }
    return const Color(0xFF808080);
  }
}
