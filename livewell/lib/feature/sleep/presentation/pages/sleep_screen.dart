import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/sleep/presentation/controller/sleep_controller.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/chart/circular_nutrition.dart';
import 'package:livewell/widgets/hydration_score/hydration_score_widget.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  final SleepController controller = Get.find();

  @override
  void initState() {
    controller.trackEvent(LivewellSleepEvent.sleepPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: controller.localization.sleepPage?.sleep ?? "Sleep",
      trailing: InkWell(
        onTap: () {
          HomeController controller = Get.find();
          controller.trackEvent(LivewellSleepEvent.sleepPageInformationButton);
          var data = controller.popupAssetsModel.value.water;
          if (data != null) {
            showModalBottomSheet<dynamic>(
                context: context,
                isScrollControlled: true,
                shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                builder: (context) {
                  return Obx(() {
                    return PopupAssetWidget(
                      exercise: controller.popupAssetsModel.value.sleep!,
                    );
                  });
                });
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: const Icon(
            Icons.info_outline,
            color: Color(0xFF171433),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF1F1F1),
      body: Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            Get.snackbar("Health Data Syncing", "Health data syncing may take some time. We appreciate your patience!", duration: const Duration(seconds: 7));
            controller.refreshList();
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Center(child: Obx(() {
                  return MultipleColorCircle(
                    colorOccurrences: controller.totalSleepPercent.value == 0
                        ? {
                            Colors.white: 0,
                          }
                        : {
                            const Color(0xFF8F01DF): controller.lightSleepPercent.value.round() * 100,
                            const Color(0xFFDDF235): controller.deepSleepPercent.value.round() * 100,
                            const Color(0xFF34EAB2): controller.sleepInBedPercent.value.round() * 100,
                            Colors.white: controller.leftSleepPercent.value.round(),
                          },
                    height: 231.h,
                    strokeWidth: 9,
                    child:
                        // crete circular container
                        Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                      child: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          SvgPicture.asset(
                            Constant.icWentToSleep,
                            color: const Color(0xFF8F01DF),
                          ),
                          10.verticalSpace,
                          Text(
                            "${controller.totalSleepPercent.value.toInt() > 100 ? 100 : controller.totalSleepPercent.value.toInt()}%",
                            style: TextStyle(fontSize: 43.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutral100),
                          ),
                          4.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              controller.localization.sleepPage?.ofDailyGoals ?? "of daily goals",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17.sp, color: Theme.of(context).colorScheme.neutral90, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                })),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  children: [
                    Obx(() {
                      if (controller.deepSleepPercent.value == 0 && controller.lightSleepPercent.value == 0) {
                        return const SizedBox(height: 40);
                      } else {
                        return SmallerSleepCircular(color: const Color(0xFFDDF235), label: controller.localization.sleepPage?.deepSleep ?? "Deep Sleep", circleColors: {
                          const Color(0xFFDDF235): (controller.deepSleepPercent.value * 100).round(),
                          Colors.white: (controller.deepSleepPercent.value * 100).round() > 100 ? 0 : 100 - (controller.deepSleepPercent.value * 100).round(),
                        });
                      }
                    }),
                    const Spacer(),
                    Obx(() {
                      if (controller.deepSleepPercent.value == 0 && controller.lightSleepPercent.value == 0) {
                        return const SizedBox(height: 40);
                      } else {
                        return SmallerSleepCircular(
                            color: const Color(0xFF8F01DF),
                            circleColors: {
                              const Color(0xFF8F01DF): (controller.lightSleepPercent.value * 100).round(),
                              Colors.white: (controller.lightSleepPercent.value * 100).round() > 100 ? 0 : 100 - (controller.lightSleepPercent.value * 100).round(),
                            },
                            label: controller.localization.sleepPage?.lightSleep ?? "Light Sleep");
                      }
                    })
                  ],
                ),
              ),
              Obx(() {
                if (controller.totalSleepPercent.value == 0.0) {
                  return const SizedBox();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 48),
                        child: Row(
                          children: [
                            Text(
                              controller.localization.sleepPage?.dailyBreakdown ?? "Daily Breakdown",
                              style: TextStyle(color: const Color(0xFF171433), fontWeight: FontWeight.w600, fontSize: 16.sp),
                            ),
                            4.horizontalSpace,
                            // InkWell(
                            //   onTap: () {
                            //     showModalBottomSheet(
                            //         context: context,
                            //         shape: shapeBorder(),
                            //         isScrollControlled: true,
                            //         builder: (context) {
                            //           return Wrap(children: [
                            //             Container(
                            //               decoration: const BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius: BorderRadius.only(
                            //                   topLeft: Radius.circular(32),
                            //                   topRight: Radius.circular(32),
                            //                 ),
                            //               ),
                            //               child: Padding(
                            //                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                            //                 child: Column(
                            //                   crossAxisAlignment: CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text("Sleep Breakdown", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondaryDarkBlue)),
                            //                     Row(
                            //                       children: [
                            //                         SvgPicture.asset(Constant.icWentToSleep2),
                            //                         Column(
                            //                           children: [
                            //                             Text(controller.localization.sleepPage?.wentToSleep ?? "Went to Sleep",
                            //                                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondaryDarkBlue)),
                            //                             8.verticalSpace,
                            //                             Text(controller.localization.sleepPageLearnMore?.awakeDescription ?? "Awake",
                            //                                 style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutral90)),
                            //                           ],
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             )
                            //           ]);
                            //         });
                            //   },
                            //   child: Icon(
                            //     Icons.info_outline,
                            //     color: const Color(0xFF171433),
                            //     size: 16.sp,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF171433).withOpacity(0.1),
                          ),
                          child: GridView(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              childAspectRatio: 2,
                            ),
                            children: [
                              GetBuilder<SleepController>(builder: (controller) {
                                return DailyBreakdownItem(
                                  image: Constant.icWentToSleep2,
                                  time: controller.wentToSleep.value,
                                  label: controller.localization.sleepPage?.wentToSleep ?? "Went to Sleep",
                                  mainAxisAlignment: MainAxisAlignment.start,
                                );
                              }),
                              GetBuilder<SleepController>(builder: (controller) {
                                return DailyBreakdownItem(
                                  image: Constant.icWokeUp,
                                  time: controller.wokeUp.value,
                                  label: controller.localization.sleepPage?.wokeUp ?? "Woke Up",
                                  mainAxisAlignment: MainAxisAlignment.end,
                                );
                              }),
                              GetBuilder<SleepController>(builder: (controller) {
                                return DailyBreakdownItem(
                                  image: Constant.icFeelASleep,
                                  time: controller.feelASleep.value,
                                  label: controller.localization.sleepPage?.lightSleep ?? "Light Sleep",
                                  mainAxisAlignment: MainAxisAlignment.start,
                                );
                              }),
                              GetBuilder<SleepController>(
                                builder: (controller) {
                                  return DailyBreakdownItem(
                                    image: Constant.icDeepSleep,
                                    time: controller.deepSleep.value,
                                    label: controller.localization.sleepPage?.deepSleep ?? "Deep Sleep",
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      16.verticalSpace,
                    ],
                  );
                }
              }),
              Wrap(
                children: [
                  Center(
                    child: LiveWellButton(
                      label: controller.localization.sleepPage?.inputSleep ?? "Input Sleep",
                      color: const Color(0xFF8F01DF),
                      textColor: Colors.white,
                      wrapSize: true,
                      padding: EdgeInsets.symmetric(horizontal: 36.h, vertical: 12.h),
                      onPressed: () {
                        controller.trackEvent(LivewellSleepEvent.sleepPageInputSleepButton);
                        AppNavigator.push(routeName: AppPages.manualInputSleep);
                      },
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.h),
              //   child: Obx(() {
              //     return WellnessProfileWidget(
              //       type: StreakItemType.sleep,
              //       value: Get.find<DashboardController>().wellnessData.value?.sleepScore ?? 20,
              //     );
              //   }),
              // ),
              16.verticalSpace,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFEBEBEB))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Sleep Habit', style: TextStyle(color: Theme.of(context).colorScheme.neutral100, fontSize: 16.sp, fontWeight: FontWeight.w600, height: 20.sp / 14.sp)),
                        const Spacer(),
                        Text(controller.localization.sleepPage?.last7Days ?? "Last 7 days",
                            style: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontSize: 12.sp, fontWeight: FontWeight.w500, height: 20.sp / 14.sp)),
                      ],
                    ),
                    16.verticalSpace,
                    const Divider(),
                    16.verticalSpace,
                    SizedBox(
                      height: 200.h,
                      child: Stack(
                        children: [
                          GetBuilder<SleepController>(builder: (context) {
                            return BarChart(
                              BarChartData(
                                minY: 0,
                                maxY: controller.getMaxYValue(),
                                barGroups: List.generate(controller.yValues.length, (index) {
                                  return BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(color: controller.isYValueOptimal(index) ? const Color(0xFFDDF235) : const Color(0xFFFA6F6F), width: 14.w, toY: controller.yValues[index] / 60)
                                    ],
                                  );
                                }),
                                barTouchData: BarTouchData(
                                  enabled: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                      return BarTooltipItem(
                                        '${NumberFormat('0.0').format(rod.toY)} ${controller.localization.sleepPage?.hrs ?? 'hrs'}',
                                        TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp),
                                      );
                                    },
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: false,
                                    horizontalInterval: 50,
                                    getDrawingHorizontalLine: (value) {
                                      return FlLine(color: const Color(0xFFebebeb), strokeWidth: 1, dashArray: [2, 2]);
                                    }),
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      reservedSize: 30,
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          NumberFormat('0.0').format(value),
                                          style: TextStyle(color: const Color(0xFF505050), fontSize: 12.sp),
                                        );
                                      },
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            controller.getXValue(value.toInt()),
                                            style: TextStyle(color: const Color(0xFF505050), fontSize: 10.sp, fontWeight: FontWeight.w600),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              controller.localization.sleepPage?.hrs ?? 'hrs',
                              style: TextStyle(color: const Color(0xFF505050), fontSize: 10.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class SmallerSleepCircular extends StatelessWidget {
  final Color color;
  final String label;
  final Map<Color, int> circleColors;
  const SmallerSleepCircular({
    required this.color,
    required this.label,
    required this.circleColors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Center(
            child: MultipleColorCircle(
              colorOccurrences: circleColors,
              height: 50,
              strokeWidth: 8,
              child:
                  // crete circular container
                  Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF171433)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Constant.icWentToSleep,
                        color: color,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(label, style: TextStyle(fontSize: 14.sp, color: const Color(0xFF171433), fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class DailyBreakdownItem extends StatelessWidget {
  final String image;
  final String time;
  final String label;
  final MainAxisAlignment mainAxisAlignment;
  const DailyBreakdownItem({
    required this.image,
    required this.time,
    required this.label,
    required this.mainAxisAlignment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        const Spacer(),
        Expanded(
          flex: 2,
          child: SvgPicture.asset(
            image,
            color: const Color(0xFF8F01DF),
          ),
        ),
        10.horizontalSpace,
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: TextStyle(color: const Color(0xFF171433), fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              Text(
                label,
                style: TextStyle(color: const Color(0xFF171433).withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class ChartGoalLebel extends StatelessWidget {
  final String value;
  const ChartGoalLebel({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF80A4A9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(value, style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 10.sp, fontWeight: FontWeight.w600)),
    );
  }
}
