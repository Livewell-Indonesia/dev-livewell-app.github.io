import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livewell/widgets/switcher/slide_switcher.dart';

class ExerciseController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<ExerciseTab> currentMenu = ExerciseTab.diaries.obs;
  late TabController tabController;
  ValueNotifier<int> sliderValueNotifier = ValueNotifier(0);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      changeTab(ExerciseTab.values[tabController.index]);
    });
  }

  void changeTab(ExerciseTab tab) {
    currentMenu.value = tab;
    tabController.index = tab.index;
    sliderValueNotifier.value = tab.index;
  }
}

enum ExerciseTab { diaries, classes }
