import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/update_weight/presentation/controller/update_weight_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class UpdateCurrentWeight extends StatelessWidget {
  final UpdateWeightController controller = Get.find();

  UpdateCurrentWeight({super.key});

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Weight Update',
        body: Expanded(
          child: Column(
            children: [
              95.verticalSpace,
              Text(
                'What\'s your weight?',
                style: TextStyle(
                    color: const Color(0xFF171433),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    height: 32.sp / 24.sp),
              ),
              8.verticalSpace,
              Text(
                'Update Your current weight',
                style: TextStyle(
                    color: const Color(0xFF505050),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    height: 20.sp / 14.sp),
              ),
              60.verticalSpace,
              WeightSelectorWidget(
                onChange: (val) {
                  controller.inputtedWeight = val;
                },
                initialValue: controller.inputtedWeight ?? 50,
              ),
              const Spacer(),
              LiveWellButton(
                label: 'Update',
                color: const Color(0xFFDDF235),
                onPressed: () {
                  Get.back();
                  //controller.onUpdateTapped();
                },
              ),
              32.verticalSpace,
            ],
          ),
        ));
  }
}

class WeightSelectorWidget extends StatefulWidget {
  final double initialValue;
  final void Function(double) onChange;
  const WeightSelectorWidget({
    super.key,
    required this.onChange,
    this.initialValue = 50,
  });

  @override
  State<WeightSelectorWidget> createState() => _WeightSelectorWidgetState();
}

class _WeightSelectorWidgetState extends State<WeightSelectorWidget> {
  late double value;
  int decimalValue = 0;
  int bulatValue = 0;

  @override
  void initState() {
    value = widget.initialValue.toDouble();
    bulatValue = widget.initialValue.toInt();
    super.initState();
  }

  void onSelectedItemChanged(int index) {
    setState(() {
      bulatValue = index + 1;
    });
    widget.onChange(bulatValue + decimalValue / 10);
  }

  void onDecimalItemChanged(int index) {
    setState(() {
      decimalValue = index;
    });
    widget.onChange(bulatValue + decimalValue / 10);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 2,
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 298.h,
            width: 129.w,
            child: CupertinoPicker(
                itemExtent: 55.h,
                useMagnifier: true,
                offAxisFraction: -0.35,
                magnification: 1.25,
                selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                  background: Colors.transparent,
                ),
                scrollController: FixedExtentScrollController(
                    initialItem: bulatValue.toInt() - 1),
                onSelectedItemChanged: onSelectedItemChanged,
                children: List.generate(200, (index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: bulatValue == index + 1
                              ? const Color(0xFF8F01DF)
                              : const Color(0xFF757575),
                          fontSize: bulatValue == index + 1 ? 34.sp : 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: 20.h, left: 12.w, right: 12.w, top: 20.h),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF8F01DF),
            ),
            width: 9.w,
            height: 9.h,
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 298.h,
            child: CupertinoPicker(
                itemExtent: 55.h,
                useMagnifier: true,
                offAxisFraction: 0.4,
                magnification: 1.25,
                selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                  background: Colors.transparent,
                ),
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: onDecimalItemChanged,
                children: List.generate(10, (index) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        '$index',
                        style: TextStyle(
                          color: decimalValue == index
                              ? const Color(0xFF8F01DF)
                              : const Color(0xFF757575),
                          fontSize: decimalValue == index ? 34.sp : 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ),
        Text(
          'kg',
          style: TextStyle(
            color: const Color(0xFF808080),
            fontSize: 24.sp,
          ),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
