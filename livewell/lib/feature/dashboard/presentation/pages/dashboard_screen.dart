import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/dashboard/presentation/controller/extension/dashboard_task_card_controller.dart';
import 'package:livewell/feature/dashboard/presentation/enums/dashboard_coachmark_type.dart';
import 'package:livewell/feature/dashboard/presentation/enums/task_card_type.dart';
import 'package:livewell/feature/dashboard/presentation/widget/dashboard_summary_widget.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card/task_card.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card/task_card_finish_widget.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card/task_card_loading_widget.dart';
import 'package:livewell/feature/dashboard/presentation/widget/task_card/task_card_widget.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/mood/presentation/widget/mood_picker_widget.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/sleep/presentation/controller/sleep_controller.dart';
import 'package:livewell/feature/streak/presentation/pages/streak_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with WidgetsBindingObserver {
  DashboardController controller = Get.put(DashboardController(), permanent: true);
  SleepController sleepController = Get.put(SleepController());
  int current = 0;
  final carousel.CarouselController carouselController = carousel.CarouselController();
  final HomeController homeController = Get.find();
  final cardSwiperController = CardSwiperController();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    controller.trackEvent(LivewellHomepageEvent.homepage);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && Get.currentRoute == AppPages.home) {
      if (kReleaseMode) {
        controller.onRefresh();
      }
    }
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
            Get.snackbar("Health Data Syncing", "Health data syncing may take some time. We appreciate your patience!", duration: const Duration(seconds: 7));
            controller.onInit();
            sleepController.onInit();
          },
          child: SingleChildScrollView(
            controller: homeController.scrollController,
            child: Stack(
              children: [
                Container(
                  height: 226.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFddf235),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    52.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16).r,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.trackEvent(LivewellHomepageEvent.profileButton);
                              Get.find<HomeController>().currentMenu.value = HomeTab.account;
                            },
                            child: ClipOval(
                              child: Container(
                                width: 40.h,
                                height: 40.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),
                                child: Obx(() {
                                  if (controller.user.value.avatarUrl != null && controller.user.value.avatarUrl!.isNotEmpty) {
                                    return CachedNetworkImage(
                                      imageUrl: controller.user.value.avatarUrl!,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
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
                                controller.greeting(),
                                style: TextStyle(color: const Color(0xFF171433), fontSize: 24.sp, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const Spacer(),
                          8.horizontalSpace,
                          InkWell(
                            onTap: () {
                              controller.trackEvent(LivewellHomepageEvent.journalButton);
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
                    24.verticalSpace,
                    InkWell(
                      onTap: () {
                        controller.trackEvent(LivewellHomepageEvent.streakButton);
                        AppNavigator.push(routeName: AppPages.streakPage);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            ClipPath(
                              clipper: LivewellClipperSmall(),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                color: Theme.of(context).colorScheme.disabled,
                                width: 48.w,
                                height: 32.h,
                                child: Obx(() {
                                  return Container(
                                      alignment: Alignment.bottomCenter, color: Theme.of(context).colorScheme.primaryPurple, width: 48.w, height: calculateHeight(controller.todayProgress.value));
                                }),
                              ),
                            ),
                            Obx(() {
                              return Text(
                                controller.streakDescription.value,
                                style: TextStyle(
                                  color: const Color(0xFF505050),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }),
                            const Spacer(),
                            Obx(() {
                              return Text(
                                '${controller.numberOfStreaks.value}${Get.find<DashboardController>().localization.homePage?.dayStreak ?? "day streak"}',
                                style: TextStyle(
                                  color: const Color(0xFF808080),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                    Obx(() {
                      if (controller.isShowCoachmark.value) {
                        if (controller.coachmarkType.value == DashboardCoachmarkType.taskRecommendation) {
                          return SizedBox(
                            height: 180.h,
                            child: DummyTaskCard(
                              taskCardModel: TaskCardModel(
                                  title: 'Nutrient-Rich Breakfast ',
                                  description:
                                      'Begin by drinking a full glass of water (around 250-300 ml) to rehydrate after a night of sleep. This will help kickstart your metabolism and refresh your body.  ',
                                  type: TaskCardType.none),
                            ),
                          );
                        } else if (controller.coachmarkType.value == DashboardCoachmarkType.finishTaskRecommendation) {
                          return const DummyTaskCardFinishWidget();
                        } else {
                          return const SizedBox();
                        }
                      } else {
                        if (controller.isLoadingTaskRecommendation.value) {
                          return const TaskCardLoadingWidget();
                        } else if (controller.showDoneRecommendation.value) {
                          return TaskCardFinishWidget(onTap: () {
                            AppNavigator.push(routeName: AppPages.wellnessScore);
                          });
                        } else if (controller.taskCardModel.isNotEmpty) {
                          return Container(
                              height: 200.h,
                              padding: EdgeInsets.only(top: 16.h),
                              child: Obx(() {
                                return CardSwiper(
                                    controller: cardSwiperController,
                                    padding: EdgeInsets.zero,
                                    backCardOffset: const Offset(0, 20),
                                    threshold: 40,
                                    isLoop: false,
                                    onSwipe: (previousIndex, currentIndex, direction) {
                                      if (previousIndex == controller.taskCardModel.length - 1) {
                                        controller.onDoneTap();
                                      }
                                      return true;
                                    },
                                    allowedSwipeDirection: const AllowedSwipeDirection.symmetric(horizontal: true, vertical: false),
                                    cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                                      return InkWell(
                                        onTap: () {
                                          controller.taskCardModel[index].type.navigation();
                                        },
                                        child: TaskCard(
                                          taskCardModel: controller.taskCardModel[index],
                                          index: index,
                                          totalLength: controller.taskCardModel.length,
                                          onNextTap: () {
                                            cardSwiperController.swipe(CardSwiperDirection.left);
                                          },
                                          onPrevTap: () {
                                            cardSwiperController.undo();
                                          },
                                          onDoneTap: () {
                                            controller.onDoneTap();
                                          },
                                        ),
                                      );
                                    },
                                    cardsCount: controller.taskCardModel.length);
                              }));
                        } else {
                          return const SizedBox();
                        }
                      }
                    }),
                    16.verticalSpace,
                    Obx(() {
                      return WellnessScoreWidget(
                        score: controller.wellnessScore.value,
                        onTap: () {
                          controller.trackEvent(LivewellHomepageEvent.wellnessScoreSeeDetailButton);
                          AppNavigator.push(routeName: AppPages.wellnessScore);
                        },
                      );
                    }),
                    16.verticalSpace,
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
                                status:
                                    DashboardSummaryModel.statusFromValue((sleepController.finalSleepValue / int.parse(controller.user.value.onboardingQuestionnaire?.sleepDuration ?? "0")), false)),
                            DashboardSummaryModel(
                                item: DashboardSummaryItem.protein,
                                currentValue: '${controller.dashboard.value.dashboard?.totalProteinInG ?? 0} ',
                                targetValue: '${controller.totalProtein().round()}',
                                unit: 'g',
                                status: DashboardSummaryModel.statusFromValue((controller.dashboard.value.dashboard?.totalProteinInG ?? 0) / (controller.totalProtein().round()), false)),
                            DashboardSummaryModel(
                                item: DashboardSummaryItem.water,
                                currentValue: (controller.waterConsumed.value / 1000).toStringAsFixed(1),
                                targetValue: removeTrailingZero((int.parse((controller.user.value.onboardingQuestionnaire?.glassesOfWaterDaily ?? "0")) * 0.25).toString()),
                                unit: 'liters',
                                status: DashboardSummaryModel.statusFromValue(
                                    (controller.waterConsumed.value / 1000) / (int.parse((controller.user.value.onboardingQuestionnaire?.glassesOfWaterDaily ?? "0")) * 0.25), false)),
                            DashboardSummaryModel(
                                item: DashboardSummaryItem.fat,
                                currentValue: '${controller.dashboard.value.dashboard?.totalFatsInG}',
                                targetValue: '${controller.totalFat().round()}',
                                unit: 'g',
                                status: DashboardSummaryModel.statusFromValue((controller.dashboard.value.dashboard?.totalFatsInG ?? 0) / (controller.totalFat().round()), true)),
                            DashboardSummaryModel(
                                item: DashboardSummaryItem.mood,
                                currentValue: '0',
                                targetValue: '0',
                                unit: '',
                                moodType: MoodTypeExt.getMoodTypeByValue(controller.todayMood.value?.response?.value ?? 3),
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
                            controller.trackEvent(LivewellHomepageEvent.nutritionButton);
                            AppNavigator.push(routeName: AppPages.nutritionScreen);
                            break;
                          case QuickAction.exercise:
                            controller.trackEvent(LivewellHomepageEvent.exerciseButton);
                            AppNavigator.push(routeName: AppPages.exerciseScreen);
                            break;
                          case QuickAction.sleep:
                            controller.trackEvent(LivewellHomepageEvent.sleepButton);
                            AppNavigator.push(routeName: AppPages.sleepScreen);
                            break;
                          case QuickAction.water:
                            controller.trackEvent(LivewellHomepageEvent.waterButton);
                            AppNavigator.push(routeName: AppPages.waterScreen);
                            break;
                          case QuickAction.mood:
                            controller.trackEvent(LivewellHomepageEvent.moodButton);
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
                                controller.localization.homePage?.taskList ?? "Task List",
                                style: TextStyle(color: const Color(0xFF171433), fontSize: 20.sp, fontWeight: FontWeight.w600),
                              ),
                            );
                    }),
                    20.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20).r,
                      child: Obx(() {
                        return MoodPickerWidget(
                          selectedMoodType: MoodTypeExt.getMoodTypeByValue(controller.todayMood.value?.response?.value ?? 0),
                          onTap: (mood) {
                            controller.trackEvent(LivewellHomepageEvent.moodButton, properties: {"mood": mood.title()});
                            controller.onMoodSelected(mood);
                          },
                        );
                      }),
                    ),
                    8.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20).r,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.trackEvent(LivewellHomepageEvent.taskListWaterButton);
                              AppNavigator.push(routeName: AppPages.waterScreen);
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
                                    child: Obx(
                                      () {
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
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 43.w,
                                    height: 43.w,
                                    decoration: BoxDecoration(color: const Color(0xFFF1F1F1), borderRadius: BorderRadius.circular(10.r)),
                                    child: Image.asset(Constant.icWaterUnselected),
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    Get.find<DashboardController>().localization.homePage?.water ?? 'Water',
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
                          Obx(() {
                            return ListView.separated(
                                padding: EdgeInsets.only(top: 10.h),
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (controller.user.value.dailyJournal?[index].name?.toLowerCase() == "breakfast") {
                                        controller.trackEvent(LivewellHomepageEvent.taskListBreakfastButton);
                                      } else if (controller.user.value.dailyJournal?[index].name?.toLowerCase() == "lunch") {
                                        controller.trackEvent(LivewellHomepageEvent.taskListLunchButton);
                                      } else if (controller.user.value.dailyJournal?[index].name?.toLowerCase() == "dinner") {
                                        controller.trackEvent(LivewellHomepageEvent.taskListDinnerButton);
                                      } else if (controller.user.value.dailyJournal?[index].name?.toLowerCase() == "snack") {
                                        controller.trackEvent(LivewellHomepageEvent.taskListSnackButton);
                                      }
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
                                itemCount: controller.user.value.dailyJournal?.length ?? 0);
                          })
                        ],
                      ),
                    ),
                    80.verticalSpace,
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
      return 32.h;
    } else {
      return 32.h * (todayProgress / 5);
    }
  }
}

class WellnessScoreWidget extends StatelessWidget {
  final int score;
  final VoidCallback? onTap;
  final String title = 'Your wellness score is a measure of how well you are doing in all areas of your health.';

  const WellnessScoreWidget({
    super.key,
    required this.score,
    this.onTap,
  });

  String getTitle(int score) {
    if (score <= 50) {
      return Get.find<DashboardController>().localization.homePage?.checkTheAppToSeeWhatYouNeedToImprove ?? 'Check the app to see what you need to improve.';
    } else if (score <= 80) {
      return Get.find<DashboardController>().localization.homePage?.seeTheAppForAreasToImprove ?? 'See the app for areas to improve.';
    } else {
      return Get.find<DashboardController>().localization.homePage?.greatJobKeepUpTheGoodWork ?? 'Great job! Keep up the good work.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        key: Get.find<HomeController>().wellnessScoreWidgetKey,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: const Color(0xFFDDF235).withOpacity(0.35),
              ),
              child: Column(
                children: [
                  Text(
                    score.toString(),
                    style: TextStyle(color: const Color(0xFF505050), fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '/100',
                    style: TextStyle(color: const Color(0xFF505050), fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Get.find<DashboardController>().localization.homePage?.wellness ?? 'Wellness',
                    style: TextStyle(
                      color: const Color(0xFF505050),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    getTitle(score),
                    style: TextStyle(
                      color: const Color(0xFF808080),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            12.horizontalSpace,
            (onTap == null)
                ? const SizedBox()
                : InkWell(
                    onTap: () {
                      onTap!();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF8F01DF)),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        'View Insights',
                        style: TextStyle(
                          color: const Color(0xFF8F01DF),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
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
        return Get.find<DashboardController>().localization.homePage?.exercise ?? 'Exercise';
      case QuickAction.sleep:
        return Get.find<DashboardController>().localization.homePage?.sleep ?? 'Sleep';
      case QuickAction.water:
        return Get.find<DashboardController>().localization.homePage?.water ?? 'Water';
      case QuickAction.mood:
        return Get.find<DashboardController>().localization.homePage?.mood ?? 'Mood';
      case QuickAction.nutrition:
        return Get.find<DashboardController>().localization.homePage?.nutrition ?? 'Nutrition';
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
                  textAlign: TextAlign.center,
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
