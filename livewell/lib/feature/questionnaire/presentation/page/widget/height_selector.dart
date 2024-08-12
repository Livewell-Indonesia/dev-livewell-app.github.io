import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class HeightSelector extends StatefulWidget {
  final double initialValue;

  const HeightSelector({Key? key, this.initialValue = 150}) : super(key: key);

  @override
  State<HeightSelector> createState() => _HeightSelectorState();
}

class _HeightSelectorState extends State<HeightSelector> {
  final QuestionnaireController controller = Get.find();
  int? selectedHeight;
  @override
  void initState() {
    selectedHeight = widget.initialValue.toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 423.h,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Height',
            style: TextStyle(color: const Color(0xFF000000), fontSize: 24.sp, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 32.h),
            height: 207.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(opacity: 0.0, child: Text('cm', style: TextStyle(color: const Color(0xFF808080), fontSize: 24.sp))),
                SizedBox(
                  width: 129.w,
                  child: CupertinoPicker(
                    itemExtent: 55.h,
                    scrollController: FixedExtentScrollController(initialItem: selectedHeight! - 1),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedHeight = index + 1;
                      });
                    },
                    useMagnifier: true,
                    magnification: 1.3,
                    selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                      background: Colors.transparent,
                    ),
                    children: List.generate(
                      200,
                      (index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                  color: selectedHeight == index + 1 ? const Color(0xFF8F01DF) : const Color(0xFF757575),
                                  fontSize: selectedHeight == index + 1 ? 34.sp : 24.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  'cm',
                  style: TextStyle(
                    color: const Color(0xFF808080),
                    fontSize: 24.sp,
                  ),
                ),
              ],
            ),
          ),
          LiveWellButton(
            label: 'Confirm',
            color: const Color(0xFF8F01DF),
            textColor: Colors.white,
            onPressed: () {
              controller.height.value = selectedHeight!;
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
