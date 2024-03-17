import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/widget/dashboard_summary_widget.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/mood/presentation/widget/mood_picker_widget.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/sleep/presentation/controller/sleep_controller.dart';
import 'package:livewell/feature/water/presentation/pages/water_custom_input_page.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashboardController controller = Get.put(DashboardController(), permanent: true);
  SleepController sleepController = Get.put(SleepController());
  int current = 0;
  final CarouselController carouselController = CarouselController();
  final HomeController homeController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: RefreshIndicator(
          onRefresh: () async {
            controller.onInit();
          },
          child: SingleChildScrollView(
            controller: homeController.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                52.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16).r,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 40.h,
                          height: 40.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Obx(() {
                            if (controller.user.value.avatarUrl != null && controller.user.value.avatarUrl!.isNotEmpty) {
                              return Image.network(
                                controller.user.value.avatarUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return SvgPicture.asset(
                                    (controller.user.value.gender ?? Gender.male.name).toLowerCase() == "male" ? Constant.imgMaleSVG : Constant.imgFemaleSVG,
                                  );
                                },
                              );
                            } else {
                              return SvgPicture.asset(
                                (controller.user.value.gender ?? Gender.male.name).toLowerCase() == "male" ? Constant.imgMaleSVG : Constant.imgFemaleSVG,
                              );
                            }
                          }),
                        ),
                      ),
                      //SvgPicture.asset(Constant.icAvatarPlaceholder),
                      10.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              'Hi ${controller.user.value.firstName ?? ""},',
                              style: TextStyle(color: const Color(0xFF171433), fontSize: 15.sp, fontWeight: FontWeight.w500),
                            );
                          }),
                          Text(
                            '${controller.localization.goodGreeting ?? ""} ${controller.greeting()}',
                            style: TextStyle(color: const Color(0xFF171433), fontSize: 24.sp, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
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
                    ],
                  ),
                ),
                32.verticalSpace,
                InkWell(
                  onTap: () {
                    AppNavigator.push(routeName: AppPages.updateWeight);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Obx(() {
                      return YourWeightWidget(
                        key: homeController.cardKey,
                        weight: (controller.user.value.weight ?? 0.0).toDouble(),
                        targetWeight: (controller.user.value.weightTarget ?? 0.0).toDouble(),
                      );
                    }),
                  ),
                ),
                32.verticalSpace,
                Obx(() {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: DashboardSummaryWidget(
                      model: [
                        DashboardSummaryModel(
                            item: DashboardSummaryItem.calories,
                            currentValue: "${controller.dashboard.value.dashboard?.caloriesTaken ?? 0}",
                            targetValue: "${(controller.user.value.bmr?.toInt() ?? 0) + (controller.totalExercise.value)}",
                            unit: 'kCal',
                            status: DashboardSummaryModel.statusFromValue(
                                (controller.dashboard.value.dashboard?.caloriesTaken ?? 0) / ((controller.user.value.bmr?.toInt() ?? 0) + (controller.totalExercise.value)), false)),
                        DashboardSummaryModel(
                            item: DashboardSummaryItem.exercise,
                            currentValue: "${controller.totalExercise.value}",
                            targetValue: '${controller.user.value.exerciseGoalKcal ?? 0}',
                            unit: 'kCal',
                            status: DashboardSummaryModel.statusFromValue((controller.totalExercise.value) / (controller.user.value.exerciseGoalKcal ?? 0), false)),
                        DashboardSummaryModel(
                            item: DashboardSummaryItem.protein,
                            currentValue: '${controller.dashboard.value.dashboard?.totalProteinInG ?? 0} ',
                            targetValue: '${controller.totalProtein().round()}',
                            unit: 'g',
                            status: DashboardSummaryModel.statusFromValue((controller.dashboard.value.dashboard?.totalProteinInG ?? 0) / (controller.totalProtein().round()), false)),
                        DashboardSummaryModel(
                            item: DashboardSummaryItem.carbs,
                            currentValue: '${controller.dashboard.value.dashboard?.totalCarbsInG ?? 0}',
                            targetValue: '${controller.totalCarbs().round()}',
                            unit: 'g',
                            status: DashboardSummaryModel.statusFromValue((controller.dashboard.value.dashboard?.totalCarbsInG ?? 0) / (controller.totalCarbs().round()), true)),
                        DashboardSummaryModel(
                            item: DashboardSummaryItem.sleep,
                            currentValue: (sleepController.finalSleepValue).toStringAsFixed(1),
                            targetValue: '${controller.user.value.onboardingQuestionnaire?.sleepDuration ?? 0}',
                            unit: "hours",
                            status: DashboardSummaryModel.statusFromValue((sleepController.finalSleepValue / int.parse(controller.user.value.onboardingQuestionnaire?.sleepDuration ?? "0")), false)),
                        DashboardSummaryModel(
                            item: DashboardSummaryItem.fat,
                            currentValue: '${controller.dashboard.value.dashboard?.totalFatsInG}',
                            targetValue: '${controller.totalFat().round()}',
                            unit: 'g',
                            status: DashboardSummaryModel.statusFromValue((controller.dashboard.value.dashboard?.totalFatsInG ?? 0) / (controller.totalFat().round()), true)),
                        DashboardSummaryModel(
                            item: DashboardSummaryItem.water,
                            currentValue: (controller.waterConsumed.value / 1000).toStringAsFixed(1),
                            targetValue: removeTrailingZero((int.parse((controller.user.value.onboardingQuestionnaire?.glassesOfWaterDaily ?? "0")) * 0.25).toString()),
                            unit: 'liters',
                            status: DashboardSummaryModel.statusFromValue(
                                (controller.waterConsumed.value / 1000) / (int.parse((controller.user.value.onboardingQuestionnaire?.glassesOfWaterDaily ?? "0")) * 0.25), false)),
                        DashboardSummaryModel(
                            item: DashboardSummaryItem.mood,
                            currentValue: '0',
                            targetValue: '0',
                            unit: '',
                            moodType: controller.getMoodTypeByValue(controller.todayMood.value?.response?.value ?? 3),
                            status: DashboardSummaryStatus.eightyPlus),
                      ],
                    ),
                  );
                }),
                24.verticalSpace,
                QuickActionRow(
                  key: homeController.navigationKey,
                  onTap: (action) {
                    switch (action) {
                      case QuickAction.nutrition:
                        // Get.find<HomeController>().currentMenu.value =
                        //     HomeTab.d;
                        AppNavigator.push(routeName: AppPages.nutritionScreen);
                        break;
                      case QuickAction.exercise:
                        AppNavigator.push(routeName: AppPages.exerciseScreen);
                        break;
                      case QuickAction.sleep:
                        AppNavigator.push(routeName: AppPages.sleepScreen);
                        break;
                      case QuickAction.water:
                        AppNavigator.push(routeName: AppPages.waterScreen);
                        break;
                      case QuickAction.mood:
                        AppNavigator.push(routeName: AppPages.moodDetailScreen);
                        break;
                      default:
                        // Handle the 'QuickAction.mood' case here
                        break;
                    }
                  },
                ),
                Obx(() {
                  return controller.user.value.dailyJournal?.isEmpty ?? true
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20).r,
                          child: Text(
                            controller.localization.taskList!,
                            style: TextStyle(color: const Color(0xFF171433), fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                        );
                }),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).r,
                  child: Obx(() {
                    return MoodPickerWidget(
                      selectedMoodType: controller.getMoodTypeByValue(controller.todayMood.value?.response?.value ?? 0),
                      onTap: (mood) {
                        controller.onMoodSelected(mood);
                      },
                    );
                  }),
                ),
                8.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).r,
                  child: Obx(() {
                    if (homeController.isShowCoachmark.value) {
                      return dummyTask();
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              AppNavigator.push(routeName: AppPages.waterConsumedPage, arguments: {"waterInputType": WaterInputType.increase});
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10.w, right: 20.w),
                              width: 335.w,
                              height: 72.h,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20).r),
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Obx(() {
                                      return Checkbox(
                                        value: controller.waterConsumed.value >= 2000,
                                        onChanged: (val) {},
                                        fillColor: MaterialStateProperty.resolveWith((states) {
                                          if (states.contains(MaterialState.selected)) {
                                            return const Color(0xFFDDF235);
                                          }
                                          return null;
                                        }),
                                        checkColor: const Color(0xFF171433),
                                        activeColor: Colors.green,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        side: const BorderSide(color: Color(0xFF171433), width: 1),
                                      );
                                    }),
                                  ),
                                  Container(
                                    width: 43.w,
                                    height: 43.w,
                                    decoration: BoxDecoration(color: const Color(0xFFF1F1F1), borderRadius: BorderRadius.circular(10.r)),
                                    child: Image.asset(Constant.icWaterUnselected),
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    'Water',
                                    style: TextStyle(color: const Color(0xFF171433).withOpacity(0.8), fontSize: 16.sp, fontWeight: FontWeight.w600),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${(controller.waterConsumed.value / 1000).toStringAsFixed(1)} L",
                                    style: TextStyle(color: const Color(0xFF171433).withOpacity(0.8), fontSize: 16.sp, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.separated(
                              padding: EdgeInsets.only(top: 10.h),
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    AppNavigator.push(routeName: AppPages.addMeal, arguments: {"type": controller.user.value.dailyJournal?[index].name, "date": DateTime.now()});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10.w, right: 20.w),
                                    width: 335.w,
                                    height: 72.h,
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20).r),
                                    child: Row(
                                      children: [
                                        Transform.scale(
                                          scale: 1.2,
                                          child: Obx(() {
                                            return Checkbox(
                                              value: controller.isCompleted(index).value,
                                              onChanged: (val) {},
                                              fillColor: MaterialStateProperty.resolveWith((states) {
                                                if (states.contains(MaterialState.selected)) {
                                                  return const Color(0xFFDDF235);
                                                }
                                                return null;
                                              }),
                                              checkColor: const Color(0xFF171433),
                                              activeColor: Colors.green,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              side: const BorderSide(color: Color(0xFF171433), width: 1),
                                            );
                                          }),
                                        ),
                                        Container(
                                          width: 43.w,
                                          height: 43.w,
                                          decoration: BoxDecoration(color: const Color(0xFFF1F1F1), borderRadius: BorderRadius.circular(10.r)),
                                          child: Image.asset(Constant.icFoodUnselected),
                                        ),
                                        10.horizontalSpace,
                                        Text(
                                          "${controller.user.value.dailyJournal?[index].time} ${MealTime.values.firstWhere((element) => element.name == controller.user.value.dailyJournal?[index].name?.toLowerCase()).text()}",
                                          style: TextStyle(color: const Color(0xFF171433).withOpacity(0.8), fontSize: 16.sp, fontWeight: FontWeight.w600),
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
                              itemCount: controller.user.value.dailyJournal?.length ?? 0),
                        ],
                      );
                    }
                  }),
                ),
                80.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell dummyTask() {
    return InkWell(
      onTap: () {},
      child: Container(
        key: homeController.taskKey,
        padding: EdgeInsets.only(left: 10.w, right: 20.w),
        width: 335.w,
        height: 72.h,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20).r),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: false,
                onChanged: (val) {},
                fillColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Color(0xFFDDF235);
                  }
                  return const Color(0xFF171433);
                }),
                checkColor: const Color(0xFF171433),
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                side: const BorderSide(color: Color(0xFF171433), width: 1),
              ),
            ),
            Container(
              width: 43.w,
              height: 43.w,
              decoration: BoxDecoration(color: const Color(0xFFF1F1F1), borderRadius: BorderRadius.circular(10.r)),
              child: Image.asset(Constant.icFoodUnselected),
            ),
            10.horizontalSpace,
            Text(
              controller.localization.addFood!,
              style: TextStyle(color: const Color(0xFF171433).withOpacity(0.8), fontSize: 16.sp, fontWeight: FontWeight.w600),
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
  }
}

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  const MyTooltip({super.key, required this.message, required this.child});

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

