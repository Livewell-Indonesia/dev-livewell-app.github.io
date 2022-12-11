import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';

class SleepSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  SleepSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: CupertinoPicker(
          itemExtent: 55.h,
          onSelectedItemChanged: (index) {
            controller.sleep.value = index + 1;
          },
          selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            background: Colors.transparent,
          ),
          useMagnifier: true,
          magnification: 1.3,
          children: List.generate(24, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        color: controller.sleep.value == index + 1
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
