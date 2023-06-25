import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/water/presentation/controller/water_consumed_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class WaterConsumedPage extends StatelessWidget {
  WaterConsumedPage({super.key});

  final WaterConsumedController controller = Get.put(WaterConsumedController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: '',
        body: Column(
          children: [
            20.verticalSpace,
            Center(
                child: Text(
              controller.localization.waterConsumed!,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF171433)),
            )),
            40.verticalSpace,
            LiveWellButton(
                label: '50 ML',
                color: const Color(0xFF8F01DF),
                textColor: const Color(0xFFFFFFFF),
                onPressed: () {
                  controller.addWater(50);
                }),
            20.verticalSpace,
            LiveWellButton(
                label: '100 ML',
                color: const Color(0xFF8F01DF),
                textColor: const Color(0xFFFFFFFF),
                onPressed: () {
                  controller.addWater(100);
                }),
            20.verticalSpace,
            LiveWellButton(
                label: '500 ML',
                color: const Color(0xFF8F01DF),
                textColor: const Color(0xFFFFFFFF),
                onPressed: () {
                  controller.addWater(500);
                }),
            20.verticalSpace,
            LiveWellButton(
                label: controller.localization.custom!,
                color: const Color(0xFF8F01DF),
                textColor: const Color(0xFFFFFFFF),
                onPressed: () {
                  AppNavigator.push(routeName: AppPages.waterCustomInputPage);
                }),
          ],
        ));
  }
}
