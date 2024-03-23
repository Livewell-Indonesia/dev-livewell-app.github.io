import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/nutriscore/presentation/controller/nutriscore_score_detail_controller.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class NutriscoreScoreDetailScreen extends StatefulWidget {
  const NutriscoreScoreDetailScreen({super.key});

  @override
  State<NutriscoreScoreDetailScreen> createState() => _NutriscoreScoreDetailScreenState();
}

class _NutriscoreScoreDetailScreenState extends State<NutriscoreScoreDetailScreen> {
  final NutriscoreScoreDetailController controller = Get.put(NutriscoreScoreDetailController());
  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      backgroundColor: Colors.white,
      title: controller.localization.nutriscoreDetails!,
      body: Expanded(
        child: content(),
      ),
    );
  }

  SingleChildScrollView content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          24.verticalSpace,
          Text(
            'Nutriscore',
            style: TextStyle(fontSize: 30.sp, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          8.verticalSpace,
          Obx(() {
            return NutriScoreDetailScale(
              score: controller.nutrientScore.value,
              value: NumberFormat('0.0').format(controller.todaysAmount.value).toString(),
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score : ',
                style: TextStyle(color: const Color(0xFF171433), fontWeight: FontWeight.w400, fontSize: 16.sp),
              ),
              Obx(() {
                return Text(
                  NumberFormat('0.0').format(controller.todaysAmount.value).toString(),
                  style: TextStyle(color: const Color(0xFF171433), fontWeight: FontWeight.w700, fontSize: 16.sp),
                );
              }),
              16.horizontalSpace,
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: getStatusFromScore(controller.nutrientScore.value.toInt()).color(),
                    //color: controller.getNutriScoreStatus().color(),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Obx(() {
                    return Text(
                      getStatusFromScore(controller.nutrientScore.value.toInt()).title(),
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700),
                    );
                  })),
            ],
          ),
          20.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(color: const Color(0xFFD9E4E5), borderRadius: BorderRadius.circular(100)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  return Column(
                    children: [
                      Text(
                        controller.localization.todaysAmount!,
                        style: TextStyle(color: const Color(0xFF808080), fontSize: 10.sp, fontWeight: FontWeight.w600),
                      ),
                      4.verticalSpace,
                      Text(
                        NumberFormat('0.0').format(controller.todaysAmount.value).toString(),
                        style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w600),
                      )
                    ],
                  );
                }),
                Obx(() {
                  return Column(
                    children: [
                      Text(
                        controller.localization.weeklyAverage!,
                        style: TextStyle(color: const Color(0xFF808080), fontSize: 10.sp, fontWeight: FontWeight.w600),
                      ),
                      4.verticalSpace,
                      Text(
                        NumberFormat('0.0').format(controller.weeklyAverage.value).toString(),
                        style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w600),
                      )
                    ],
                  );
                }),
              ],
            ),
          ),
          24.verticalSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFEBEBEB))),
            child: Column(
              children: [
                Text(controller.localization.last7Days!, style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w700, height: 20.sp / 14.sp)),
                16.verticalSpace,
                const Divider(),
                16.verticalSpace,
                SizedBox(
                  height: 200.h,
                  child: Stack(children: [
                    BarChart(
                      BarChartData(
                        barGroups: List.generate(7, (index) {
                          return BarChartGroupData(x: index, barRods: [
                            BarChartRodData(color: getStatusFromScore(controller.nutrientList[index].value.toInt()).color(), width: 12.w, toY: controller.nutrientList[index].value.toDouble())
                          ]);
                        }),
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                NumberFormat('0.0').format(rod.toY).toString(),
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
                            verticalInterval: controller.getMaxY() < 1 && controller.getMinY() < 1 ? 1 : (controller.getMaxY() - controller.getMinY()) / 2,
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
                              interval: controller.getMaxY() < 1 && controller.getMinY() < 1 ? 1 : (controller.getMaxY() - controller.getMinY()) / 2,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
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
                                      controller.nutrientList[value.toInt()].date.substring(5).replaceAll('-', '/'),
                                      style: TextStyle(color: const Color(0xFF505050), fontSize: 12.sp),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
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
                  style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                8.verticalSpace,
                Text(
                  'Livewell nutritional data is for general fitness and wellness use. May contain inaccuracies. Consult a professional for personalized advice.',
                  style: TextStyle(color: const Color(0xFF808080), fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          32.verticalSpace,
        ],
      ),
    );
  }
}

class NutriScoreDetailScale extends StatefulWidget {
  final int score;
  final String value;
  const NutriScoreDetailScale({super.key, required this.score, required this.value});

  @override
  State<NutriScoreDetailScale> createState() => _NutriScoreDetailScaleState();
}

class _NutriScoreDetailScaleState extends State<NutriScoreDetailScale> {
  final GlobalKey _key = GlobalKey();
  var width = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxRed = _key.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        width = renderBoxRed.size.width;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 114.3.w * 3,
          height: 100.h,
          child: Column(
            children: [
              Row(
                children: [
                  NutriscoreLowIndicator(
                    showCursor: getStatusFromScore(widget.score) == NutriScoreStatus.low,
                    value: widget.score,
                  ),
                  NutriscoreMidIndicator(
                    showCursor: getStatusFromScore(widget.score) == NutriScoreStatus.mid,
                    value: widget.score,
                  ),
                  NutriscoreOptimalIndicator(
                    showCursor: getStatusFromScore(widget.score) == NutriScoreStatus.optimal,
                    value: widget.score,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: getLeftPadding(widget.score),
          bottom: 19.h,
          child: BuildDetailIndicator(key: _key, value: widget.score, banner: widget.value),
        ),
      ],
    );
  }

  double getLeftPadding(int score) {
    switch (getStatusFromScore(score)) {
      case NutriScoreStatus.low:
        return score < 10 ? (score * 2.28.w) : (score * 2.28.w) - width / 2;
      case NutriScoreStatus.mid:
        return ((50 * 2.28.w) + ((114.3.w / 30) * (score - 50)) - width / 2);
      case NutriScoreStatus.optimal:
        return ((50 * 2.28.w) + ((114.3.w / 28) * (score - 50)) - width / 2);
    }
  }
}

NutriScoreStatus getStatusFromScore(int score) {
  if (score >= 80) {
    return NutriScoreStatus.optimal;
  }
  if (score > 50) {
    return NutriScoreStatus.mid;
  }
  return NutriScoreStatus.low;
}

enum NutriScoreStatus {
  low,
  mid,
  optimal,
}

extension on NutriScoreStatus {
  Color color() {
    switch (this) {
      case NutriScoreStatus.low:
        return Colors.red;
      case NutriScoreStatus.mid:
        return Colors.orange;
      case NutriScoreStatus.optimal:
        return Colors.green;
    }
  }

  String title() {
    switch (this) {
      case NutriScoreStatus.low:
        return 'Low'.tr;
      case NutriScoreStatus.mid:
        return 'Mid'.tr;
      case NutriScoreStatus.optimal:
        return 'Optimal'.tr;
    }
  }
}

class BuildDetailIndicator extends StatelessWidget {
  final int value;
  final String banner;
  const BuildDetailIndicator({
    Key? key,
    required this.value,
    required this.banner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: value < 10
          ? CrossAxisAlignment.start
          : value > 89
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.center,
      children: [
        Text(Get.find<HomeController>().localization.yourValue!, style: TextStyle(color: const Color(0xFF808080), fontSize: 10.sp)),
        2.verticalSpace,
        Text(banner, style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w700)),
        Column(
          children: [
            Container(
              height: 16.h,
              width: 2.w,
              decoration: BoxDecoration(
                color: getStatusFromScore(value).color(),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 16.h,
                  width: 16.w,
                  decoration: BoxDecoration(
                    color: getStatusFromScore(value).color(),
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

class NutriscoreOptimalIndicator extends StatelessWidget {
  final bool showCursor;
  final int value;
  const NutriscoreOptimalIndicator({
    Key? key,
    required this.showCursor,
    required this.value,
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
                  color: NutriScoreStatus.optimal.color(),
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                ),
              ),
              8.verticalSpace,
              Text(
                Get.find<HomeController>().localization.optimal!,
                style: TextStyle(color: const Color(0xFF808080), fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NutriscoreMidIndicator extends StatelessWidget {
  final bool showCursor;
  final int value;
  const NutriscoreMidIndicator({
    Key? key,
    required this.showCursor,
    required this.value,
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
                  color: NutriScoreStatus.mid.color(),
                ),
              ),
              8.verticalSpace,
              Text(
                Get.find<HomeController>().localization.mid!,
                style: TextStyle(color: const Color(0xFF808080), fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NutriscoreLowIndicator extends StatelessWidget {
  final bool showCursor;
  final int value;
  const NutriscoreLowIndicator({
    Key? key,
    required this.showCursor,
    required this.value,
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
                  color: NutriScoreStatus.low.color(),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                ),
              ),
              8.verticalSpace,
              Text(
                Get.find<HomeController>().localization.low!,
                style: TextStyle(color: const Color(0xFF808080), fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
