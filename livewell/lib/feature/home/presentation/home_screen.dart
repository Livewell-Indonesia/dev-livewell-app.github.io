import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';

import '../../dashboard/presentation/pages/dashboard_screen.dart';
import '../controller/home_controller.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeController controller = Get.put(HomeController());
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Obx(() {
          return selectBody();
        }),
        bottomNavigationBar: Obx(() {
          return DotNavigationBar(
            currentIndex: controller.currentMenu.value.index,
            dotIndicatorColor: Colors.transparent,
            onTap: (p0) {
              controller.changePage(HomeTab.values[p0]);
            },
            itemPadding: EdgeInsets.zero,
            // itemPadding:
            //     const EdgeInsets.symmetric(horizontal: 4, vertical: 10).r,
            marginR: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
            selectedItemColor: Colors.white,
            unselectedItemColor: const Color(0xFF8F01DF),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black,
            //     blurRadius: 0.5,
            //     offset: Offset(0, 0), // changes position of shadow
            //   ),
            // ],
            items: HomeTab.values.map((e) {
              return DotNavigationBarItem(
                icon: controller.currentMenu.value == e
                    ? e.selectedImage()
                    : e.unselectedImage(),
                selectedColor: Colors.white,
                unselectedColor: Color(0xFF8F01DF),
              );
            }).toList(),
          );
        }));
  }

  Widget selectBody() {
    switch (controller.currentMenu.value) {
      case HomeTab.home:
        return DashBoardScreen();
      case HomeTab.food:
        return FoodScreen();
      case HomeTab.exercise:
        return Container(
          color: Colors.green,
        );
      case HomeTab.meditation:
        return Container(
          color: Colors.yellow,
        );
      case HomeTab.sleep:
        return Container(
          color: Colors.yellow,
        );
      case HomeTab.nutrition:
        return Container(
          color: Colors.yellow,
        );
      case HomeTab.water:
        return Container(
          color: Colors.yellow,
        );
    }
  }
}
