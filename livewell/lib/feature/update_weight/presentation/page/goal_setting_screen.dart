import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/update_weight/presentation/controller/update_weight_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

import 'update_current_weight_screen.dart';

class GoalSettingScreen extends StatelessWidget {
  GoalSettingScreen({super.key});
  final UpdateWeightController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: controller.localization.goalsSetting!,
      body: Expanded(
        child: Column(
          children: [
            95.verticalSpace,
            Text(
              'What\'s your goal?',
              style: TextStyle(color: const Color(0xFF171433), fontSize: 24.sp, fontWeight: FontWeight.w600, height: 32.sp / 24.sp),
            ),
            8.verticalSpace,
            Text(
              'Update Your current goal setting',
              style: TextStyle(color: const Color(0xFF505050), fontWeight: FontWeight.w500, fontSize: 14.sp, height: 20.sp / 14.sp),
            ),
            60.verticalSpace,
            WeightSelectorWidget(
              onChange: (val) {
                controller.inputtedTargetWeight = val;
              },
              initialValue: controller.inputtedTargetWeight?.toDouble() ?? 50,
            ),
            const Spacer(),
            LiveWellButton(
              label: controller.localization.update!,
              color: const Color(0xFFDDF235),
              onPressed: () {
                controller.onUpdateTargetTapped();
              },
            ),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }
}
