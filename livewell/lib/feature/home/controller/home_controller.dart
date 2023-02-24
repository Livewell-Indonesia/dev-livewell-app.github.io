import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health/health.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_app_config.dart';
import 'package:livewell/feature/exercise/domain/usecase/post_exercise_data.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../core/base/usecase.dart';
import '../../dashboard/data/model/app_config_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<HomeTab> currentMenu = HomeTab.home.obs;

  GetAppConfig appConfig = GetAppConfig.instance();
  Rx<AppConfigModel> appConfigModel = AppConfigModel().obs;

  HealthFactory healthFactory = HealthFactory();

  GlobalKey foodKey = GlobalKey();
  GlobalKey exerciseKey = GlobalKey();
  GlobalKey sleepKey = GlobalKey();
  GlobalKey homeKey = GlobalKey();
  GlobalKey waterKey = GlobalKey();
  GlobalKey accountKey = GlobalKey();

  late TutorialCoachMark tutorialCoachMark;

  var types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_IN_BED,
  ];

  var permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  @override
  void onInit() {
    getAppConfig();
    createTutorial();
    super.onInit();
  }

  void onFinishCoachmark() async {
    await SharedPref.saveCoachmarkDashboard(false);
  }

  createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
        targets: createTargets(),
        colorShadow: Colors.black,
        textSkip: "SKIP",
        pulseEnable: false,
        paddingFocus: 0,
        opacityShadow: 0.7,
        alignSkip: Alignment.topRight,
        focusAnimationDuration: const Duration(milliseconds: 300),
        unFocusAnimationDuration: const Duration(milliseconds: 300),
        onFinish: () {
          onFinishCoachmark();
        },
        onSkip: () {
          onFinishCoachmark();
        },
        onClickTarget: (p0) {
          tutorialCoachMark.next();
        },
        onClickTargetWithTapPosition: ((p0, p1) {}));
  }

  void showCoachmark() {
    Future.delayed(const Duration(milliseconds: 300), () async {
      var showCoachmark = await SharedPref.getCoachmarkDashboard();
      if (showCoachmark) {
        tutorialCoachMark.show(context: Get.context!);
      }
    });
  }

  void getAppConfig() async {
    final result = await appConfig.call(NoParams());
    result.fold((l) {
      Log.error(l);
    }, (r) {
      appConfigModel.value = r;
    });
  }

  void changePage(HomeTab tab) {
    currentMenu.value = tab;
  }

  void changePageIndex(int index) {
    if (index == 0) {
      currentMenu.value = HomeTab.food;
    } else if (index == 1) {
      currentMenu.value = HomeTab.home;
    } else if (index == 2) {
      currentMenu.value = HomeTab.exercise;
    } else if (index == 3) {
      currentMenu.value = HomeTab.sleep;
    } else if (index == 4) {
      currentMenu.value = HomeTab.water;
    } else if (index == 5) {
      currentMenu.value = HomeTab.account;
    }
  }

  Widget customSelectedImage(Widget child) {
    return ClipOval(
      child: Material(
          color: const Color(0xFF8F01DF), // button color
          child: SizedBox(width: 40.w, height: 40.w, child: child)),
    );
  }

  Widget customUnselectedImage(Widget child) {
    return SizedBox(
      width: 40.w,
      height: 40.w,
      child: child,
    );
  }

  List<TargetFocus> createTargets() {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: 'Target 1',
        keyTarget: foodKey,
        shape: ShapeLightFocus.Circle,
        radius: 20,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Food Nutrition".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'Get detailed breakdowns and edit your food intake to meet nutritional goals.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(
                            position: 0,
                            length: 6,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.next();
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'Target 2',
        keyTarget: homeKey,
        shape: ShapeLightFocus.Circle,
        radius: 10,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Home".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'See your daily task list and current data dashboard of your nutritional intake.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(
                            position: 1,
                            length: 6,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.previous();
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                    color: const Color(0xFF808080),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.next();
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 3',
        keyTarget: exerciseKey,
        shape: ShapeLightFocus.Circle,
        radius: 10,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Exercise".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'Analyze fitness progress and track steps.'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(
                            position: 2,
                            length: 6,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.previous();
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                    color: const Color(0xFF808080),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.next();
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 4',
        keyTarget: sleepKey,
        shape: ShapeLightFocus.Circle,
        radius: 10,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sleep".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'Monitor and achieve your daily sleep goals.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(
                            position: 3,
                            length: 6,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.previous();
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                    color: const Color(0xFF808080),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.next();
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 5',
        keyTarget: waterKey,
        shape: ShapeLightFocus.Circle,
        radius: 10,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Water".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'Track daily water intake to stay hydrated.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(
                            position: 4,
                            length: 6,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.previous();
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                    color: const Color(0xFF808080),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.next();
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'Target 6',
        keyTarget: accountKey,
        shape: ShapeLightFocus.Circle,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        'Edit your user details.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF808080),
                            height: 1.3,
                            fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(
                            position: 5,
                            length: 6,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.previous();
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                    color: const Color(0xFF808080),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.finish();
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    color: const Color(0xFF8F01DF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
    return targets;
  }
}

enum HomeTab {
  home,
  food,
  exercise,
  sleep,
  water,
  meditation,
  nutrition,
  account
}

extension HomeTabIcons on HomeTab {
  String selectedAssets() {
    switch (this) {
      case HomeTab.home:
        return Constant.icHomeSelected;
      case HomeTab.food:
        return Constant.icFoodSelected;
      case HomeTab.exercise:
        return Constant.icExerciseSelected;
      case HomeTab.sleep:
        return Constant.icSleepSelected;
      case HomeTab.water:
        return Constant.icWaterSelected;
      case HomeTab.meditation:
        return Constant.icMeditationSelected;
      case HomeTab.nutrition:
        return Constant.icBloodSelected;
      case HomeTab.account:
        return Constant.icBloodSelected;
    }
  }

  String unselectedAssets() {
    switch (this) {
      case HomeTab.home:
        return Constant.icHomeUnselected;
      case HomeTab.food:
        return Constant.icFoodUnselected;
      case HomeTab.exercise:
        return Constant.icExerciseUnselected;
      case HomeTab.sleep:
        return Constant.icSleepUnselected;
      case HomeTab.water:
        return Constant.icWaterUnselected;
      case HomeTab.meditation:
        return Constant.icMeditationUnselected;
      case HomeTab.nutrition:
        return Constant.icBloodUnselected;
      case HomeTab.account:
        return Constant.icBloodUnselected;
    }
  }

  Widget unselectedImage() {
    return Image.asset(
      unselectedAssets(),
      width: 40.w,
      height: 40.w,
    );
  }

  Widget selectedImage() {
    return ClipOval(
      child: Material(
          color: const Color(0xFF8F01DF), // button color
          child: Image.asset(selectedAssets(), width: 40.w, height: 40.w)),
    );
  }
}
