import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/controller/user_diary_controller.dart';
import 'package:livewell/feature/water/presentation/controller/water_controller.dart';
import 'package:livewell/routes/app_navigator.dart';

import '../../domain/usecase/post_water_data.dart';
import 'package:livewell/core/base/base_controller.dart';

class WaterConsumedController extends BaseController {
  TextEditingController waterInputController = TextEditingController();

  void addWater(int value) async {
    PostWaterData instance = PostWaterData.instance();
    EasyLoading.show();
    final result = await instance.call(PostWaterParams(water: value));
    EasyLoading.dismiss();
    result.fold((l) {
      Log.error(l);
    }, (r) {
      AppNavigator.popUntil(routeName: AppPages.home);
      if (Get.isRegistered<WaterController>()) {
        Get.find<WaterController>().getWaterData();
      }
      if (Get.isRegistered<UserDiaryController>()) {
        Get.find<UserDiaryController>().refreshList();
      }
      Get.find<DashboardController>().getWaterData();
      Log.colorGreen(r);
    });
  }
}
