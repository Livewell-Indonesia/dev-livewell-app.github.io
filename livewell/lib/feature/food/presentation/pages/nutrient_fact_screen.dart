import 'package:flutter/material.dart';
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
                  parentNutrient(
                    "Total Fat",
                    servingDesc(servings.fat, "g"),
                  ),
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
                  parentNutrient(
                    "Carbs",
                    servingDesc(servings.carbohydrate, "g"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    "Fiber",
                    servingDesc(servings.fiber, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    "Protein",
                    servingDesc(servings.protein, "g"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    "Sodium",
                    servingDesc(servings.sodium, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    "Potassium",
                    servingDesc(servings.potassium, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    "Cholesterol",
                    servingDesc(servings.cholesterol, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    "Vitamin A",
                    servingDesc(servings.vitaminA, "mcg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    "Vitamin C",
                    servingDesc(servings.vitaminC, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    "Calcium",
                    servingDesc(servings.calcium, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    "Iron",
                    servingDesc(servings.iron, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
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
                color: const Color(0xFF171433),
                fontWeight: FontWeight.w600)),
        Spacer(),
        Text(value ?? "-",
            style: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFF171433),
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  String servingDesc(String? servingAmountInt, String? metricServingUnit) {
    if (servingAmountInt == "0" ||
        servingAmountInt == "" ||
        servingAmountInt == null) {
      return "-";
    }
    if (metricServingUnit == null) {
      return "-";
    }
    return "$servingAmountInt $metricServingUnit";
  }

  Widget childNutrient(String name, String? value) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xFFDDF235)),
        ),
        11.horizontalSpace,
        Text(name,
            style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF171433),
                fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(value == null ? '-' : "$value g",
            style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF171433),
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
