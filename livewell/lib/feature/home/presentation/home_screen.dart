import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/get_meal_type_by_current_time.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/nutrico/presentation/widget/nutri_score_plus_bottom_sheet.dart';
import 'package:livewell/routes/app_navigator.dart';

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
      body: Stack(
        children: [
          Obx(() {
            return selectBody();
          }),
        ],
      ),
      bottomNavigationBar: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
              height: 72.h,
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              padding: EdgeInsets.symmetric(horizontal: 42.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: HomeTab.values.map((e) {
                  return Obx(
                    () {
                      return InkWell(
                        onTap: () {
                          if (Get.isSnackbarOpen) {
                            Get.back();
                          }
                          if (e == HomeTab.home) {
                            controller.trackEvent(LivewellHomepageEvent.navbarHomeButton);
                          } else if (e == HomeTab.account) {
                            controller.trackEvent(LivewellHomepageEvent.navbarAccountButton);
                          }
                          controller.changePageIndex(e.index);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            e == controller.currentMenu.value ? e.selectedAssetWidget() : e.unselectedAssetWidget(),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              e.title(),
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400, color: e == controller.currentMenu.value ? const Color(0xFF8F01DF) : const Color(0xFF171433).withOpacity(0.8)),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              )),
          InkWell(
            onTap: () {
              controller.trackEvent(LivewellHomepageEvent.navbarNutricoButton);
              if (Get.isSnackbarOpen) {
                Get.back();
              }
              showModalBottomSheet(
                  context: context,
                  shape: shapeBorder(),
                  builder: (context) {
                    return Obx(() {
                      return NutriScorePlusBottomSheet(
                        isAlreadyLimit: Get.find<DashboardController>().featureLimit.value?.isNutricoAlreadyLimit() ?? true,
                        maxRequest: Get.find<DashboardController>().featureLimit.value?.getNutricoCurrentUsage() ?? 30,
                        onSelected: (p0) {
                          Get.back();
                          switch (p0) {
                            case SelectedNutriscorePlusMethod.camera:
                              break;
                            case SelectedNutriscorePlusMethod.gallery:
                              break;
                            case SelectedNutriscorePlusMethod.desc:
                              controller.trackEvent(LivewellHomepageEvent.navbarNutricoDescribeFoodButton);
                              AppNavigator.push(routeName: AppPages.nutriCoScreen, arguments: {
                                'type': getMealTypeByCurrentTime().name,
                                'date': DateTime.now(),
                              });
                              break;
                          }
                        },
                        onImageSelected: (bytes) {
                          EasyLoading.dismiss();
                          Get.back();
                          AppNavigator.push(routeName: AppPages.loadingNutricoPlus, arguments: bytes);
                        },
                      );
                    });
                  });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  key: Get.find<HomeController>().nutricoKey,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF8F01DF)),
                  height: 56.h,
                  width: 56.h,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: SvgPicture.asset(
                      Constant.icBarcode,
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.fill,
                      color: const Color(0xFFDDF235),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "NutriCo+",
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFF171433).withOpacity(0.8)),
                ),
                14.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget selectBody() {
    switch (controller.currentMenu.value) {
      case HomeTab.home:
        return const DashBoardScreen();
      // case HomeTab.nutricoPlus:
      //   return UserDiaryScreen();
      case HomeTab.account:
        return UserSettingsScreen();
    }
  }
}
