import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_screen.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/sleep/presentation/pages/sleep_screen.dart';
import 'package:livewell/feature/water/presentation/pages/water_screen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../core/constant/constant.dart';
import '../../dashboard/presentation/pages/dashboard_screen.dart';
import '../../profile/presentation/page/user_settings_screen.dart';
import '../controller/home_controller.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
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
              marginR: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.w),
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color(0xFF8F01DF),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 0.5,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
              items: [
                DotNavigationBarItem(
                  icon: controller.currentMenu.value == HomeTab.food
                      ? controller.customSelectedImage(
                          Image.asset(
                            Constant.icFoodSelected,
                            key: controller.foodKey,
                          ),
                        )
                      : controller.customUnselectedImage(
                          Image.asset(
                            Constant.icFoodUnselected,
                            key: controller.foodKey,
                          ),
                        ),
                  selectedColor: Colors.white,
                  unselectedColor: const Color(0xFF8F01DF),
                  // selectedColor: Colors.white,
                ),
                DotNavigationBarItem(
                  icon: controller.currentMenu.value == HomeTab.home
                      ? controller.customSelectedImage(
                          Image.asset(
                            Constant.icHomeSelected,
                            key: controller.homeKey,
                          ),
                        )
                      : controller.customUnselectedImage(
                          Image.asset(
                            Constant.icHomeUnselected,
                            key: controller.homeKey,
                          ),
                        ),
                  selectedColor: Colors.white,
                  unselectedColor: const Color(0xFF8F01DF),
                  // selectedColor: Colors.white,
                ),
                DotNavigationBarItem(
                  icon: controller.currentMenu.value == HomeTab.exercise
                      ? controller.customSelectedImage(
                          Image.asset(
                            Constant.icExerciseSelected,
                            key: controller.exerciseKey,
                          ),
                        )
                      : controller.customUnselectedImage(
                          Image.asset(
                            Constant.icExerciseUnselected,
                            key: controller.exerciseKey,
                          ),
                        ),
                  selectedColor: Colors.white,
                  unselectedColor: const Color(0xFF8F01DF),
                  // selectedColor: Colors.white,
                ),
                DotNavigationBarItem(
                  icon: controller.currentMenu.value == HomeTab.sleep
                      ? controller.customSelectedImage(
                          Image.asset(
                            Constant.icSleepSelected,
                            key: controller.sleepKey,
                          ),
                        )
                      : controller.customUnselectedImage(
                          Image.asset(
                            Constant.icSleepUnselected,
                            key: controller.sleepKey,
                          ),
                        ),
                  selectedColor: Colors.white,
                  unselectedColor: const Color(0xFF8F01DF),
                  // selectedColor: Colors.white,
                ),
                DotNavigationBarItem(
                  icon: controller.currentMenu.value == HomeTab.water
                      ? controller.customSelectedImage(
                          Image.asset(
                            Constant.icWaterSelected,
                            key: controller.waterKey,
                          ),
                        )
                      : controller.customUnselectedImage(
                          Image.asset(
                            Constant.icWaterUnselected,
                            key: controller.waterKey,
                          ),
                        ),
                  selectedColor: Colors.white,
                  unselectedColor: const Color(0xFF8F01DF),
                  // selectedColor: Colors.white,
                ),
                DotNavigationBarItem(
                  icon: controller.currentMenu.value == HomeTab.account
                      ? controller.customSelectedImage(SizedBox(
                          key: controller.accountKey,
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
                      : controller.customUnselectedImage(SizedBox(
                          key: controller.accountKey,
                          width: 20.w,
                          height: 20.w,
                          child: SvgPicture.asset(
                            Constant.icHomeAccount,
                            width: 20.w,
                            height: 20.w,
                            fit: BoxFit.scaleDown,
                            color: const Color(0xFF8F01DF),
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
        return const ExerciseScreen();
      case HomeTab.meditation:
        return Container(
          color: Colors.yellow,
        );
      case HomeTab.sleep:
        return const SleepScreen();
      case HomeTab.nutrition:
        return Container(
          color: Colors.yellow,
        );
      case HomeTab.water:
        return const WaterScreen();
      case HomeTab.account:
        return UserSettingsScreen();
    }
  }
}
