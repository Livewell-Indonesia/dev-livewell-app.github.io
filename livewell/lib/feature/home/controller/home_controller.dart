import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/state_manager.dart';
import 'package:livewell/core/constant/constant.dart';

class HomeController extends GetxController {
  Rx<HomeTab> currentMenu = HomeTab.home.obs;

  void changePage(HomeTab tab) {
    currentMenu.value = tab;
  }
}

enum HomeTab { home, food, exercise, sleep, water, meditation, nutrition }

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
