import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/sleep/controller/sleep_controller.dart';
import 'package:livewell/widgets/chart/circular_nutrition.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  final SleepController controller = Get.put(SleepController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.onInit();
        },
        child: ListView(
          children: [
            40.verticalSpace,
            Center(
                child: Text(
              "Sleep",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF171433)),
            )),
            38.verticalSpace,
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Obx(() {
                  return Center(
                    child: MultipleColorCircle(
                      colorOccurrences: {
                        const Color(0xFF8F01DF):
                            controller.lightSleepPercentage.value,
                        const Color(0xFFDDF235):
                            controller.deepSleepPercentage.value,
                        Colors.white: controller.remainingSleepPercentage.value,
                      },
                      height: 200,
                      strokeWidth: 32,
                      child:
                          // crete circular container
                          Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF171433)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Constant.icWentToSleep,
                                color: const Color(0xFF8F01DF),
                              ),
                              10.verticalSpace,
                              Text(
                                "${(controller.totalSleepPercentage.value)}%",
                                style: TextStyle(
                                    fontSize: 43.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              4.verticalSpace,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  'of daily goals',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      color: Colors.white.withOpacity(0.63)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  Obx(() {
                    return SmallerSleepCircular(
                        color: const Color(0xFFDDF235),
                        value: controller.deepSleepPercentage.value,
                        label: 'Deep Sleep');
                  }),
                  const Spacer(),
                  Obx(() {
                    return SmallerSleepCircular(
                        color: const Color(0xFF8F01DF),
                        value: controller.lightSleepPercentage.value,
                        label: "Light Sleep");
                  })
                ],
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "Daily Breakdown",
                style: TextStyle(
                    color: const Color(0xFF171433),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp),
              ),
            ),
            20.verticalSpace,
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFF171433).withOpacity(0.1),
                ),
                child: Obx(() {
                  return GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 2,
                    ),
                    children: [
                      DailyBreakdownItem(
                          image: Constant.icWentToSleep2,
                          time: controller.wentToSleep.value,
                          label: "Went to sleep"),
                      DailyBreakdownItem(
                          image: Constant.icWokeUp,
                          time: controller.wokeUp.value,
                          label: "Woke up"),
                      DailyBreakdownItem(
                          image: Constant.icFeelASleep,
                          time: controller.feelASleep.value,
                          label: "Feel a sleep"),
                      DailyBreakdownItem(
                          image: Constant.icDeepSleep,
                          time: controller.deepSleep.value,
                          label: "Deep Sleep"),
                    ],
                  );
                }))
          ],
        ),
      ),
    );
  }
}

class SmallerSleepCircular extends StatelessWidget {
  final Color color;
  final int value;
  final String label;
  const SmallerSleepCircular({
    required this.color,
    required this.value,
    required this.label,
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
              colorOccurrences: {
                color: value,
                Colors.white: 100 - value,
              },
              height: 50,
              strokeWidth: 8,
              child:
                  // crete circular container
                  Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF171433)),
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
        Text(label,
            style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xFF171433),
                fontWeight: FontWeight.w600)),
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
              style: TextStyle(
                  color: const Color(0xFF171433),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
            Text(
              label,
              style: TextStyle(
                  color: const Color(0xFF171433).withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp),
            ),
          ],
        ),
      ]),
    );
  }
}