enum CarouselDashboard { weight }

class YourWeightWidget extends StatelessWidget {
  final double weight;
  final double targetWeight;
  const YourWeightWidget({super.key, required this.weight, required this.targetWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF171433),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Target: $targetWeight Kg',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      '${Get.find<HomeController>().localization.current ?? ""}: $weight Kg',
                      style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12.sp, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                8.verticalSpace,
                LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  lineHeight: 7.h,
                  percent: (weight / targetWeight).maxOneOrZero,
                  barRadius: const Radius.circular(100.0),
                  backgroundColor: const Color(0xFFF2F1F9),
                  progressColor: const Color(0xFFDDF235),
                ),
                8.verticalSpace,
                Text(
                  Get.find<DashboardController>().localization.keepWithOurPlan!,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
                12.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 1,
                  color: const Color(0xFF4D4A68),
                ),
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Get.find<DashboardController>().localization.seeMyProgress!,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                    12.horizontalSpace,
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12.sp,
                      color: Colors.white,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension DoubleExtension on double {
  double get maxOneOrZero {
    if (this > 1) {
      return 1;
    } else if (this < 0) {
      return 0;
    } else {
      return this;
    }
  }
}

enum QuickAction { nutrition, exercise, sleep, water, mood }

extension QuickActionExt on QuickAction {
  String title() {
    switch (this) {
      case QuickAction.exercise:
        return 'Exercise';
      case QuickAction.sleep:
        return 'Sleep';
      case QuickAction.water:
        return 'Water';
      case QuickAction.mood:
        return 'Mood';
      case QuickAction.nutrition:
        return 'Nutrition';
      default:
        return '';
    }
  }

