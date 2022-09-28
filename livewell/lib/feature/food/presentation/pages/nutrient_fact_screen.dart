import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class NutrientFactScreen extends StatelessWidget {
  final Servings servings;
  const NutrientFactScreen({Key? key, required this.servings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Nutrient Fact',
        body: Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
              child: Column(
                children: [
                  48.verticalSpace,
                  parentNutrient("Total Fat", servings.fat),
                  10.verticalSpace,
                  childNutrient("Saturated", servings.saturatedFat),
                  10.verticalSpace,
                  childNutrient("Trans", servings.transFat),
                  10.verticalSpace,
                  childNutrient("Polyunsaturated", servings.polyunsaturatedFat),
                  10.verticalSpace,
                  childNutrient("Monounsaturated", servings.monounsaturatedFat),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient("Cholesterol", servings.cholesterol),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient("Sodium", servings.sodium),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ));
  }

  Widget parentNutrient(String name, String? value) {
    return Row(
      children: [
        Text(name,
            style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xFF171433),
                fontWeight: FontWeight.w600)),
        Spacer(),
        Text(value == null ? '-' : "$value g",
            style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xFF171433),
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget childNutrient(String name, String? value) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDDF235)),
        ),
        11.horizontalSpace,
        Text(name,
            style: TextStyle(
                fontSize: 16.sp,
                color: Color(0xFF171433),
                fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(value == null ? '-' : "$value g",
            style: TextStyle(
                fontSize: 16.sp,
                color: Color(0xFF171433),
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
