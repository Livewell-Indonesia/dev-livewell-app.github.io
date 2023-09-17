import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/daily_journal/presentation/page/daily_journal_screen.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/exercise/presentation/pages/exercise_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/sleep/presentation/pages/sleep_screen.dart';
import 'package:livewell/feature/water/presentation/pages/water_screen.dart';
import 'package:livewell/widgets/bottom_navbar/dot_navigation_bar.dart';
import 'package:livewell/widgets/bottom_navbar/src/NavBars.dart';

import '../../../core/constant/constant.dart';
import '../../dashboard/presentation/pages/dashboard_screen.dart';
import '../../profile/presentation/page/user_settings_screen.dart';
import '../controller/home_controller.dart';

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
      bottomNavigationBar: Container(
          height: 72.h,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: HomeTab.values.map((e) {
              return Obx(
                () {
                  return InkWell(
                    onTap: () {
                      controller.changePageIndex(e.index);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        e == controller.currentMenu.value
                            ? e.selectedAssetWidget()
                            : e.unselectedAssetWidget(),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          e.title(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: e == controller.currentMenu.value
                                  ? const Color(0xFF8F01DF)
                                  : const Color(0xFF171433).withOpacity(0.8)),
                        )
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          )),
      // bottomNavigationBar: Obx(() {
      //   return DotNavigationBar(
      //       enableFloatingNavBar: false,
      //       specialKey: controller.navigationKey,
      //       currentIndex: controller.currentMenu.value.index,
      //       dotIndicatorColor: Colors.transparent,
      //       onTap: (p0) {
      //         controller.changePageIndex(p0);
      //       },
      //       itemPadding: EdgeInsets.zero,
      //       selectedItemColor: Colors.white,
      //       unselectedItemColor: Colors.white,
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.black.withOpacity(0.2),
      //           blurRadius: 0.5,
      //           offset: const Offset(0, 0), // changes position of shadow
      //         ),
      //       ],
      //       items: [
      //         DotNavigationBarItem(
      //           icon: controller.currentMenu.value == HomeTab.food
      //               ? controller.customSelectedImage(
      //                   Image.asset(
      //                     Constant.icFoodSelected,
      //                   ),
      //                 )
      //               : controller.customUnselectedImage(
      //                   Image.asset(
      //                     Constant.icFoodUnselected,
      //                   ),
      //                 ),
      //           selectedColor: Colors.white,
      //           unselectedColor: Colors.white,
      //           // selectedColor: Colors.white,
      //         ),
      //         DotNavigationBarItem(
      //           icon: controller.currentMenu.value == HomeTab.home
      //               ? controller.customSelectedImage(
      //                   Image.asset(
      //                     Constant.icHomeUnselected,
      //                   ),
      //                 )
      //               : controller.customUnselectedImage(
      //                   Image.asset(
      //                     Constant.icHomeSelected,
      //                   ),
      //                 ),
      //           selectedColor: Colors.white,
      //           unselectedColor: Colors.white,
      //           // selectedColor: Colors.white,
      //         ),
      //         DotNavigationBarItem(
      //           icon: controller.currentMenu.value == HomeTab.account
      //               ? controller.customSelectedImage(SizedBox(
      //                   width: 20.w,
      //                   height: 20.w,
      //                   child: SvgPicture.asset(
      //                     Constant.icHomeAccount,
      //                     width: 20.w,
      //                     height: 20.w,
      //                     fit: BoxFit.scaleDown,
      //                     color: Colors.white,
      //                   ),
      //                 ))
      //               : controller.customUnselectedImage(SizedBox(
      //                   width: 20.w,
      //                   height: 20.w,
      //                   child: SvgPicture.asset(
      //                     Constant.icHomeAccount,
      //                     width: 20.w,
      //                     height: 20.w,
      //                     fit: BoxFit.scaleDown,
      //                     color: const Color(0xFF8F01DF),
      //                   ),
      //                 )),
      //           selectedColor: Colors.white,
      //           unselectedColor: Colors.white,
      //           // selectedColor: Colors.white,
      //         ),
      //       ]);
      // })
    );
  }

  Widget selectBody() {
    switch (controller.currentMenu.value) {
      case HomeTab.home:
        return const DashBoardScreen();
      case HomeTab.dailyJournal:
        return UserDiaryScreen();
      // case HomeTab.exercise:
      //   return const ExerciseScreen();
      // case HomeTab.meditation:
      //   return Container(
      //     color: Colors.yellow,
      //   );
      // case HomeTab.sleep:
      //   return const SleepScreen();
      // case HomeTab.nutrition:
      //   return Container(
      //     color: Colors.yellow,
      //   );
      // case HomeTab.water:
      //   return const WaterScreen();
      case HomeTab.account:
        return UserSettingsScreen();
    }
  }
}
