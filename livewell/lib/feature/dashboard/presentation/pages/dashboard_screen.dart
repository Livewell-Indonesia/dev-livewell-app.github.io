import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/update_weight/presentation/page/update_weight_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/chart/circular_calories.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashboardController controller = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.onInit();
        },
        child: SingleChildScrollView(
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
                      onTap: () {
                        //AppNavigator.push(routeName: AppPages.profile);
                        HomeController homeController = Get.find();
                        homeController.currentMenu.value = HomeTab.account;
                      },
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: const Color(0xFF171433).withOpacity(0.7),
                        size: 24.w,
                      ),
                    ),
                    8.horizontalSpace,
                    InkWell(
                      onTap: () {
                        Get.to(() => UserDiaryScreen());
                      },
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
              InkWell(
                onTap: () {
                  AppNavigator.push(routeName: AppPages.updateWeight);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16).r,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20)
                          .r,
                  decoration: BoxDecoration(
                      color: const Color(0xFF171433),
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(() {
                            return Text(
                              "Target Weight: ${controller.user.value.weightTarget ?? 0} Kg",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            );
                          }),
                          const Spacer(),
                          Obx(() {
                            return Text(
                              "Current Weight: ${controller.user.value.weight ?? 0} Kg",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            );
                          })
                        ],
                      ),
                      7.verticalSpace,
                      Obx(() {
                        return LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          lineHeight: 7.0,
                          percent: controller.getWeightPercentage().value,
                          barRadius: const Radius.circular(4.0),
                          backgroundColor: const Color(0xFFF2F1F9),
                          progressColor: const Color(0xFFDDF235),
                        );
                      })
                    ],
                  ),
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
              10.verticalSpace,
              Center(child: Obx(() {
                return Text(
                  'Your goal: ${controller.user.value.onboardingQuestionnaire?.targetImprovement?.first ?? []}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color(0xFF171433).withOpacity(0.5),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                );
              })),
              32.verticalSpace,
              InkWell(
                onTap: () {
                  Get.find<HomeController>().currentMenu.value = HomeTab.food;
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20).r,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                          .r,
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
                      Obx(() {
                        return Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Text(
                                    "${controller.dashboard.value.dashboard?.caloriesTaken ?? 0}",
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        color: const Color(0xFF171433),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Eaten",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF171433)
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 4,
                              child: SimpleCircularProgressBar(
                                backColor: Colors.white,
                                progressColors: [const Color(0xFFDDF235)],
                                mergeMode: true,
                                backStrokeWidth: 5,
                                progressStrokeWidth: 10,
                                valueNotifier: controller.valueNotifier,
                                animationDuration: const Duration(seconds: 1),
                                maxValue: 1,
                                onGetText: (value) {
                                  return Column(
                                    children: [
                                      Text(
                                        controller.remainingCalToShow().value,
                                        style: TextStyle(
                                            color: const Color(0xFF171433),
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Remaining',
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
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 2,
                              child: MyTooltip(
                                message:
                                    "Basal Metabolic Rate (BMR) is the number of calories you burn as your body performs basic (basal) life-sustaining function, such as breathing, circulation, nutrient processing and cell production.",
                                child: Column(
                                  children: [
                                    Text(
                                      "${controller.dashboard.value.dashboard?.target ?? 0}",
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          color: const Color(0xFF171433),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "BMR",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color(0xFF171433)
                                              .withOpacity(0.6),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      20.verticalSpace,
                      Obx(() {
                        return Row(
                          children: [
                            Expanded(
                              flex: 4,
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
                                    "${controller.dashboard.value.dashboard?.totalCarbsInG ?? 0} / ${controller.totalCarbs().round()} g",
                                    maxLines: 1,
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
                              flex: 4,
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
                                    "${controller.dashboard.value.dashboard?.totalProteinInG ?? 0} / ${controller.totalProtein().round()} g",
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
                              flex: 4,
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
                                    "${controller.dashboard.value.dashboard?.totalFatsInG ?? 0} / ${controller.totalFat().round()} g",
                                    style: TextStyle(
                                        color: const Color(0xFF171433),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ),
              30.verticalSpace,
              Obx(() {
                return controller.user.value.dailyJournal?.isEmpty ?? true
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20).r,
                        child: Text(
                          "Task List",
                          style: TextStyle(
                              color: const Color(0xFF171433),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).r,
                child: Obx(() {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            AppNavigator.push(
                                routeName: AppPages.addMeal,
                                arguments: {
                                  "type": controller
                                      .user.value.dailyJournal?[index].name,
                                  "date": DateTime.now()
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10.w, right: 20.w),
                            width: 335.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20).r),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Obx(() {
                                    return Checkbox(
                                      value:
                                          controller.isCompleted(index).value,
                                      onChanged: (val) {},
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return const Color(0xFFDDF235);
                                        }
                                        return const Color(0xFF171433);
                                      }),
                                      checkColor: const Color(0xFF171433),
                                      activeColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      side: const BorderSide(
                                          color: const Color(0xFF171433),
                                          width: 1),
                                    );
                                  }),
                                ),
                                Container(
                                  width: 43.w,
                                  height: 43.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF1F1F1),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Image.asset(Constant.icFoodUnselected),
                                ),
                                10.horizontalSpace,
                                Text(
                                  "${controller.user.value.dailyJournal?[index].time} ${controller.user.value.dailyJournal?[index].name}",
                                  style: TextStyle(
                                      color: const Color(0xFF171433)
                                          .withOpacity(0.8),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20.r,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return 10.verticalSpace;
                      },
                      itemCount:
                          controller.user.value.dailyJournal?.length ?? 0);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  MyTooltip({required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.r),
      key: key,
      message: message,
      triggerMode: TooltipTriggerMode.tap,
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
