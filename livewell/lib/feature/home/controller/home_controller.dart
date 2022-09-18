import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  Rx<HomeTab> currentMenu = HomeTab.home.obs;
}

enum HomeTab { home, food, exercise, sleep, water, meditation, nutrition }

extension HomeTabIcons on HomeTab {
  Icon getIcons() {
    switch (this) {
      case HomeTab.home:
        return const Icon(Icons.home);
      case HomeTab.food:
        return const Icon(Icons.local_dining);
      case HomeTab.exercise:
        return Icon(Icons.fitness_center);
      case HomeTab.sleep:
        return Icon(Icons.local_hotel);
      case HomeTab.water:
        return Icon(Icons.local_drink);
      case HomeTab.meditation:
        return Icon(Icons.local_activity);
      case HomeTab.nutrition:
        return Icon(Icons.local_airport);
    }
  }
}
