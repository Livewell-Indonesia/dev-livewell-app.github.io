import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health/health.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/core/notification/firebase_notification.dart';
import 'package:livewell/feature/dashboard/data/model/popup_assets_model.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_app_config.dart';
import 'package:livewell/feature/dashboard/domain/usecase/get_popup_assets.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../core/base/usecase.dart';
import '../../dashboard/data/model/app_config_model.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  Rx<HomeTab> currentMenu = HomeTab.home.obs;

  GetAppConfig appConfig = GetAppConfig.instance();
  GetPopupAssets popupAssets = GetPopupAssets.instance();
  Rx<AppConfigModel> appConfigModel = AppConfigModel().obs;
  Rx<PopupAssetsModel> popupAssetsModel = PopupAssetsModel().obs;

  GlobalKey cardKey = GlobalKey();
  GlobalKey taskKey = GlobalKey();
  GlobalKey navigationKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  GlobalKey? nutricoKey = GlobalKey();
  GlobalKey? taskRecommendationKey = GlobalKey();
  GlobalKey? wellnessScoreWidgetKey = GlobalKey();
  GlobalKey? finishTaskRecommendationKey = GlobalKey();

  late TutorialCoachMark tutorialCoachMark;

  Rx<bool> isShowCoachmark = false.obs;

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
    getPopupAsset();
    createTutorial();
    LivewellNotification().handleTermintated();
    receiveNotification();
    super.onInit();
  }

  void receiveNotification() {
    if (Get.parameters['page']?.toLowerCase() == 'dashboard') {
      currentMenu.value = HomeTab.home;
      Future.delayed(const Duration(seconds: 2), () {
        if (Get.parameters['scrollTo'] != null) {
          scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        }
      });
    }
    // else if (Get.parameters['type']?.toLowerCase() == 'diary') {
    //   currentMenu.value = HomeTab.nutricoPlus;
    // }
    else if (Get.parameters['type']?.toLowerCase() == 'account') {
      currentMenu.value = HomeTab.account;
    }
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
          isShowCoachmark.value = false;
          onFinishCoachmark();
        },
        onSkip: () {
          isShowCoachmark.value = false;
          onFinishCoachmark();
          return true;
        },
        onClickTarget: (p0) {
          if (p0.keyTarget == cardKey) {
            scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn).then((value) {
              tutorialCoachMark.next();
            });
          } else {
            tutorialCoachMark.next();
          }
        },
        onClickTargetWithTapPosition: ((p0, p1) {}));
  }

  void showCoachmark() {
    Future.delayed(const Duration(milliseconds: 300), () async {
      var showCoachmark = await SharedPref.getCoachmarkDashboard();
      if (showCoachmark) {
        isShowCoachmark.value = true;
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

  void getPopupAsset() async {
    final result = await popupAssets.call(NoParams());
    result.fold((l) {
      Log.error(l);
    }, (r) {
      popupAssetsModel.value = r;
    });
  }

  void changePage(HomeTab tab) {
    currentMenu.value = tab;
  }

  void changePageIndex(int index) {
    if (!isShowCoachmark.value) {
      if (index == 0) {
        currentMenu.value = HomeTab.home;
      } else if (index == 1) {
        currentMenu.value = HomeTab.account;
      }
      //  else if (index == 3) {
      //   currentMenu.value = HomeTab.acc;
      // } else if (index == 4) {
      //   currentMenu.value = HomeTab.water;
      // } else if (index == 5) {
      //   currentMenu.value = HomeTab.account;
      // }
    }
  }

  Widget customSelectedImage(Widget child) {
    return Material(
        color: Colors.white, // button color
        child: SizedBox(width: 40.w, height: 40.w, child: child));
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
        keyTarget: cardKey,
        shape: ShapeLightFocus.RRect,
        radius: 24,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.seeYourProgress ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        localization.viewYourNutriscore ?? "",
                        style: TextStyle(fontWeight: FontWeight.w400, color: const Color(0xFF808080), height: 1.3, fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(
                            position: 0,
                            length: 3,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn).then((value) {
                                  tutorialCoachMark.next();
                                });
                              },
                              child: Text(
                                localization.next ?? "",
                                style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 12.sp, fontWeight: FontWeight.w600),
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
        keyTarget: navigationKey,
        shape: ShapeLightFocus.RRect,
        radius: 30,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.wellnessHub ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        localization.exploreYourPersonalHealth ?? "",
                        style: TextStyle(fontWeight: FontWeight.w400, color: const Color(0xFF808080), height: 1.3, fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(
                            position: 1,
                            length: 3,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.previous();
                              },
                              child: Text(
                                localization.prev ?? "",
                                style: TextStyle(color: const Color(0xFF808080), fontSize: 12.sp, fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.next();
                              },
                              child: Text(
                                localization.next ?? "",
                                style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 12.sp, fontWeight: FontWeight.w600),
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
        keyTarget: taskKey,
        shape: ShapeLightFocus.RRect,
        radius: 20,
        color: Colors.black,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.logYourFirstMeal ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16.sp),
                      ),
                      4.verticalSpace,
                      Text(
                        localization.toLogYourFirstMealSimply ?? "",
                        style: TextStyle(fontWeight: FontWeight.w400, color: const Color(0xFF808080), height: 1.3, fontSize: 14.sp),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          const CoachmarkIndicator(
                            position: 2,
                            length: 3,
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.previous();
                              },
                              child: Text(
                                localization.prev ?? "",
                                style: TextStyle(color: const Color(0xFF808080), fontSize: 12.sp, fontWeight: FontWeight.w600),
                              )),
                          24.horizontalSpace,
                          InkWell(
                              onTap: () {
                                tutorialCoachMark.finish();
                              },
                              child: Text(
                                localization.done!,
                                style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 12.sp, fontWeight: FontWeight.w600),
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
  //nutricoPlus,

  account
}

extension HomeTabIcons on HomeTab {
  String selectedAssets() {
    switch (this) {
      case HomeTab.home:
        return Constant.icHomeUnselected;
      // case HomeTab.nutricoPlus:
      //   return Constant.icFoodSelected;
      // case HomeTab.exercise:
      //   return Constant.icExerciseSelected;
      // case HomeTab.sleep:
      //   return Constant.icSleepSelected;
      // case HomeTab.water:
      //   return Constant.icWaterSelected;
      // case HomeTab.meditation:
      //   return Constant.icMeditationSelected;
      // case HomeTab.nutrition:
      //   return Constant.icBloodSelected;
      case HomeTab.account:
        return Constant.icBloodSelected;
    }
  }

  String title() {
    switch (this) {
      case HomeTab.home:
        return "Home";
      // case HomeTab.exercise:
      //   return localization.exercise;
      // case HomeTab.sleep:
      //   return localization.sleep;
      // case HomeTab.water:
      //   return localization.water;
      // case HomeTab.meditation:
      //   return localization.meditation;
      // case HomeTab.nutrition:
      //   return localization.nutrition;
      case HomeTab.account:
        return "Account";
    }
  }

  String unselectedAssets() {
    switch (this) {
      case HomeTab.home:
        return Constant.icHomeSelected;
      // case HomeTab.exercise:
      //   return Constant.icExerciseUnselected;
      // case HomeTab.sleep:
      //   return Constant.icSleepUnselected;
      // case HomeTab.water:
      //   return Constant.icWaterUnselected;
      // case HomeTab.meditation:
      //   return Constant.icMeditationUnselected;
      // case HomeTab.nutrition:
      //   return Constant.icBloodUnselected;
      case HomeTab.account:
        return Constant.icAccountSetting;
    }
  }

  Widget unselectedAssetWidget() {
    switch (this) {
      case HomeTab.home:
        return SizedBox(
          width: 24.w,
          height: 24.w,
          child: SvgPicture.asset(
            Constant.home,
            width: 24.w,
            height: 24.w,
            fit: BoxFit.scaleDown,
            color: const Color(0xFF171433).withOpacity(0.8),
          ),
        );
      // case HomeTab.nutricoPlus:
      //   return SizedBox(
      //     width: 48.w,
      //     height: 48.w,
      //     child: SvgPicture.asset(
      //       Constant.dailyJournal,
      //       width: 48.w,
      //       height: 48.w,
      //       fit: BoxFit.scaleDown,
      //       color: const Color(0xFF171433).withOpacity(0.8),
      //     ),
      //   );
      case HomeTab.account:
        return SizedBox(
          width: 24.w,
          height: 24.w,
          child: SvgPicture.asset(
            Constant.accountCircle,
            width: 24.w,
            height: 24.w,
            fit: BoxFit.scaleDown,
            color: const Color(0xFF171433).withOpacity(0.8),
          ),
        );
    }
  }

  Widget selectedAssetWidget() {
    switch (this) {
      case HomeTab.home:
        return SizedBox(
          width: 24.w,
          height: 24.w,
          child: SvgPicture.asset(
            Constant.home,
            width: 24.w,
            height: 24.w,
            fit: BoxFit.scaleDown,
            color: const Color(0xFF8F01DF),
          ),
        );
      // case HomeTab.nutricoPlus:
      //   return SizedBox(
      //     width: 24.w,
      //     height: 24.w,
      //     child: SvgPicture.asset(
      //       Constant.dailyJournal,
      //       width: 24.w,
      //       height: 24.w,
      //       fit: BoxFit.scaleDown,
      //       color: const Color(0xFF8F01DF),
      //     ),
      //   );
      case HomeTab.account:
        return SizedBox(
          width: 24.w,
          height: 24.w,
          child: SvgPicture.asset(
            Constant.accountCircle,
            width: 24.w,
            height: 24.w,
            fit: BoxFit.scaleDown,
            color: const Color(0xFF8F01DF),
          ),
        );
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
