import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/exercise/presentation/controller/exercise_controller.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class InputStepsBottomSheet extends StatefulWidget {
  const InputStepsBottomSheet({required this.focusNode, super.key});
  final FocusNode focusNode;

  @override
  State<InputStepsBottomSheet> createState() => _InputStepsBottomSheetState();
}

class _InputStepsBottomSheetState extends State<InputStepsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
      child: Column(
        children: [
          Text('Input your steps', style: TextStyle(color: const Color(0xFF505050), fontSize: 16.sp, fontWeight: FontWeight.w600)),
          16.verticalSpace,
          TextField(
            focusNode: widget.focusNode,
            controller: Get.find<ExerciseController>().exerciseManualInput,
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              hintText: 'Input Steps',
              suffixText: 'Steps',
              suffixStyle: TextStyle(color: Theme.of(context).colorScheme.neutral90, fontSize: 16.sp, fontWeight: FontWeight.w500),
              hintStyle: TextStyle(color: Theme.of(context).colorScheme.neutral50, fontSize: 16.sp, fontWeight: FontWeight.w500),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 50,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(
                  color: Color(0xFFE8E7E7),
                  width: 2,
                ),
              ),
            ),
          ),
          16.verticalSpace,
          Center(
            child: Wrap(
              children: [
                LiveWellButton(
                    label: 'Add Steps',
                    color: const Color(0xFF8F01DF),
                    textColor: Colors.white,
                    onPressed: Get.find<ExerciseController>().exerciseManualInput.text.isNotEmpty
                        ? null
                        : () {
                            Get.find<ExerciseController>().sendExerciseDataManual();
                          },
                    wrapSize: true,
                    padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 12.h))
                // Obx(() {
                //   return LiveWellButton(
                //       label: 'Add Steps',
                //       color: const Color(0xFF8F01DF),
                //       textColor: Colors.white,
                //       onPressed: Get.find<ExerciseController>().exerciseManualInput.text.isNotEmpty
                //           ? null
                //           : () {
                //               Get.find<ExerciseController>().exerciseManualInput.clear();
                //             },
                //       wrapSize: true,
                //       padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 12.h));
                // })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
