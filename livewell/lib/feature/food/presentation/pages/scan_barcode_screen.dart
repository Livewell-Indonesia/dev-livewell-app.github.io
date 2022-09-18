import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcodeScreen extends StatelessWidget {
  final ScanType type;
  ScanBarcodeScreen({Key? key, required this.type}) : super(key: key);
  final MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: type.title(),
        body: Expanded(
          child: Column(
            children: [
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 8,
                child: MobileScanner(
                    controller: controller,
                    onDetect: ((barcode, args) {
                      print('barcode found ${barcode.rawValue}');
                    })),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text('Processing'),
                    Text(
                      'We’ll redirect you to another screen once we got the scanning result',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
