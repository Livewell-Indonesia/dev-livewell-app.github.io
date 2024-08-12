import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class NutrientFactScreen extends StatelessWidget {
  final Servings servings;
  final num numberOfServings;
  const NutrientFactScreen({Key? key, required this.servings, required this.numberOfServings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: Get.find<HomeController>().localization.nutrientFactPage?.nutrientFact ?? "Nutrient Fact",
        body: Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
              child: Column(
                children: [
                  48.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.totalFat ?? "Total Fat",
                    servingDesc(servings.fat, "g"),
                  ),
                  10.verticalSpace,
                  childNutrient(Get.find<HomeController>().localization.nutrientFactPage?.saturated ?? "Saturated", servings.saturatedFat),
                  10.verticalSpace,
                  childNutrient(Get.find<HomeController>().localization.nutrientFactPage?.transFat ?? "Trans", servings.transFat),
                  10.verticalSpace,
                  childNutrient(Get.find<HomeController>().localization.nutrientFactPage?.polyunsaturated ?? "Polyunsaturated", servings.polyunsaturatedFat),
                  10.verticalSpace,
                  childNutrient(Get.find<HomeController>().localization.nutrientFactPage?.monounsaturated ?? "Monounsaturated", servings.monounsaturatedFat),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.carbs ?? "Carbs",
                    servingDesc(servings.carbohydrate, "g"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.fiber ?? "Fiber",
                    servingDesc(servings.fiber, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.protein ?? "Protein",
                    servingDesc(servings.protein, "g"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.sodium ?? "Sodium",
                    servingDesc(servings.sodium, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.potassium ?? "Potassium",
                    servingDesc(servings.potassium, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.cholesterol ?? "Cholesterol",
                    servingDesc(servings.cholesterol, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.vitaminA ?? "Vitamin A",
                    servingDesc(servings.vitaminA, "mcg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.vitaminC ?? "Vitamin C",
                    servingDesc(servings.vitaminC, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.calcium ?? "Calcium",
                    servingDesc(servings.calcium, "mg"),
                  ),
                  10.verticalSpace,
                  const Divider(),
                  20.verticalSpace,
                  parentNutrient(
                    Get.find<HomeController>().localization.nutrientFactPage?.iron ?? "Iron",
                    servingDesc(servings.iron, "mg"),
                  ),
                  20.verticalSpace,
                  const Divider(),
                  parentNutrient(Get.find<HomeController>().localization.nutrientFactPage?.sugar ?? "Sugar", servingDesc(servings.sugar, "g")),
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
        Text(name, style: TextStyle(fontSize: 20.sp, color: const Color(0xFF171433), fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(value ?? "-", style: TextStyle(fontSize: 20.sp, color: const Color(0xFF171433), fontWeight: FontWeight.w600)),
      ],
    );
  }

  String servingDesc(String? servingAmountInt, String? metricServingUnit) {
    if (servingAmountInt == "0" || servingAmountInt == "" || servingAmountInt == null) {
      return "-";
    }
    if (metricServingUnit == null) {
      return "-";
    }
    return "${NumberFormat('0.0').format(double.parse(servingAmountInt) * numberOfServings.toDouble())} $metricServingUnit";
  }

  Widget childNutrient(String name, String? value) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDDF235)),
        ),
        11.horizontalSpace,
        Text(name, style: TextStyle(fontSize: 16.sp, color: const Color(0xFF171433), fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(value == null ? '-' : "$value g", style: TextStyle(fontSize: 16.sp, color: const Color(0xFF171433), fontWeight: FontWeight.w500)),
      ],
    );
  }
}
