import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livewell/widgets/chart/circular_calories.dart';

class ExerciseClassScreen extends StatelessWidget {
  const ExerciseClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //40.verticalSpace,
        Text(
          "You have reached 40% of your goal!",
          style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        40.verticalSpace,
        SimpleCircularProgressBar(
          backColor: Colors.white,
          progressColors: const [Color(0xFF8F01DF)],
          mergeMode: true,
          backStrokeWidth: 8,
          size: 200.h,
          progressStrokeWidth: 14,
          valueNotifier: ValueNotifier(0.4),
          animationDuration: const Duration(seconds: 1),
          maxValue: 1,
          shadow: false,
          onGetText: (value) {
            return Text(
              "40%",
              style: TextStyle(fontSize: 40.sp, color: const Color(0xFF171433)),
            );
          },
        ),
      ],
    );
  }
}
