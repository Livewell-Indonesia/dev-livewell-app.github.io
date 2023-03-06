import 'package:charts_painter/chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
          child: comingsoonPage(),
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
          24.verticalSpace,
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
              Text(
                '${controller.nutrientValue.round()}/10',
                style: TextStyle(
                    color: const Color(0xFF171433),
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp),
              ),
              16.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: getStatusFromScore(controller.nutrientValue.toInt())
                      .color(),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  getStatusFromScore(controller.nutrientValue.toInt()).title(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF808080),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
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
                  child: BarChart(
                    BarChartData(
                      maxY: controller.getMaxY(),
                      minY: controller.getMinY(),
                      barGroups: List.generate(7, (index) {
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                                toY: controller
                                    .nutrientList[index].nutrient.eaten!
                                    .toDouble())
                          ],
                        );
                      }),
                      barTouchData: BarTouchData(
                        enabled: true,
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 50,
                          verticalInterval: controller.getMaxY() < 1 &&
                                  controller.getMinY() < 1
                              ? 1
                              : (controller.getMaxY() - controller.getMinY()) /
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
                                    controller.nutrientList[value.toInt()].date
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
                ),
              ],
            ),
          ),
          32.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About Protein',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Protein is a vital nutrient that helps build and repair muscles, boost the immune system, and aid in weight management. You can find it in delicious foods like meat, fish, eggs, dairy, beans, and nuts. Mix it up and try different sources to make sure you\'re getting all the nutrients your body needs.',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF808080),
              ),
            ),
          ),
          24.verticalSpace,
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
