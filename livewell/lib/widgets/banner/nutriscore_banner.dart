import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livewell/widgets/chart/circular_nutrition.dart';

class NutriscoreBanner extends StatelessWidget {
  const NutriscoreBanner({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF171433),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: MultipleColorCircle(
              colorOccurrences: getNutritionScoreType(value).getColors(value),
              height: 66.h,
              strokeWidth: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$value',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp)),
                ],
              ),
            ),
          ),
          20.horizontalSpace,
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NutriScore',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
                4.verticalSpace,
                Text(
                  getNutritionScoreType(value).description(),
                  maxLines: 2,
                  style: TextStyle(
                      height: 1.3,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp),
                ),
                4.verticalSpace,
                Text(
                  'See Details',
                  style: TextStyle(
                      color: const Color(0xFFDDF235),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  NutriScoreType getNutritionScoreType(int value) {
    if (value >= 0 && value <= 50) {
      return NutriScoreType.fifty;
    }
    if (value > 50 && value <= 75) {
      return NutriScoreType.seventyFive;
    }
    if (value >= 76 && value <= 100) {
      return NutriScoreType.hundred;
    } else {
      return NutriScoreType.zero;
    }
  }
}

enum NutriScoreType { zero, fifty, seventyFive, hundred }

extension on NutriScoreType {
  String description() {
    switch (this) {
      case NutriScoreType.zero:
        return 'Let’s make today count, put your meal to track your progress';
      case NutriScoreType.fifty:
        return 'Don’t worry, We can definitely improve your nutrition together!';
      case NutriScoreType.seventyFive:
        return 'You’re doing great! Let’s make sure we push it a little further';
      case NutriScoreType.hundred:
        return 'Great Job! Your nutrition is on point. Keep up the good work!';
    }
  }

  Map<Color, int> getColors(int value) {
    switch (this) {
      case NutriScoreType.zero:
        return {Colors.grey: 100};
      case NutriScoreType.fifty:
        final map = {const Color(0xFF34EAB2): value >= 25 ? 25 : value};
        map.addEntries([
          MapEntry(
            (value - 25 <= 0) ? Colors.white : const Color(0xFFDDF235),
            (value - 25 <= 0) ? 100 - value : value - 25,
          ),
          MapEntry(Colors.white, 100 - value)
        ]);
        return map;
      case NutriScoreType.seventyFive:
        final map = {
          const Color(0xFF34EAB2): 25,
          const Color(0xFFDDF235): 25,
        };
        map.addEntries([
          MapEntry(
            (value - 50 <= 0) ? Colors.white : const Color(0xFF8F01DF),
            (value - 50 <= 0) ? 100 - value : value - 50,
          ),
          MapEntry(Colors.white, 100 - value)
        ]);
        return map;
      case NutriScoreType.hundred:
        final map = {
          const Color(0xFF34EAB2): 25,
          const Color(0xFFDDF235): 25,
        };
        map.addEntries([
          MapEntry(const Color(0xFF8F01DF), value - 50),
          MapEntry(Colors.white, 100 - value)
        ]);
        return map;
    }
  }
}
