import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/base/base_controller.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/water/presentation/pages/water_custom_input_page.dart';

class WaterCustomInputController extends BaseController {
  var position = 0.0.obs;
  var maxMils = 0.obs;
  var currentValue = 0.obs;
  var minimumReduce = 10.obs;
  var inputtedValue = 0.obs;
  var type = WaterInputType.increase.obs;
  @override
  void onInit() {
    setInitialData();
    super.onInit();
  }

  void setInitialData() async {
    position = (await SharedPref.getLastCustomWaterInput()).toDouble().obs;
    type.value = Get.arguments['waterInputType'] as WaterInputType;
    var lastInput = await SharedPref.getLastCustomWaterInput();
    maxMils = ((int.parse((Get.find<DashboardController>().user.value.onboardingQuestionnaire?.glassesOfWaterDaily ?? "0")) * 0.25) * 1000).toInt().obs;
    if (type.value == WaterInputType.reduce) {
      minimumReduce = 10.obs;
      currentValue.value = Get.find<DashboardController>().waterConsumed.value.toInt();

      position.value = 412.h / (maxMils.value / minimumReduce.value);
    } else {
      currentValue.value = 0;
      position.value = lastInput != 0 ? 412.h / (maxMils / lastInput) : 0;
      minimumReduce.value = 0;
    }
  }
}
