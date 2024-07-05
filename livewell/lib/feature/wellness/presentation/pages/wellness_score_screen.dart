import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/streak/data/model/wellness_batch_data_model.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';
import 'package:livewell/feature/wellness/presentation/controller/wellness_controller.dart';
import 'package:livewell/theme/design_system.dart';

class WellnessScoreScreen extends StatefulWidget {
  const WellnessScoreScreen({super.key});

  @override
  State<WellnessScoreScreen> createState() => _WellnessScoreScreenState();
}

class _WellnessScoreScreenState extends State<WellnessScoreScreen> {
  @override
  void initState() {
    Get.find<DashboardController>()
        .trackEvent(LivewellWellnessScoreEvent.wellnessScorePage);
    super.initState();
  }

  WellnessController controller = Get.put(WellnessController());

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
                          Get.find<DashboardController>().trackEvent(
                              LivewellWellnessScoreEvent.wellnessScorePage);
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
              Get.find<DashboardController>().getTodayWellnessData();
              controller.onInit();
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
                        score:
                            Get.find<DashboardController>().wellnessScore.value,
                      ),
                      16.verticalSpace,
                      Obx(() {
                        if (Get.find<DashboardController>()
                                .wellnessScore
                                .value ==
                            0) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                106.verticalSpace,
                                SvgPicture.asset(
                                  Constant.imgEmptyWellness,
                                  width: 120.w,
                                  height: 120.h,
                                ),
                                24.verticalSpace,
                                Text('Unlock your wellness score today!',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutral100,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700)),
                                8.verticalSpace,
                                Text(
                                  'Track your daily task to see your wellness score and insights for today!',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutral80,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            width: 1.sw,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
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
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryDarkBlue,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Optimal',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryDarkBlue,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'High',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryDarkBlue,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
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
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryDarkBlue,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '4',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryDarkBlue,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '8',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryDarkBlue,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '12',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryDarkBlue,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '16',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryDarkBlue,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '20',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryDarkBlue,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  18.verticalSpace,
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        if (Get.find<DashboardController>()
                                                .wellnessData
                                                .value ==
                                            null) {
                                          return const SizedBox();
                                        } else {
                                          return Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 50.w,
                                                child: Text(
                                                  StreakItemType.values[index]
                                                      .wellnessTitle,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondaryDarkBlue,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              8.horizontalSpace,
                                              Obx(() {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(6)),
                                                    color: calculateColor(
                                                        getValueByType(
                                                            Get.find<
                                                                    DashboardController>()
                                                                .wellnessData
                                                                .value!,
                                                            StreakItemType
                                                                    .values[
                                                                index])),
                                                  ),
                                                  width: calculateWidth(
                                                          getValueByType(
                                                              Get.find<
                                                                      DashboardController>()
                                                                  .wellnessData
                                                                  .value!,
                                                              StreakItemType
                                                                      .values[
                                                                  index]))
                                                      .w,
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
                                      itemCount: StreakItemType
                                          .values.reversed.length),
                                  21.verticalSpace,
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'See how do Wellness Score calculated. ',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .disabled,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    context: context,
                                                    shape: shapeBorder(),
                                                    builder: (context) {
                                                      return ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight:
                                                                    0.85.sh,
                                                                minHeight:
                                                                    0.1.sh),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(32),
                                                              topRight: Radius
                                                                  .circular(32),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16.w,
                                                                    vertical:
                                                                        24.h),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  controller
                                                                      .wellnessCalculationModel
                                                                      .title,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .neutral100),
                                                                ),
                                                                16.verticalSpace,
                                                                Expanded(
                                                                  child:
                                                                      ListView(
                                                                    shrinkWrap:
                                                                        true,
                                                                    children: controller
                                                                        .wellnessCalculationModel
                                                                        .details
                                                                        .map(
                                                                            (e) {
                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          16.verticalSpace,
                                                                          Text(
                                                                            e.title,
                                                                            style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Theme.of(context).colorScheme.neutral100),
                                                                          ),
                                                                          8.verticalSpace,
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(
                                                                                color: Theme.of(context).colorScheme.neutral30,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
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
                                                                                          'Ranges',
                                                                                          style: TextStyle(color: Theme.of(context).colorScheme.black600, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          'Score',
                                                                                          style: TextStyle(color: Theme.of(context).colorScheme.black600, fontWeight: FontWeight.w600, fontSize: 14.sp),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 5,
                                                                                        child: Text(
                                                                                          'Category',
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
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            text: 'Learn more',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primaryPurple,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  12.verticalSpace,
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                      16.verticalSpace,
                      Obx(() {
                        return Container(
                          width: 1.sw,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(Constant.icWellnessProfile),
                                  8.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Your Wellness Profile Today',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutral70),
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        controller
                                            .getWellnessProfileByValue(
                                                Get.find<DashboardController>()
                                                        .wellnessData
                                                        .value
                                                        ?.totalScore ??
                                                    0)
                                            .title,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutral100),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              16.verticalSpace,
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      shape: shapeBorder(),
                                      builder: (context) {
                                        return ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: 0.85.sh,
                                              minHeight: 0.1.sh),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(32),
                                                topRight: Radius.circular(32),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 24.h),
                                              child: ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(Constant
                                                          .icWellnessRecommendation),
                                                      8.horizontalSpace,
                                                      Text(
                                                        'Recommendation for you',
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .neutral100),
                                                      ),
                                                      2.verticalSpace,
                                                    ],
                                                  ),
                                                  16.verticalSpace,
                                                  Html(
                                                    data: controller
                                                        .recommendation.value,
                                                    style: {
                                                      "body": Style(
                                                        margin: Margins.all(0),
                                                        fontSize:
                                                            FontSize(14.sp),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .neutral90,
                                                      ),
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: controller.isLoadingRecommendation.value
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 8.h),
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 8.h),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutral10,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(Constant
                                                    .icWellnessRecommendation),
                                                8.horizontalSpace,
                                                Text(
                                                  'Recommendation for you',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .neutral100),
                                                ),
                                                2.verticalSpace,
                                              ],
                                            ),
                                            Html(
                                              data: controller.recommendation
                                                      .value.isEmpty
                                                  ? ''
                                                  : controller.recommendation
                                                      .substring(0, 400),
                                              style: {
                                                "body": Style(
                                                  margin: Margins.all(0),
                                                  fontSize: FontSize(12.sp),
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .neutral90,
                                                ),
                                              },
                                            ),
                                            // Text(
                                            //   controller.recommendation.value,
                                            //   style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutral90),
                                            //   maxLines: 6,
                                            //   overflow: TextOverflow.ellipsis,
                                            // ),
                                            2.verticalSpace,
                                            Text('Show more',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryPurple)),
                                          ],
                                        ),
                                      ),
                              ),
                              16.verticalSpace,
                            ],
                          ),
                        );
                      }),
                      32.verticalSpace,
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
    const double maxWidth = 253.0;

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
    if (score <= 7) {
      return const Color(0xFFFA6F6F);
    }
    // if score is less than 16 return 80A4A9
    if (score <= 15) {
      return Theme.of(context).colorScheme.primaryGreen;
    }

    // if score is less than 20 return 80A4A9
    if (score <= 20) {
      return Theme.of(context).colorScheme.primaryTurquoise;
    }
    return const Color(0xFFFA6F6F);
  }
}
