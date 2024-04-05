import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/sleep/presentation/controller/sleep_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/chart/circular_nutrition.dart';
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
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: controller.localization.sleep!,
      trailing: InkWell(
        onTap: () {
          HomeController controller = Get.find();
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
            controller.refreshList();
          },
          child: ListView(
            children: [
              40.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(child: Obx(() {
                  return MultipleColorCircle(
                    colorOccurrences: {
                      const Color(0xFF8F01DF): controller.lightSleepPercent.value.round() * 100,
                      const Color(0xFFDDF235): controller.deepSleepPercent.value.round() * 100,
                      const Color(0xFF34EAB2): controller.sleepInBedPercent.value.round() * 100,
                      Colors.white: controller.leftSleepPercent.value.round(),
                    },
                    height: 200,
                    strokeWidth: 32,
                    child:
                        // crete circular container
                        Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF171433)),
                      child: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          SvgPicture.asset(
                            Constant.icWentToSleep,
                            color: const Color(0xFF8F01DF),
                          ),
                          10.verticalSpace,
                          Text(
                            "${controller.totalSleepPercent.value.toInt()}%",
                            style: TextStyle(fontSize: 43.sp, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                          4.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              controller.localization.ofDailyGoals!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17.sp, color: Colors.white.withOpacity(0.63)),
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
                        return SmallerSleepCircular(color: const Color(0xFFDDF235), label: controller.localization.deepSleep ?? "", circleColors: {
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
                            label: controller.localization.lightSleep ?? "");
                      }
                    })
                  ],
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  controller.localization.dailyBreakdown!,
                  style: TextStyle(color: const Color(0xFF171433), fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
              ),
              20.verticalSpace,
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171433).withOpacity(0.1),
                  ),
                  child: GridView(
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
                        return DailyBreakdownItem(image: Constant.icWentToSleep2, time: controller.wentToSleep.value, label: controller.localization.wentToSleep ?? "");
                      }),
                      GetBuilder<SleepController>(builder: (controller) {
                        return DailyBreakdownItem(image: Constant.icWokeUp, time: controller.wokeUp.value, label: controller.localization.wokeUp ?? "");
                      }),
                      GetBuilder<SleepController>(builder: (controller) {
                        return DailyBreakdownItem(image: Constant.icFeelASleep, time: controller.feelASleep.value, label: controller.localization.lightSleep ?? "");
                      }),
                      GetBuilder<SleepController>(builder: (controller) {
                        return DailyBreakdownItem(image: Constant.icDeepSleep, time: controller.deepSleep.value, label: controller.localization.deepSleep ?? "");
                      }),
                    ],
                  )),
              16.verticalSpace,
              LiveWellButton(
                label: "Input Sleep",
                color: const Color(0xFF8F01DF),
                textColor: Colors.white,
                onPressed: () {
                  AppNavigator.push(routeName: AppPages.manualInputSleep);
                },
              ),
              16.verticalSpace,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFEBEBEB))),
                child: Column(
                  children: [
                    Text(controller.localization.last7Days!, style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w700, height: 20.sp / 14.sp)),
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
                                        '${NumberFormat('0.0').format(rod.toY)}hrs',
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
                                        return Transform.rotate(
                                          angle: -45,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Text(
                                              controller.getXValue(value.toInt()),
                                              style: TextStyle(color: const Color(0xFF505050), fontSize: 11.sp),
                                            ),
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
                              'hrs.',
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
  const DailyBreakdownItem({
    required this.image,
    required this.time,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          image,
          color: const Color(0xFF8F01DF),
        ),
        10.horizontalSpace,
        Column(
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
