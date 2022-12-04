import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/update_weight/presentation/controller/update_weight_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

import '../../../profile/presentation/page/account_settings_screen.dart';

class UpdateWeightScreen extends StatelessWidget {
  UpdateWeightScreen({super.key});

  UpdateWeightController controller = Get.put(UpdateWeightController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: "Update Weight",
        body: Expanded(
          child: Column(
            children: [
              40.verticalSpace,
              AccountSettingsTextField(
                textEditingController: controller.weightController,
                hintText: 'Current Weight (Kg)',
                enabled: true,
                inputType: const TextInputType.numberWithOptions(),
              ),
              Spacer(),
              LiveWellButton(
                  label: "Update",
                  color: const Color(0xFF8F01DF),
                  textColor: Colors.white,
                  onPressed: () {
                    controller.onUpdateTapped();
                  }),
              40.verticalSpace,
            ],
          ),
        ));
  }
}
