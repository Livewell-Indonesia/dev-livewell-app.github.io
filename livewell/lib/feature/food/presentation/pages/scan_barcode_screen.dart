import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcodeScreen extends StatefulWidget {
  const ScanBarcodeScreen({Key? key}) : super(key: key);

  @override
  State<ScanBarcodeScreen> createState() => _ScanBarcodeScreenState();
}

class _ScanBarcodeScreenState extends State<ScanBarcodeScreen> {
  final MobileScannerController controller = MobileScannerController();

  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: "scan a barcode".tr,
        body: Expanded(
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 8,
                child: MobileScanner(
                    controller: controller, onDetect: ((barcode, args) {})),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    20.verticalSpace,
                    Text(
                      'Processing...'.tr,
                      style: TextStyle(
                          color: const Color(0xFF171433),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    7.verticalSpace,
                    Text(
                      'We’ll redirect you to another screen once we got the scanning result'
                          .tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF171433),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
