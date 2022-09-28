import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/widgets/chart/circular_calories.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashboardController controller = Get.put(DashboardController());
  late ValueNotifier<double> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            52.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(Constant.icAvatarPlaceholder),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Text(
                          'Hi, ${controller.user.value.firstName ?? ""}',
                          style: TextStyle(
                              color: const Color(0xFF171433),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                        );
                      }),
                      Text(
                        'Good ${controller.greeting()}',
                        style: TextStyle(
                            color: const Color(0xFF171433),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: const Color(0xFF171433).withOpacity(0.7),
                      size: 24.w,
                    ),
                  ),
                  8.horizontalSpace,
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.class_outlined,
                      color: const Color(0xFF171433).withOpacity(0.7),
                      size: 24.w,
                    ),
                  ),
                  8.horizontalSpace,
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.notifications_outlined,
                      color: const Color(0xFF171433).withOpacity(0.7),
                      size: 24.w,
                    ),
                  )
                ],
              ),
            ),
            32.verticalSpace,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16).r,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 20).r,
              decoration: BoxDecoration(
                  color: const Color(0xFF171433),
                  borderRadius: BorderRadius.circular(30.r)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Target Weight: ${controller.user.value.weightTarget ?? 0} Kg",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        "Current Weight: ${controller.user.value.weight ?? 0} Kg",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  7.verticalSpace,
                  LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    lineHeight: 7.0,
                    percent: 0.5,
                    barRadius: const Radius.circular(4.0),
                    backgroundColor: const Color(0xFFF2F1F9),
                    progressColor: const Color(0xFFDDF235),
                  )
                ],
              ),
            ),
            10.verticalSpace,
            Center(
              child: Text(
                'Keep with your plan , You are doing great!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFF171433).withOpacity(0.5),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            32.verticalSpace,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20).r,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20).r,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20).r),
              child: Column(
                children: [
                  Text(
                    'Calories',
                    style: TextStyle(
                        color: const Color(0xFF171433),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  32.verticalSpace,
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "700",
                            style: TextStyle(
                                fontSize: 24.sp,
                                color: const Color(0xFF171433),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "taken",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFF171433).withOpacity(0.6),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const Spacer(),
                      SimpleCircularProgressBar(
                        backColor: Colors.white,
                        progressColors: [const Color(0xFFDDF235)],
                        mergeMode: true,
                        backStrokeWidth: 5,
                        progressStrokeWidth: 10,
                        valueNotifier: _valueNotifier,
                        animationDuration: const Duration(seconds: 1),
                        maxValue: 1,
                        onGetText: (value) {
                          return Column(
                            children: [
                              Text(
                                "453",
                                style: TextStyle(
                                    color: const Color(0xFF171433),
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'cal left',
                                style: TextStyle(
                                    color: const Color(0xFF171433)
                                        .withOpacity(0.63),
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          );
                        },
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            "700",
                            style: TextStyle(
                                fontSize: 24.sp,
                                color: const Color(0xFF171433),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Target",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFF171433).withOpacity(0.6),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              "Carbs",
                              style: TextStyle(
                                  color: const Color(0xFF171433),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            Text(
                              "700",
                              style: TextStyle(
                                  color: const Color(0xFF171433),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              "Protein",
                              style: TextStyle(
                                  color: const Color(0xFF171433),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            Text(
                              "700",
                              style: TextStyle(
                                  color: const Color(0xFF171433),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              "Fat",
                              style: TextStyle(
                                  color: const Color(0xFF171433),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            Text(
                              "700",
                              style: TextStyle(
                                  color: const Color(0xFF171433),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            30.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).r,
              child: Text(
                "Task List",
                style: TextStyle(
                    color: Color(0xFF171433),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
