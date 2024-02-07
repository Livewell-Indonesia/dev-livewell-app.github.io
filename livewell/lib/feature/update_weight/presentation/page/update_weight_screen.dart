import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:livewell/feature/update_weight/presentation/controller/update_weight_controller.dart';
import 'package:livewell/feature/update_weight/presentation/page/goal_setting_screen.dart';
import 'package:livewell/feature/update_weight/presentation/page/update_current_weight_screen.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WeightDataPoint {
  final DateTime x;
  final double y;

  WeightDataPoint({required this.x, required this.y});
}

List<WeightDataPoint> _generateData(int max) {
  final random = Random();

  return List.generate(7, (index) {
    return WeightDataPoint(
        x: DateTime.now().subtract(Duration(days: index)),
        y: random.nextDouble());
  });
}

class UpdateWeightScreen extends StatefulWidget {
  UpdateWeightScreen({super.key});

  @override
  State<UpdateWeightScreen> createState() => _UpdateWeightScreenState();
}

class _UpdateWeightScreenState extends State<UpdateWeightScreen> {
  final UpdateWeightController controller = Get.put(UpdateWeightController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is bool) {
      Future.delayed(
        const Duration(seconds: 1),
        () => scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: "Weight".tr,
        trailing: InkWell(
            child: const Icon(
              Icons.settings_outlined,
              color: Color(0xFF505050),
            ),
            onTap: () {
              Get.to(() => GoalSettingScreen());
            }),
        body: Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.zero,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    32.verticalSpace,
                    Text(
                      'Goal',
                      style: TextStyle(
                          color: const Color(0xFF171433),
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp),
                    ),
                    16.verticalSpace,
                    Container(
                      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF171433),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Obx(() {
                            return Text(controller.title.value,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600));
                          }),
                          4.verticalSpace,
                          Text(
                            controller.localization
                                    .youreDoingGreatKeepYourSpirit ??
                                "",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          16.verticalSpace,
                          Obx(() {
                            return LinearPercentIndicator(
                              padding: EdgeInsets.zero,
                              lineHeight: 12.h,
                              percent: (controller.weight.value /
                                      controller.targetWeight.value)
                                  .maxOneOrZero,
                              barRadius: const Radius.circular(100.0),
                              backgroundColor: const Color(0xFF4D4A68),
                              progressColor: const Color(0xFFDDF235),
                            );
                          }),
                          8.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Text(
                                  '${controller.weight.value} kg',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                );
                              }),
                              Obx(() {
                                return Text(
                                  '${controller.targetWeight} kg',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                );
                              })
                            ],
                          ),
                          16.verticalSpace,
                          const Divider(
                            color: Color(0xFF4D4A68),
                          ),
                          12.verticalSpace,
                          InkWell(
                            onTap: () {
                              Get.to(() => UpdateCurrentWeight());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    controller.localization.updateYourWeight ??
                                        "",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600)),
                                13.horizontalSpace,
                                Icon(Icons.arrow_forward_ios,
                                    color: Colors.white, size: 14.sp),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    32.verticalSpace,
                    Text(
                      controller.localization.weightProgress ?? "",
                      style: TextStyle(
                          color: const Color(0xFF171433),
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp),
                    ),
                    16.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      width: double.infinity,
                      height: 200.h,
                      child: Obx(() {
                        return LineChart(mainData(controller));
                      }),
                    ),
                    32.verticalSpace,
                    Text(
                      controller.localization.calorieIntake ?? "",
                      style: TextStyle(
                          color: const Color(0xFF171433),
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp),
                    ),
                    16.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      width: double.infinity,
                      height: 262.h,
                      child: Column(
                        children: [
                          Text(controller.localization.last7Days!,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                          12.verticalSpace,
                          const Divider(),
                          SizedBox(
                            height: 185.h,
                            child: Obx(() {
                              return BarChart(BarChartData(
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      getTooltipItem:
                                          (group, groupIndex, rod, rodIndex) {
                                        return BarTooltipItem(
                                          '${NumberFormat('0.0').format(rod.toY)} kcal',
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp),
                                        );
                                      },
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: false,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                            color: const Color(0xFFebebeb),
                                            strokeWidth: 1,
                                            dashArray: [2, 2]);
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
                                            value.toInt().toString(),
                                            style: TextStyle(
                                                color: const Color(0xFF505050),
                                                fontSize: 12.sp),
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
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                controller
                                                    .getXValue(value.toInt()),
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF505050),
                                                    fontSize: 12.sp),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  barGroups: List.generate(7, (index) {
                                    return BarChartGroupData(
                                        x: index,
                                        barRods: [
                                          BarChartRodData(
                                            toY: controller.getYValue(index),
                                            color: const Color(0xFFDDF235),
                                            width: 12.w,
                                          )
                                        ]);
                                  })));
                            }),
                          ),
                        ],
                      ),
                    ),
                    32.verticalSpace,
                    Container(
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                          color: const Color(0xFFD9E4E5),
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller
                                    .localization.projectedWeightAfter4Weeks ??
                                "",
                            style: TextStyle(
                                color: const Color(0xFF171433),
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp),
                          ),
                          8.verticalSpace,
                          Obx(() {
                            return Text(
                              '${controller.weightPrediciton.value.round()} kg',
                              style: TextStyle(
                                  color: const Color(0xFF8F01DF),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.sp),
                            );
                          }),
                          8.verticalSpace,
                          Text(
                            controller.localization
                                    .disclaimerProjectionBasedOnTodays ??
                                "",
                            style: TextStyle(
                                color: const Color(0xFF171433),
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    32.verticalSpace,
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  LineChartData mainData(UpdateWeightController controller) {
    return LineChartData(
      minY: 0,
      minX: 0,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 4,
        verticalInterval: 5,
        // getDrawingVerticalLine: (value) {
        //   return FlLine(color: Colors.transparent, strokeWidth: 1);
        // },
        getDrawingHorizontalLine: (value) {
          return FlLine(
              color: const Color(0xFFebebeb),
              strokeWidth: 1,
              dashArray: [2, 2]);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: controller.weightHistory.length - 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 32,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: controller.weightHistory.reversed
              .toList()
              .asMap()
              .entries
              .map((e) {
            return FlSpot(e.key.toDouble(), (e.value.weight ?? 0).toDouble());
          }).toList(),
          isCurved: false,
          barWidth: 2,
          color: const Color(0xFFDDF235),
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
            getDotPainter: (p0, p1, p2, p3) {
              return FlDotCirclePainter(
                radius: 6,
                color: const Color(0xFFDDF235),
                strokeWidth: 1,
                strokeColor: Colors.transparent,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors.map((color) => color).toList(),
            ),
          ),
        ),
      ],
    );
  }

  var gradientColors = [
    const Color(0xffDDF235).withOpacity(0.75),
    Colors.white,
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontWeight: FontWeight.w600,
      color: const Color(0xFF505050),
      fontSize: 10.sp,
    );
    Widget text;
    DateFormat dateFormat = DateFormat('dd/MM');

    text = controller.weightHistory.isEmpty
        ? const Text('')
        : Text(
            dateFormat.format(DateFormat('yyyy-MM-dd').parse(controller
                .weightHistory.reversed
                .toList()[value.toInt()]
                .recordAt!)),
            style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontWeight: FontWeight.w600,
      color: const Color(0xFF505050),
      fontSize: 10.sp,
    );

    return Text(value.toString(), style: style, textAlign: TextAlign.left);
  }
}
