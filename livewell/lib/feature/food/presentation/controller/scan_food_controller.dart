import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/food/domain/usecase/get_cameras.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/base/usecase.dart';
import '../../../../core/log.dart';
import '../../../../routes/app_navigator.dart';
import '../pages/add_meal_screen.dart';

class ScanFoodController extends GetxController {
  final MobileScannerController mobileScannerController =
      MobileScannerController();

  GetCameras getCameras = GetCameras.instance();
  Rx<ScanType> scanType = ScanType.barcode.obs;

  @override
  void onInit() {
    scanType.value = ScanType.values.byName(Get.parameters['type']!);
    //getCamera();
    super.onInit();
  }
}
