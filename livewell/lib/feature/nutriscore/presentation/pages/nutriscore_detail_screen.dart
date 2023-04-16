import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/constant/constant.dart';
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
        title: 'NutriScore Details'.tr,
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
          NutriScoreScale(),
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
                        "Today’s Amount",
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
                        "Weekly Average",
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
          // 16.verticalSpace,
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.w),
          //   child: Text(
          //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: const Color(0xFF808080),
          //       fontSize: 14.sp,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
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
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       'About Protein',
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 20.sp,
          //           fontWeight: FontWeight.w700),
          //     ),
          //   ),
          // ),
          // 8.verticalSpace,
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.w),
          //   child: Text(
          //     'Protein is a vital nutrient that helps build and repair muscles, boost the immune system, and aid in weight management. You can find it in delicious foods like meat, fish, eggs, dairy, beans, and nuts. Mix it up and try different sources to make sure you\'re getting all the nutrients your body needs.',
          //     style: TextStyle(
          //       fontSize: 14.sp,
          //       fontWeight: FontWeight.w400,
          //       color: const Color(0xFF808080),
          //     ),
          //   ),
          // ),
          // 24.verticalSpace,
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
                  'Disclaimer',
                  style: TextStyle(
                      color: const Color(0xFF171433),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                8.verticalSpace,
                Text(
                  'Livewell nutritional data is for general fitness and wellness use. May contain inaccuracies. Consult a professional for personalized advice.',
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
  NutriScoreScale({super.key});

  @override
  State<NutriScoreScale> createState() => _NutriScoreScaleState();
}

class _NutriScoreScaleState extends State<NutriScoreScale> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Stack(
        children: [
          Container(
            key: _key,
            width: 1.sw,
            height: 100.h,
            child: Builder(builder: (context) {
              return Column(
                children: [
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 12.h,
                              decoration: const BoxDecoration(
                                color: Color(0xFF808080),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              'Low',
                              style: TextStyle(
                                  color: const Color(0xFF808080),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 12.h,
                              decoration: const BoxDecoration(
                                color: Color(0xFF80A4A9),
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              'Optimal',
                              style: TextStyle(
                                  color: const Color(0xFF808080),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 12.h,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFA6F6F),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              'High',
                              style: TextStyle(
                                  color: const Color(0xFF808080),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
          Positioned(
            left: (1.sw - 48.w),
            top: 48.h,
            child: _buildIndicator(360 - 114.w),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(double value) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Your Value ${32.w}',
          //     style:
          //         TextStyle(color: const Color(0xFF808080), fontSize: 10.sp)),
          // 2.verticalSpace,
          // Text('9888,8mg',
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 16.sp,
          //         fontWeight: FontWeight.w700)),
          Column(
            children: [
              Container(
                height: 16.h,
                width: 2.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF808080),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 16.h,
                    width: 16.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF808080),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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
      ),
    );
  }

  double getWidth() {
    if (_key.currentContext == null) {
      return 0;
    }
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;
    return renderBox.size.width;
  }

  double getHeight() {
    if (_key.currentContext == null) {
      return 0;
    }
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }
}
