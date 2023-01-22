import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:livewell/core/log.dart';

class WaterContoller extends GetxController {
  var waterConsumed = 0.0.obs;
  TextEditingController waterInputController = TextEditingController();

  @override
  void onInit() {
    getWaterData();
    super.onInit();
  }

  void getWaterData() {
    // mock api call for 2 s
    Future.delayed(const Duration(seconds: 2), () {
      waterConsumed.value = 0.1;
      Future.delayed(const Duration(seconds: 1), () {
        waterConsumed.value = 0.21;
        Future.delayed(const Duration(seconds: 1), () {
          waterConsumed.value = 0.39;
          Future.delayed(const Duration(seconds: 1), () {
            waterConsumed.value = 0.44;
            Future.delayed(const Duration(seconds: 1), () {
              waterConsumed.value = 0.52;
              Future.delayed(const Duration(seconds: 1), () {
                waterConsumed.value = 0.67;
              });
            });
          });
        });
      });
    });
  }

  void addWater(int value) {
    Log.colorGreen("input water value: $value");
  }
}
