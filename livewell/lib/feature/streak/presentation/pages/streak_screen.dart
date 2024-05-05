import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/streak/presentation/controller/streak_controller.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_calendar.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  final StreakController controller = Get.put(StreakController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.onInit();
          },
          notificationPredicate: (notification) => true,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 60.h),
                  height: 154.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFddf235),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: InkWell(
                          onTap: () {
                            AppNavigator.pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).colorScheme.textLoEm,
                          ),
                        ),
                      ),
                      Text(
                        'Streak Page',
                        style: TextStyles.navbarTitle(context),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.transparent,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    116.verticalSpace,
                    Container(
                      width: 1.sw - 32.w,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.textBg,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // WaveWidget(
                          //   config: SingleConfig(),
                          //   // config: CustomConfig(
                          //   //   colors: [Colors.indigo[400]!],
                          //   //   durations: [18000],
                          //   //   heightPercentages: [0.2],
                          //   // ),
                          //   heightPercentage: 0.2,
                          //   duration: 10000,
                          //   backgroundColor: Colors.red,
                          //   size: Size(42, 50),
                          //   backgroundImage: DecorationImage(image: Image.asset(Constant.accountCircle).image, fit: BoxFit.cover),
                          //   waveAmplitude: 4,
                          // ),
                          ClipPath(
                            clipper: LivewellClipper(),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              color: Theme.of(context).colorScheme.disabled,
                              width: 42.w,
                              height: 56.h,
                              // child: WaveWidget(
                              //   config: CustomConfig(
                              //       durations: [10000, 18000], heightPercentages: [0.0, 0.0], colors: [Theme.of(context).colorScheme.primaryPurple, Theme.of(context).colorScheme.primaryPurple]),
                              //   size: Size(42, 30),
                              //   waveFrequency: 0.1,
                              // ),
                              child: Obx(() {
                                return Container(
                                    alignment: Alignment.bottomCenter, color: Theme.of(context).colorScheme.primaryPurple, width: 42.w, height: calculateHeight(controller.todayProgress.value));
                              }),
                            ),
                          ),
                          // WaveWidget(
                          //   config: CustomConfig(
                          //       durations: [10000, 18000], heightPercentages: [0.0, 0.0], colors: [Theme.of(context).colorScheme.primaryPurple, Theme.of(context).colorScheme.primaryPurple]),
                          //   size: Size(42, 30),
                          //   waveFrequency: 0.1,
                          // ),
                          16.verticalSpace,
                          Obx(() {
                            return Text(
                              '${controller.numberOfStreaks.value}-day streak',
                              style: TextStyle(color: Theme.of(context).colorScheme.textLoEm, fontWeight: FontWeight.w600, fontSize: 16.sp),
                            );
                          }),
                          4.verticalSpace,
                          Text(
                            'Learning daily keeps your streak up',
                            style: TextStyle(color: Theme.of(context).colorScheme.disabled, fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                          24.verticalSpace,
                          Obx(() {
                            return StreakCalendar(
                              onDateSelected: (p0) {
                                controller.onDateSelected(p0);
                              },
                              streakDates: controller.streakDates.value,
                              selectedDate: controller.selectedDate.value,
                            );
                          }),
                          24.verticalSpace,
                          Obx(() {
                            return ListView.separated(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (controller.selectedDate.value.day == DateTime.now().day && controller.selectedDate.value.month == DateTime.now().month)
                                        ? () {
                                            controller.selectedStreak[index].title.navigate();
                                          }
                                        : null,
                                    child: StreakItem(
                                      model: controller.selectedStreak[index],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return 16.verticalSpace;
                                },
                                itemCount: controller.selectedStreak.length);
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double calculateHeight(int todayProgress) {
    if (todayProgress == 0) {
      return 0;
    } else if (todayProgress == 5) {
      return 56.h;
    } else {
      return 56.h / (5 - todayProgress).toDouble();
    }
  }
}

class LivewellClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 43;
    final double _yScaling = size.height / 57;
    path.lineTo(25.8333 * _xScaling, 0.558594 * _yScaling);
    path.cubicTo(
      25.8333 * _xScaling,
      0.558594 * _yScaling,
      27.8067 * _xScaling,
      7.62526 * _yScaling,
      27.8067 * _xScaling,
      13.3586 * _yScaling,
    );
    path.cubicTo(
      27.8067 * _xScaling,
      18.8519 * _yScaling,
      24.2067 * _xScaling,
      23.3053 * _yScaling,
      18.7133 * _xScaling,
      23.3053 * _yScaling,
    );
    path.cubicTo(
      13.1933 * _xScaling,
      23.3053 * _yScaling,
      9.03333 * _xScaling,
      18.8519 * _yScaling,
      9.03333 * _xScaling,
      13.3586 * _yScaling,
    );
    path.cubicTo(
      9.03333 * _xScaling,
      13.3586 * _yScaling,
      9.11333 * _xScaling,
      12.3986 * _yScaling,
      9.11333 * _xScaling,
      12.3986 * _yScaling,
    );
    path.cubicTo(
      3.72667 * _xScaling,
      18.7986 * _yScaling,
      0.5 * _xScaling,
      27.0919 * _yScaling,
      0.5 * _xScaling,
      36.1053 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      47.8919 * _yScaling,
      10.0467 * _xScaling,
      57.4386 * _yScaling,
      21.8333 * _xScaling,
      57.4386 * _yScaling,
    );
    path.cubicTo(
      33.62 * _xScaling,
      57.4386 * _yScaling,
      43.1667 * _xScaling,
      47.8919 * _yScaling,
      43.1667 * _xScaling,
      36.1053 * _yScaling,
    );
    path.cubicTo(
      43.1667 * _xScaling,
      21.7319 * _yScaling,
      36.26 * _xScaling,
      8.90526 * _yScaling,
      25.8333 * _xScaling,
      0.558594 * _yScaling,
    );
    path.cubicTo(
      25.8333 * _xScaling,
      0.558594 * _yScaling,
      25.8333 * _xScaling,
      0.558594 * _yScaling,
      25.8333 * _xScaling,
      0.558594 * _yScaling,
    );
    return path;
  }
}

class LivewellClipperSmall extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 48;
    final double _yScaling = size.height / 32;
    path.lineTo(12.6667 * _xScaling, 0.779297 * _yScaling);
    path.cubicTo(
      12.6667 * _xScaling,
      0.779297 * _yScaling,
      13.6533 * _xScaling,
      4.31263 * _yScaling,
      13.6533 * _xScaling,
      7.1793 * _yScaling,
    );
    path.cubicTo(
      13.6533 * _xScaling,
      9.92596 * _yScaling,
      11.8533 * _xScaling,
      12.1526 * _yScaling,
      9.10667 * _xScaling,
      12.1526 * _yScaling,
    );
    path.cubicTo(
      6.34667 * _xScaling,
      12.1526 * _yScaling,
      4.26667 * _xScaling,
      9.92596 * _yScaling,
      4.26667 * _xScaling,
      7.1793 * _yScaling,
    );
    path.cubicTo(
      4.26667 * _xScaling,
      7.1793 * _yScaling,
      4.30667 * _xScaling,
      6.6993 * _yScaling,
      4.30667 * _xScaling,
      6.6993 * _yScaling,
    );
    path.cubicTo(
      1.61333 * _xScaling,
      9.8993 * _yScaling,
      0 * _xScaling,
      14.046 * _yScaling,
      0 * _xScaling,
      18.5526 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      24.446 * _yScaling,
      4.77333 * _xScaling,
      29.2193 * _yScaling,
      10.6667 * _xScaling,
      29.2193 * _yScaling,
    );
    path.cubicTo(
      16.56 * _xScaling,
      29.2193 * _yScaling,
      21.3333 * _xScaling,
      24.446 * _yScaling,
      21.3333 * _xScaling,
      18.5526 * _yScaling,
    );
    path.cubicTo(
      21.3333 * _xScaling,
      11.366 * _yScaling,
      17.88 * _xScaling,
      4.95263 * _yScaling,
      12.6667 * _xScaling,
      0.779297 * _yScaling,
    );
    path.cubicTo(
      12.6667 * _xScaling,
      0.779297 * _yScaling,
      12.6667 * _xScaling,
      0.779297 * _yScaling,
      12.6667 * _xScaling,
      0.779297 * _yScaling,
    );
    return path;
  }
}
