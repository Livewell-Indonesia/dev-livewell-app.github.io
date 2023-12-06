import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/feature/water/presentation/controller/water_consumed_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

enum WaterInputType { reduce, increase }

extension WaterInputTypeExt on WaterInputType {
  String get title {
    switch (this) {
      case WaterInputType.reduce:
        return 'Reduce Water';
      case WaterInputType.increase:
        return Get.find<HomeController>().localization.waterConsumed ?? "Water Consumed";
    }
  }

  Color get color {
    switch (this) {
      case WaterInputType.reduce:
        return const Color(0xFFDDF235);
      case WaterInputType.increase:
        return const Color(0xFF8F01DF);
    }
  }

  Color get textColor {
    switch (this) {
      case WaterInputType.reduce:
        return Colors.black;
      case WaterInputType.increase:
        return const Color(0xFFFFFFFF);
    }
  }
}

class WaterCustomInputPage extends StatelessWidget {
  WaterCustomInputPage({super.key});

  final WaterConsumedController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var waterInputType = Get.arguments['waterInputType'] as WaterInputType;
    return LiveWellScaffold(
        title: 'Water Tracking',
        body: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              40.verticalSpace,
              LiveWellTextField(
                  controller: controller.waterInputController, hintText: 'in mL', labelText: 'in mL', errorText: null, keyboardType: const TextInputType.numberWithOptions(), obscureText: false),
              const Spacer(),
              LiveWellButton(
                  label: 'Add Drink',
                  color: waterInputType.color,
                  textColor: const Color(0xFFFFFFFF),
                  onPressed: () {
                    controller.addWater(int.tryParse(controller.waterInputController.text) ?? 0, waterInputType);
                  }),
              40.verticalSpace,
            ],
          ),
        ));
  }
}
