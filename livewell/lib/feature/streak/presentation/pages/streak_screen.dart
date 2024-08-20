import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/streak/presentation/controller/streak_controller.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_calendar.dart';
import 'package:livewell/feature/streak/presentation/widget/streak_item.dart';
import 'package:livewell/theme/design_system.dart';

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  final StreakController controller = Get.put(StreakController());

  @override
  void initState() {
    controller.trackEvent(LivewellStreakEvent.streakPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 60.h, left: 16.w, right: 16.w),
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
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                    // GestureDetector(
                    //   //behavior: HitTestBehavior.translucent,
                    //   onTap: () {
                    //     Get.back();
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: 16.w),
                    //     child: Container(
                    //       width: 31.w,
                    //       height: 31.h,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: SizedBox(
                    //         child: Icon(
                    //           Icons.arrow_back_ios_new_rounded,
                    //           size: 18.h,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        controller.localization.streakPage?.streakPage ?? "Streak Page",
                        style: TextStyles.navbarTitle(context),
                      ),
                    ),
                    const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.transparent,
                        )),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
          Positioned(
            top: 116.h,
            child: RefreshIndicator(
              onRefresh: () async {
                controller.onInit();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 116.verticalSpace,
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
                              '${controller.numberOfStreaks.value} ${controller.localization.streakPage?.dayStreak ?? ''}',
                              style: TextStyle(color: Theme.of(context).colorScheme.textLoEm, fontWeight: FontWeight.w600, fontSize: 16.sp),
                            );
                          }),
                          4.verticalSpace,
                          Text(
                            controller.localization.streakPage?.learningDailyKeepsYourStreakUp ?? 'Learning daily keeps your streak up',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Theme.of(context).colorScheme.disabled, fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                          24.verticalSpace,
                          Obx(() {
                            return StreakCalendar(
                              onDateSelected: (p0) {
                                controller.trackEvent(LivewellStreakEvent.streakPageDateButton);
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateHeight(int todayProgress) {
    if (todayProgress == 0) {
      return 0;
    } else if (todayProgress == 5) {
      return 56.h;
    } else {
      return 56.h * (todayProgress / 5);
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
    final double xScaling = size.width / 43;
    final double yScaling = size.height / 57;
    path.lineTo(25.8333 * xScaling, 0.558594 * yScaling);
    path.cubicTo(
      25.8333 * xScaling,
      0.558594 * yScaling,
      27.8067 * xScaling,
      7.62526 * yScaling,
      27.8067 * xScaling,
      13.3586 * yScaling,
    );
    path.cubicTo(
      27.8067 * xScaling,
      18.8519 * yScaling,
      24.2067 * xScaling,
      23.3053 * yScaling,
      18.7133 * xScaling,
      23.3053 * yScaling,
    );
    path.cubicTo(
      13.1933 * xScaling,
      23.3053 * yScaling,
      9.03333 * xScaling,
      18.8519 * yScaling,
      9.03333 * xScaling,
      13.3586 * yScaling,
    );
    path.cubicTo(
      9.03333 * xScaling,
      13.3586 * yScaling,
      9.11333 * xScaling,
      12.3986 * yScaling,
      9.11333 * xScaling,
      12.3986 * yScaling,
    );
    path.cubicTo(
      3.72667 * xScaling,
      18.7986 * yScaling,
      0.5 * xScaling,
      27.0919 * yScaling,
      0.5 * xScaling,
      36.1053 * yScaling,
    );
    path.cubicTo(
      0.5 * xScaling,
      47.8919 * yScaling,
      10.0467 * xScaling,
      57.4386 * yScaling,
      21.8333 * xScaling,
      57.4386 * yScaling,
    );
    path.cubicTo(
      33.62 * xScaling,
      57.4386 * yScaling,
      43.1667 * xScaling,
      47.8919 * yScaling,
      43.1667 * xScaling,
      36.1053 * yScaling,
    );
    path.cubicTo(
      43.1667 * xScaling,
      21.7319 * yScaling,
      36.26 * xScaling,
      8.90526 * yScaling,
      25.8333 * xScaling,
      0.558594 * yScaling,
    );
    path.cubicTo(
      25.8333 * xScaling,
      0.558594 * yScaling,
      25.8333 * xScaling,
      0.558594 * yScaling,
      25.8333 * xScaling,
      0.558594 * yScaling,
    );
    return path;
  }
}

class LivewellBottleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = 20.0;
    final double _xScaling = size.width / 259;
    final double _yScaling = size.height / 412;
    path.lineTo(120.799 * _xScaling, 0.0000308191 * _yScaling);
    path.cubicTo(
      120.799 * _xScaling,
      0.0000308191 * _yScaling,
      138.199 * _xScaling,
      0.0000308191 * _yScaling,
      138.199 * _xScaling,
      0.0000308191 * _yScaling,
    );
    path.cubicTo(
      147.22 * _xScaling,
      -0.00446338 * _yScaling,
      155.96 * _xScaling,
      3.13678 * _yScaling,
      162.907 * _xScaling,
      8.88089 * _yScaling,
    );
    path.cubicTo(
      169.854 * _xScaling,
      14.625 * _yScaling,
      174.572 * _xScaling,
      22.611 * _yScaling,
      176.246 * _xScaling,
      31.4586 * _yScaling,
    );
    path.cubicTo(
      177.92 * _xScaling,
      40.3063 * _yScaling,
      176.444 * _xScaling,
      49.4595 * _yScaling,
      172.074 * _xScaling,
      57.3364 * _yScaling,
    );
    path.cubicTo(
      167.703 * _xScaling,
      65.2133 * _yScaling,
      179.798 * _xScaling,
      64.5 * _yScaling,
      182.311 * _xScaling,
      74.5977 * _yScaling,
    );
    path.cubicTo(
      185.433 * _xScaling,
      87.138 * _yScaling,
      194.618 * _xScaling,
      96.6398 * _yScaling,
      208.679 * _xScaling,
      110.468 * _yScaling,
    );
    path.cubicTo(
      208.679 * _xScaling,
      110.468 * _yScaling,
      208.937 * _xScaling,
      110.725 * _yScaling,
      208.937 * _xScaling,
      110.725 * _yScaling,
    );
    path.cubicTo(
      218.844 * _xScaling,
      120.459 * _yScaling,
      230.583 * _xScaling,
      131.995 * _yScaling,
      240.851 * _xScaling,
      147.367 * _yScaling,
    );
    path.cubicTo(
      241.109 * _xScaling,
      147.711 * _yScaling,
      241.324 * _xScaling,
      148.071 * _yScaling,
      241.496 * _xScaling,
      148.449 * _yScaling,
    );
    path.cubicTo(
      253.903 * _xScaling,
      167.681 * _yScaling,
      259.782 * _xScaling,
      190.386 * _yScaling,
      258.266 * _xScaling,
      213.21 * _yScaling,
    );
    path.cubicTo(
      258.421 * _xScaling,
      215.098 * _yScaling,
      258.498 * _xScaling,
      216.987 * _yScaling,
      258.498 * _xScaling,
      218.875 * _yScaling,
    );
    path.cubicTo(
      258.498 * _xScaling,
      218.875 * _yScaling,
      258.498 * _xScaling,
      347.625 * _yScaling,
      258.498 * _xScaling,
      347.625 * _yScaling,
    );
    path.cubicTo(
      258.498 * _xScaling,
      358.925 * _yScaling,
      255.517 * _xScaling,
      370.026 * _yScaling,
      249.856 * _xScaling,
      379.812 * _yScaling,
    );
    path.cubicTo(
      244.195 * _xScaling,
      389.598 * _yScaling,
      236.053 * _xScaling,
      397.724 * _yScaling,
      226.248 * _xScaling,
      403.374 * _yScaling,
    );
    path.cubicTo(
      216.443 * _xScaling,
      409.024 * _yScaling,
      205.32 * _xScaling,
      411.998 * _yScaling,
      193.998 * _xScaling,
      411.998 * _yScaling,
    );
    path.cubicTo(
      182.676 * _xScaling,
      411.998 * _yScaling,
      171.554 * _xScaling,
      409.024 * _yScaling,
      161.749 * _xScaling,
      403.374 * _yScaling,
    );
    path.cubicTo(
      151.944 * _xScaling,
      409.024 * _yScaling,
      140.821 * _xScaling,
      412 * _yScaling,
      129.499 * _xScaling,
      412 * _yScaling,
    );
    path.cubicTo(
      118.177 * _xScaling,
      412 * _yScaling,
      107.054 * _xScaling,
      409.024 * _yScaling,
      97.2493 * _xScaling,
      403.374 * _yScaling,
    );
    path.cubicTo(
      87.4443 * _xScaling,
      409.024 * _yScaling,
      76.3219 * _xScaling,
      411.998 * _yScaling,
      65 * _xScaling,
      411.998 * _yScaling,
    );
    path.cubicTo(
      53.6781 * _xScaling,
      411.998 * _yScaling,
      42.5556 * _xScaling,
      409.024 * _yScaling,
      32.7505 * _xScaling,
      403.374 * _yScaling,
    );
    path.cubicTo(
      22.9454 * _xScaling,
      397.724 * _yScaling,
      14.8031 * _xScaling,
      389.598 * _yScaling,
      9.14192 * _xScaling,
      379.812 * _yScaling,
    );
    path.cubicTo(
      3.48079 * _xScaling,
      370.026 * _yScaling,
      0.500288 * _xScaling,
      358.925 * _yScaling,
      0.5 * _xScaling,
      347.625 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      347.625 * _yScaling,
      0.5 * _xScaling,
      218.875 * _yScaling,
      0.5 * _xScaling,
      218.875 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      216.987 * _yScaling,
      0.586012 * _xScaling,
      215.098 * _yScaling,
      0.758011 * _xScaling,
      213.21 * _yScaling,
    );
    path.cubicTo(
      0.587679 * _xScaling,
      210.81 * _yScaling,
      0.501614 * _xScaling,
      208.406 * _yScaling,
      0.5 * _xScaling,
      206 * _yScaling,
    );
    path.cubicTo(
      0.5 * _xScaling,
      171.753 * _yScaling,
      16.9861 * _xScaling,
      141.316 * _yScaling,
      42.5537 * _xScaling,
      120.355 * _yScaling,
    );
    path.cubicTo(
      45.4777 * _xScaling,
      117.266 * _yScaling,
      48.2985 * _xScaling,
      114.33 * _yScaling,
      51.0161 * _xScaling,
      111.549 * _yScaling,
    );
    path.cubicTo(
      51.0161 * _xScaling,
      111.549 * _yScaling,
      51.0676 * _xScaling,
      111.523 * _yScaling,
      51.0676 * _xScaling,
      111.523 * _yScaling,
    );
    path.cubicTo(
      64.8189 * _xScaling,
      97.3608 * _yScaling,
      73.7973 * _xScaling,
      87.7045 * _yScaling,
      76.7901 * _xScaling,
      74.6493 * _yScaling,
    );
    path.cubicTo(
      79.0021 * _xScaling,
      65 * _yScaling,
      91.341 * _xScaling,
      65.3017 * _yScaling,
      86.9432 * _xScaling,
      57.4231 * _yScaling,
    );
    path.cubicTo(
      82.5455 * _xScaling,
      49.5446 * _yScaling,
      81.0487 * _xScaling,
      40.3785 * _yScaling,
      82.7123 * _xScaling,
      31.5139 * _yScaling,
    );
    path.cubicTo(
      84.3759 * _xScaling,
      22.6494 * _yScaling,
      89.095 * _xScaling,
      14.6454 * _yScaling,
      96.0515 * _xScaling,
      8.88943 * _yScaling,
    );
    path.cubicTo(
      103.008 * _xScaling,
      3.13351 * _yScaling,
      111.763 * _xScaling,
      -0.0113571 * _yScaling,
      120.799 * _xScaling,
      0.0000308191 * _yScaling,
    );
    path.cubicTo(
      120.799 * _xScaling,
      0.0000308191 * _yScaling,
      120.799 * _xScaling,
      0.0000308191 * _yScaling,
      120.799 * _xScaling,
      0.0000308191 * _yScaling,
    );
    // path.lineTo(68.5 * _xScaling,13 * _yScaling);
    // path.cubicTo(68.5 * _xScaling,5.8203 * _yScaling,74.3203 * _xScaling,0 * _yScaling,81.5 * _xScaling,0 * _yScaling,);
    // path.cubicTo(81.5 * _xScaling,0 * _yScaling,178.5 * _xScaling,0 * _yScaling,178.5 * _xScaling,0 * _yScaling,);
    // path.cubicTo(185.68 * _xScaling,0 * _yScaling,191.5 * _xScaling,5.8203 * _yScaling,191.5 * _xScaling,13 * _yScaling,);
    // path.cubicTo(191.5 * _xScaling,13 * _yScaling,191.5 * _xScaling,57 * _yScaling,191.5 * _xScaling,57 * _yScaling,);
    // path.cubicTo(191.5 * _xScaling,64.1797 * _yScaling,185.68 * _xScaling,70 * _yScaling,178.5 * _xScaling,70 * _yScaling,);
    // path.cubicTo(178.5 * _xScaling,70 * _yScaling,81.5 * _xScaling,70 * _yScaling,81.5 * _xScaling,70 * _yScaling,);
    // path.cubicTo(74.3203 * _xScaling,70 * _yScaling,68.5 * _xScaling,64.1797 * _yScaling,68.5 * _xScaling,57 * _yScaling,);
    // path.cubicTo(68.5 * _xScaling,57 * _yScaling,68.5 * _xScaling,13 * _yScaling,68.5 * _xScaling,13 * _yScaling,);
    // path.cubicTo(68.5 * _xScaling,13 * _yScaling,68.5 * _xScaling,13 * _yScaling,68.5 * _xScaling,13 * _yScaling,);
    path.addRRect(RRect.fromRectAndRadius(Rect.fromLTRB(_xScaling * 60, 0, 210, 80), Radius.circular(radius)));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
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
    final double xScaling = (size.width / 48).h;
    final double yScaling = (size.height / 32).h;
    path.lineTo(12.6667 * xScaling, 0.779297 * yScaling);
    path.cubicTo(
      12.6667 * xScaling,
      0.779297 * yScaling,
      13.6533 * xScaling,
      4.31263 * yScaling,
      13.6533 * xScaling,
      7.1793 * yScaling,
    );
    path.cubicTo(
      13.6533 * xScaling,
      9.92596 * yScaling,
      11.8533 * xScaling,
      12.1526 * yScaling,
      9.10667 * xScaling,
      12.1526 * yScaling,
    );
    path.cubicTo(
      6.34667 * xScaling,
      12.1526 * yScaling,
      4.26667 * xScaling,
      9.92596 * yScaling,
      4.26667 * xScaling,
      7.1793 * yScaling,
    );
    path.cubicTo(
      4.26667 * xScaling,
      7.1793 * yScaling,
      4.30667 * xScaling,
      6.6993 * yScaling,
      4.30667 * xScaling,
      6.6993 * yScaling,
    );
    path.cubicTo(
      1.61333 * xScaling,
      9.8993 * yScaling,
      0 * xScaling,
      14.046 * yScaling,
      0 * xScaling,
      18.5526 * yScaling,
    );
    path.cubicTo(
      0 * xScaling,
      24.446 * yScaling,
      4.77333 * xScaling,
      29.2193 * yScaling,
      10.6667 * xScaling,
      29.2193 * yScaling,
    );
    path.cubicTo(
      16.56 * xScaling,
      29.2193 * yScaling,
      21.3333 * xScaling,
      24.446 * yScaling,
      21.3333 * xScaling,
      18.5526 * yScaling,
    );
    path.cubicTo(
      21.3333 * xScaling,
      11.366 * yScaling,
      17.88 * xScaling,
      4.95263 * yScaling,
      12.6667 * xScaling,
      0.779297 * yScaling,
    );
    path.cubicTo(
      12.6667 * xScaling,
      0.779297 * yScaling,
      12.6667 * xScaling,
      0.779297 * yScaling,
      12.6667 * xScaling,
      0.779297 * yScaling,
    );
    return path;
  }
}
