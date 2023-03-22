import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/exercise/presentation/controller/exercise_controller.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_diary_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/widgets/popup_asset/popup_asset_widget.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int switcherIndex2 = 0;

  ExerciseController controller = Get.put(ExerciseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refresh();
        },
        child: ListView(
          children: [
            40.verticalSpace,
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.transparent,
                  ),
                ),
                const Spacer(),
                Center(
                    child: Text(
                  "Exercise",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF171433)),
                )),
                const Spacer(),
                InkWell(
                  onTap: () {
                    HomeController controller = Get.find();
                    var data = controller.popupAssetsModel.value.exercise;
                    if (data != null) {
                      showModalBottomSheet<dynamic>(
                          context: context,
                          isScrollControlled: true,
                          shape: ShapeBorder.lerp(
                              const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              1),
                          builder: (context) {
                            return Obx(() {
                              return PopupAssetWidget(
                                exercise:
                                    controller.popupAssetsModel.value.exercise!,
                              );
                            });
                          });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: const Icon(
                      Icons.info_outline,
                      color: Color(0xFF171433),
                    ),
                  ),
                ),
              ],
            ),
            38.verticalSpace,
            const ExerciseDiaryScreen(),
            32.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Exercise habit'.tr,
                style: TextStyle(
                    color: const Color(0xFF171433),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            16.verticalSpace,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
              decoration: BoxDecoration(
                  color: Colors.white,
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
                  Obx(() {
                    return SizedBox(
                      height: 200.h,
                      child: Stack(
                        children: [
                          BarChart(
                            BarChartData(
                              minY: 0,
                              barGroups: List.generate(7, (index) {
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                        color: const Color(0xFFDDF235),
                                        width: 12.w,
                                        toY: controller.getYValue(index))
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            controller.getXValue(value.toInt()),
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
                              'kcal.',
                              style: TextStyle(
                                  color: Color(0xFF505050),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
