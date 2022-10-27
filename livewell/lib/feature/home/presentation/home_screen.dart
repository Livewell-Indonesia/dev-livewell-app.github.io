import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/profile/presentation/page/account_settings_screen.dart';

import '../../../core/constant/constant.dart';
import '../../dashboard/presentation/pages/dashboard_screen.dart';
import '../../profile/presentation/page/user_settings_screen.dart';
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
                controller.changePageIndex(p0);
              },
              itemPadding: EdgeInsets.zero,
              // itemPadding:
              //     const EdgeInsets.symmetric(horizontal: 4, vertical: 10).r,
              marginR: EdgeInsets.symmetric(horizontal: 100.w, vertical: 20.w),
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color(0xFF8F01DF),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black,
              //     blurRadius: 0.5,
              //     offset: Offset(0, 0), // changes position of shadow
              //   ),
              // ],
              items: [
                DotNavigationBarItem(
                  icon: controller.currentMenu.value == HomeTab.food
                      ? controller.customSelectedImage(
                          Image.asset(Constant.icFoodSelected),
                        )
                      : controller.customUnselectedImage(
                          Image.asset(Constant.icFoodUnselected),
                        ),
                  selectedColor: Colors.white,
                  unselectedColor: const Color(0xFF8F01DF),
                  // selectedColor: Colors.white,
                ),
                DotNavigationBarItem(
                  icon: controller.currentMenu.value == HomeTab.home
                      ? controller.customSelectedImage(
                          Image.asset(Constant.icHomeSelected),
                        )
                      : controller.customUnselectedImage(
                          Image.asset(Constant.icHomeUnselected),
                        ),
                  selectedColor: Colors.white,
                  unselectedColor: const Color(0xFF8F01DF),
                  // selectedColor: Colors.white,
                ),
                DotNavigationBarItem(
                  icon: controller.currentMenu.value == HomeTab.account
                      ? controller.customSelectedImage(Container(
                          width: 20.w,
                          height: 20.w,
                          child: SvgPicture.asset(
                            Constant.icHomeAccount,
                            width: 20.w,
                            height: 20.w,
                            fit: BoxFit.scaleDown,
                            color: Colors.white,
                          ),
                        ))
                      : controller.customUnselectedImage(Container(
                          width: 20.w,
                          height: 20.w,
                          child: SvgPicture.asset(
                            Constant.icHomeAccount,
                            width: 20.w,
                            height: 20.w,
                            fit: BoxFit.scaleDown,
                            color: Color(0xFF8F01DF),
                          ),
                        )),
                  selectedColor: Colors.white,
                  unselectedColor: const Color(0xFF8F01DF),
                  // selectedColor: Colors.white,
                ),
              ]
              // items: HomeTab.values.map((e) {
              //   return DotNavigationBarItem(
              //     icon: controller.currentMenu.value == e
              //         ? e.selectedImage()
              //         : e.unselectedImage(),
              //     selectedColor: Colors.white,
              //     unselectedColor: const Color(0xFF8F01DF),
              //   );
              // }).toList(),
              );
        }));
  }

  Widget selectBody() {
    switch (controller.currentMenu.value) {
      case HomeTab.home:
        return const DashBoardScreen();
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
      case HomeTab.account:
        return UserSettingsScreen();
    }
  }
}
