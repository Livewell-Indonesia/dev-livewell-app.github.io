import 'package:get/get.dart';
import 'package:livewell/feature/food/domain/usecase/get_cameras.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../pages/add_meal_screen.dart';
import 'package:livewell/core/base/base_controller.dart';

class ScanFoodController extends BaseController {
  final MobileScannerController mobileScannerController =
      MobileScannerController();

  GetCameras getCameras = GetCameras.instance();
  Rx<ScanType> scanType = ScanType.nutrico.obs;

  @override
  void onInit() {
    scanType.value = ScanType.values.byName(Get.parameters['type']!);
    //getCamera();
    super.onInit();
  }
}
