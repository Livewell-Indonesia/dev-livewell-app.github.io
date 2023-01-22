import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/water/presentation/controller/water_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

class WaterCustomInputPage extends StatelessWidget {
  WaterCustomInputPage({super.key});

  final WaterContoller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Water Tracking',
        body: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              40.verticalSpace,
              LiveWellTextField(
                  controller: controller.waterInputController,
                  hintText: 'in mL',
                  labelText: 'in mL',
                  errorText: null,
                  keyboardType: const TextInputType.numberWithOptions(),
                  obscureText: false),
              Spacer(),
              LiveWellButton(
                  label: 'Add Drink',
                  color: const Color(0xFF8F01DF),
                  textColor: const Color(0xFFFFFFFF),
                  onPressed: () {
                    controller.addWater(
                        int.tryParse(controller.waterInputController.text) ??
                            0);
                  }),
              40.verticalSpace,
            ],
          ),
        ));
  }
}
