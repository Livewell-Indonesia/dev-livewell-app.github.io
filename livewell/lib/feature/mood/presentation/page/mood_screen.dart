import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/mood/presentation/controller/mood_screen_controller.dart';
import 'package:livewell/feature/mood/presentation/widget/mood_picker_widget.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  final controller = Get.put(MoodScreenController());

  @override
  void initState() {
    controller.trackEvent(LivewellMoodEvent.moodPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: controller.localization.moodPage?.moodTracker ?? "Mood Tracker",
        onBack: () {
          controller.trackEvent(LivewellMoodEvent.moodPageBackButton);
          Get.back();
        },
        body: Expanded(
          child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        32.verticalSpace,
                        Text(
                          controller.localization.moodPage?.moodChart ?? "Mood chart",
                          style: TextStyle(color: const Color(0xFF171433), fontWeight: FontWeight.w600, fontSize: 20.sp),
                        ),
                        16.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                          width: double.infinity,
                          height: 263.h,
                          child: Column(children: [
                            Text(controller.localization.moodPage?.last14Days ?? "Last 14 days", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w700)),
                            12.verticalSpace,
                            const Divider(),
                            SizedBox(
                              height: 185.h,
                              child: Obx(() {
                                return LineChart(mainData(controller));
                              }),
                            ),
                          ]),
                        ),
                        32.verticalSpace,
                        Text(
                          controller.localization.moodPage?.moodCount ?? "Mood Count",
                          style: TextStyle(color: const Color(0xFF171433), fontWeight: FontWeight.w600, fontSize: 20.sp),
                        ),
                        16.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: MoodType.values.map((e) {
                              return InkWell(
                                onTap: () {
                                  controller.postMoodData(e);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Obx(() {
                                          return SvgPicture.asset(e.assets(), color: getColor(e), width: 48.w, height: 48.h);
                                        }),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(child: Obx(() {
                                              return Container(
                                                  padding: EdgeInsets.all(4.w),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: getColorForIndicator(e),
                                                  ),
                                                  child: Text(
                                                    controller.getTotalMoodByType(e.value()).toString(),
                                                    style: TextStyle(color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.w700),
                                                  ));
                                            })),
                                          ),
                                        )
                                      ],
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      e.title(),
                                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFF171433).withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }

  Color? getColor(MoodType type) {
    if (controller.isMoodSelected.value != null) {
      if (controller.isMoodSelected.value!.value! == type.value()) {
        return null;
      } else {
        return const Color(0xFF171433).withOpacity(0.3);
      }
    } else {
      return const Color(0xFF171433).withOpacity(0.3);
    }
  }

  Color? getColorForIndicator(MoodType type) {
    if (controller.isMoodSelected.value != null) {
      if (controller.isMoodSelected.value!.value! == type.value()) {
        return type.mainColor();
      } else {
        return const Color(0xFF171433).withOpacity(0.3);
      }
    } else {
      return const Color(0xFF171433).withOpacity(0.3);
    }
  }

  LineChartData mainData(MoodScreenController controller) {
    return LineChartData(
        minX: 0,
        minY: 0,
        maxY: 6,
        maxX: 13,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          verticalInterval: 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xFFE5E5E5),
              strokeWidth: 0.5,
            );
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
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 32,
              interval: 1,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(14, (index) {
              if (controller.moodList.isNotEmpty) {
                final date = DateTime.now().subtract(Duration(days: 14 - index - 1));
                final mood = controller.getMoodByDate(date);
                if (mood != null) {
                  return FlSpot(index.toDouble(), mood.value!.toDouble());
                } else {
                  return FlSpot(index.toDouble(), 0);
                }
              } else {
                return FlSpot(index.toDouble(), 0);
              }
            }),
            // spots: controller.moodList.toList().asMap().entries.map((e) {
            //   return FlSpot(e.key.toDouble(), (e.value.value ?? 0).toDouble());
            // }).toList(),
            isCurved: false,
            barWidth: 2,
            color: const Color(0xFFD9D9D9),
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
          )
        ]);
  }

  var gradientColors = [
    const Color(0xFFD9D9D9).withOpacity(0.8),
    const Color(0xFFD9D9D9).withOpacity(0.1),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontWeight: FontWeight.w600,
      color: const Color(0xFF505050),
      fontSize: 10.sp,
    );
    DateFormat dateFormat = DateFormat('d');
    Widget text;
    text = Text(
      dateFormat.format(DateTime.now().subtract(Duration(days: 14 - value.toInt() - 1))),
      style: style,
    );

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    text = value == 6.0 || value == 0
        ? const Text('')
        : Container(
            width: 12.w,
            height: 12.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: intToColor(value.toInt()),
            ),
          );

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  Color intToColor(int value) {
    return MoodType.values.firstWhere((element) => element.value() == value).mainColor();
  }
}
