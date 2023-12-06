import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/water/presentation/controller/water_consumed_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';

import 'water_custom_input_page.dart';

class WaterConsumedPage extends StatelessWidget {
  WaterConsumedPage({super.key});

  final WaterConsumedController controller = Get.put(WaterConsumedController());

  @override
  Widget build(BuildContext context) {
    var waterInputType = Get.arguments['waterInputType'] as WaterInputType;
    return LiveWellScaffold(
        title: waterInputType.title,
        body: SizedBox(
          height: 0.85.sh,
          child: Column(
            children: [
              Spacer(),
              LiveWellButton(
                  label: '50 ML',
                  color: waterInputType.color,
                  textColor: waterInputType.textColor,
                  onPressed: () {
                    controller.addWater(50, waterInputType);
                  }),
              20.verticalSpace,
              LiveWellButton(
                  label: '100 ML',
                  color: waterInputType.color,
                  textColor: waterInputType.textColor,
                  onPressed: () {
                    controller.addWater(100, waterInputType);
                  }),
              20.verticalSpace,
              LiveWellButton(
                  label: '500 ML',
                  color: waterInputType.color,
                  textColor: waterInputType.textColor,
                  onPressed: () {
                    controller.addWater(500, waterInputType);
                  }),
              20.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.paddingMedium),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        fixedSize: Size(1.sw, 48.w),
                        side: BorderSide(width: 2, color: waterInputType.color),
                        padding: EdgeInsets.symmetric(horizontal: Insets.paddingMedium, vertical: Insets.paddingMedium.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0).r)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                              const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                          builder: (context) {
                            return buildCustomInputWater(context, waterInputType);
                          });
                    },
                    child: Text(
                      controller.localization.custom ?? "Custom",
                      style: TextStyle(color: const Color(0xFF171433), fontSize: 16.sp, fontWeight: FontWeight.w500),
                    )),
              ),
              // LiveWellButton(
              //     label: controller.localization.custom!,
              //     color: const Color(0xFF8F01DF),
              //     textColor: const Color(0xFFFFFFFF),
              //     onPressed: () {
              //       AppNavigator.push(routeName: AppPages.waterCustomInputPage);
              //     }),
            ],
          ),
        ));
  }

  Widget buildCustomInputWater(BuildContext context, WaterInputType type) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        children: [
          Container(
            child: Column(children: [
              24.verticalSpace,
              Text(
                controller.localization.custom ?? "Custom",
                style: TextStyle(
                  color: const Color(0xFF171433),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              24.verticalSpace,
              LiveWellTextField(
                  controller: controller.waterInputController, hintText: 'in mL', labelText: 'in mL', errorText: null, keyboardType: const TextInputType.numberWithOptions(), obscureText: false),
              32.verticalSpace,
              LiveWellButton(
                  label: 'Add Drink',
                  color: const Color(0xFFDDF235),
                  textColor: const Color(0xFF171433),
                  onPressed: () {
                    controller.addWater(int.tryParse(controller.waterInputController.text) ?? 0, type);
                  }),
              16.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.paddingMedium),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        fixedSize: Size(1.sw, 48.w),
                        side: const BorderSide(width: 2, color: Color(0xFFDDF235)),
                        padding: EdgeInsets.symmetric(horizontal: Insets.paddingMedium, vertical: Insets.paddingMedium.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0).r)),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      controller.localization.cancel ?? "Cancel",
                      style: TextStyle(color: const Color(0xFF171433), fontSize: 16.sp, fontWeight: FontWeight.w500),
                    )),
              ),
              32.verticalSpace,
            ]),
          ),
        ],
      ),
    );
  }
}
