import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/questionnaire_controller.dart';

class TargetWeightSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  TargetWeightSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
              initialItem: controller.targetWeight.value - 1),
          itemExtent: 55.h,
          onSelectedItemChanged: (index) {
            controller.targetWeight.value = index + 1;
          },
          useMagnifier: true,
          magnification: 1.3,
          selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            background: Colors.transparent,
          ),
          children: List.generate(200, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    '${index + 1} kg',
                    style: TextStyle(
                        color: controller.targetWeight.value == index + 1
                            ? const Color(0xFF8F01DF)
                            : const Color(0xFF171433).withOpacity(0.7),
                        fontSize: 34.sp),
                  );
                })
              ],
            );
          })),
    );
  }
}