  Image image() {
    switch (this) {
      case QuickAction.exercise:
        return Image.asset(Constant.icExerciseUnselected);
      case QuickAction.sleep:
        return Image.asset(Constant.icSleepUnselected);
      case QuickAction.water:
        return Image.asset(Constant.icWaterUnselected);
      case QuickAction.mood:
        return Image.asset(Constant.icMeditationUnselected);
      case QuickAction.nutrition:
        return Image.asset(Constant.icFoodUnselected);
      default:
        return Image.asset(Constant.icFoodUnselected);
    }
  }
}

class QuickActionRow extends StatelessWidget {
  // add on tap callback
  final Function(QuickAction) onTap;
  const QuickActionRow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: QuickAction.values.map((e) {
        return InkWell(
          onTap: () {
            onTap(e);
          },
          child: SizedBox(
            width: 48.w,
            height: 90.h,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: e.image(),
                ),
                8.verticalSpace,
                Text(
                  e.title(),
                  style: TextStyle(color: const Color(0xFF171433), fontSize: 10.sp, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

String removeTrailingZero(String string) {
  if (!string.contains('.')) {
    return string;
  }
  string = string.replaceAll(RegExp(r'0*$'), '');
  if (string.endsWith('.')) {
    string = string.substring(0, string.length - 1);
  }
  return string;
}
