import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/nutriscore/presentation/controller/nutriscore_controller.dart';
import 'package:livewell/feature/nutriscore/presentation/controller/nutriscore_detail_controller.dart';
import 'package:livewell/widgets/coming_soon/coming_soon_page.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

import 'nutriscore_screen.dart';

class NutriScoreDetailsScreen extends StatelessWidget {
  NutriScoreDetailsScreen({super.key});

  final controller = Get.put(NutriscoreDetailController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        backgroundColor: Colors.white,
        title: controller.localization.nutriscoreDetails!,
        body: Expanded(
          child: content(),
        ));
  }

  Widget comingsoonPage() {
    return const ComingSoonPage(
        imageAsset: Constant.imgComingSoonNutriscore,
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
  }

  SingleChildScrollView content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          24.verticalSpace,
          Text(
            controller.currentType.title(),
            style: TextStyle(
                fontSize: 30.sp,
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
          8.verticalSpace,
          NutriScoreScale(
            score: controller.nutrientScore.value,
            value:
                '${NumberFormat('0.0').format(controller.todaysAmount.value).toString()}${controller.currentType.unit()}',
            status: controller.getNutriScoreStatus(),
            type: controller.currentType,
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score : ',
                style: TextStyle(
                    color: const Color(0xFF171433),
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp),
              ),
              Obx(() {
                return Text(
                  '${NumberFormat('0.0').format(controller.todaysAmount.value).toString()}${controller.currentType.unit()}',
                  style: TextStyle(
                      color: const Color(0xFF171433),
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp),
                );
              }),
              16.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: controller.getNutriScoreStatus().color(),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  controller.getNutriScoreStatus().title(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          20.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
                color: const Color(0xFFD9E4E5),
                borderRadius: BorderRadius.circular(100)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  return Column(
                    children: [
                      Text(
                        controller.localization.todaysAmount!,
                        style: TextStyle(
                            color: const Color(0xFF808080),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      4.verticalSpace,
                      Text(
                        '${NumberFormat('0.0').format(controller.todaysAmount.value).toString()}${controller.currentType.unit()}',
                        style: TextStyle(
                            color: const Color(0xFF171433),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  );
                }),
                Obx(() {
                  return Column(
                    children: [
                      Text(
                        controller.localization.weeklyAverage!,
                        style: TextStyle(
                            color: const Color(0xFF808080),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      4.verticalSpace,
                      Text(
                        '${NumberFormat('0.0').format(controller.weeklyAverage.value).toString()}${controller.currentType.unit()}',
                        style: TextStyle(
                            color: const Color(0xFF171433),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  );
                })
              ],
            ),
          ),
          24.verticalSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEBEBEB))),
            child: Column(
              children: [
                Text('Last 7 days',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        height: 20.sp / 14.sp)),
                16.verticalSpace,
                const Divider(),
                16.verticalSpace,
                SizedBox(
                  height: 200.h,
                  child: Stack(
                    children: [
                      BarChart(
                        BarChartData(
                          barGroups: List.generate(7, (index) {
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                    color: controller.isYValueOptimal(index)
                                        ? const Color(0xFFDDF235)
                                        : controller.currentType ==
                                                    NutrientType.protein ||
                                                controller.currentType ==
                                                    NutrientType.water
                                            ? const Color(0xFFDDF235)
                                            : const Color(0xFFFA6F6F),
                                    width: 12.w,
                                    toY: controller
                                        .nutrientList[index].nutrient.eaten!
                                        .toDouble())
                              ],
                            );
                          }),
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  NumberFormat('0.0')
                                          .format(rod.toY)
                                          .toString() +
                                      controller.currentType.unit(),
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
                              horizontalInterval: 50,
                              verticalInterval: controller.getMaxY() < 1 &&
                                      controller.getMinY() < 1
                                  ? 1
                                  : (controller.getMaxY() -
                                          controller.getMinY()) /
                                      2,
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
                                interval: controller.getMaxY() < 1 &&
                                        controller.getMinY() < 1
                                    ? 1
                                    : (controller.getMaxY() -
                                            controller.getMinY()) /
                                        2,
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
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        controller
                                            .nutrientList[value.toInt()].date
                                            .substring(5)
                                            .replaceAll('-', '/'),
                                        style: TextStyle(
                                            color: const Color(0xFF505050),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          controller.currentType.unit(),
                          style: TextStyle(
                              color: const Color(0xFF505050),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          32.verticalSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.localization.disclaimer!,
                  style: TextStyle(
                      color: const Color(0xFF171433),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                8.verticalSpace,
                Text(
                  controller.localization.livewellNutritionalDataDisclaimer!,
                  style: TextStyle(
                      color: const Color(0xFF808080),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          32.verticalSpace,
        ],
      ),
    );
  }

  NutrientScoreStatus getStatusFromScore(int score) {
    if (score > 10) {
      return NutrientScoreStatus.high;
    }
    if (score >= 5) {
      return NutrientScoreStatus.optimal;
    }
    return NutrientScoreStatus.low;
  }
}

class NutriScoreScale extends StatefulWidget {
  final int score;
  final String value;
  final NutrientScoreStatus status;
  final NutrientType type;
  const NutriScoreScale(
      {super.key,
      required this.score,
      required this.value,
      required this.status,
      required this.type});

  @override
  State<NutriScoreScale> createState() => _NutriScoreScaleState();
}

class _NutriScoreScaleState extends State<NutriScoreScale> {
  final GlobalKey _key = GlobalKey();
  var width = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxRed =
          _key.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        width = renderBoxRed.size.width;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Stack(
        children: [
          SizedBox(
            width: 114.3.w * 3,
            height: 100.h,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LowIndicator(
                      showCursor: getStatusFromScore(widget.score) ==
                          NutrientScoreStatus.low,
                      value: widget.score,
                      type: widget.type,
                    ),
                    OptimalIndicator(
                      showCursor: getStatusFromScore(widget.score) ==
                          NutrientScoreStatus.optimal,
                      value: widget.score,
                      type: widget.type,
                    ),
                    HighIndicator(
                      showCursor: getStatusFromScore(widget.score) ==
                          NutrientScoreStatus.high,
                      value: widget.score,
                      type: widget.type,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: getLeftPadding(widget.score),
            bottom: 23.h,
            child: BuildIndicator(
              key: _key,
              value: widget.score,
              banner: widget.value,
              status: widget.status,
              type: widget.type,
            ),
          ),
        ],
      ),
    );
  }

  double getLeftPadding(int score) {
    switch (getStatusFromScore(score)) {
      case NutrientScoreStatus.low:
      case NutrientScoreStatus.belowTarget:
        return score < 20 ? (score * 1.4.w) : (score * 1.4.w) - width / 2;
      case NutrientScoreStatus.optimal:
      case NutrientScoreStatus.ontrack:
        return ((79 * 1.4.w) + ((114.3.w / 60) * (score - 80)) - width / 2);
      case NutrientScoreStatus.high:
      case NutrientScoreStatus.excellent:
        return ((79 * 1.4.w) + ((114.3.w / 60) * (score - 80)) - width / 2);
      // return ((score - 141) * 1.937.w) - (score > 90 ? 16.w : 0);
    }
  }
}

NutrientScoreStatus getStatusFromScore(int score) {
  if (score > 140) {
    return NutrientScoreStatus.high;
  }
  if (score >= 80) {
    return NutrientScoreStatus.optimal;
  }
  return NutrientScoreStatus.low;
}

class BuildIndicator extends StatelessWidget {
  final int value;
  final String banner;
  final NutrientScoreStatus status;
  final NutrientType type;
  const BuildIndicator({
    Key? key,
    required this.value,
    required this.banner,
    required this.status,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          value < 20 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(Get.find<HomeController>().localization.yourValue!,
            style: TextStyle(color: const Color(0xFF808080), fontSize: 10.sp)),
        2.verticalSpace,
        Text(banner,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700)),
        Column(
          children: [
            Container(
              height: 16.h,
              width: 2.w,
              decoration: BoxDecoration(
                color: status.color(),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 16.h,
                  width: 16.w,
                  decoration: BoxDecoration(
                    color: status.color(),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                Container(
                  height: 12.h,
                  width: 12.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class HighIndicator extends StatelessWidget {
  final bool showCursor;
  final int value;
  final NutrientType type;
  const HighIndicator({
    Key? key,
    required this.showCursor,
    required this.value,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 100.h,
          width: 114.3.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 12.h,
                decoration: BoxDecoration(
                  color: type.highColor(),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
              ),
              8.verticalSpace,
              Text(
                type.highTitle(),
                style: TextStyle(
                    color: const Color(0xFF808080),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OptimalIndicator extends StatelessWidget {
  final bool showCursor;
  final int value;
  final NutrientType type;
  const OptimalIndicator({
    Key? key,
    required this.showCursor,
    required this.value,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 100.h,
          width: 114.3.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 12.h,
                decoration: BoxDecoration(
                  color: type.optimalColor(),
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(8),
                  //     bottomLeft: Radius.circular(8)),
                ),
              ),
              8.verticalSpace,
              Text(
                type.optimalTitle(),
                style: TextStyle(
                    color: const Color(0xFF808080),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LowIndicator extends StatelessWidget {
  final bool showCursor;
  final int value;
  final NutrientType type;
  const LowIndicator({
    Key? key,
    required this.showCursor,
    required this.value,
    required this.type,
  }) : super(key: key);

  // low 0 - 79
  // optimal 80 - 140
  // high 141 - 200

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 100.h,
          width: 114.3.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 12.h,
                decoration: BoxDecoration(
                  color: type.lowColor(),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                ),
              ),
              8.verticalSpace,
              Text(
                type.lowTitle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: const Color(0xFF808080),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
