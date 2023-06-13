import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/feature/food/presentation/controller/add_food_controller.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/widgets/chart/circular_nutrition.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../data/model/foods_model.dart';
import 'nutrient_fact_screen.dart';

class AddFoodScreen extends StatefulWidget {
  final Foods food;
  final MealTime mealTime;
  const AddFoodScreen({required this.food, required this.mealTime, Key? key})
      : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final AddFoodController controller = Get.put(AddFoodController());
  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
    inspect(widget.food);
    controller.servingSize.text =
        widget.food.servings?[0].servingDescription ?? "";
    controller.numberOfServing.text =
        double.parse(widget.food.servings?[0].numberOfUnits ?? "1.0")
            .toInt()
            .toString();
    inspect(widget.food);
    controller.selectedTime.value = selectedTime.toString();
    controller.time.text = DateFormat('hh:mm a').format(selectedTime);
    if (Get.arguments != null) {
      selectedTime = Get.arguments as DateTime;
      controller.selectedTime.value = selectedTime.toString();
      controller.time.text = DateFormat('hh:mm a').format(selectedTime);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: controller.localization.food!,
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Padding(
                    padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
                    child: Text(
                      widget.food.foodName ?? "",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    )),
                8.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w),
                  child: Text(
                      "${widget.food.servings?.first.servingDescription ?? ""} ${widget.food.servings?.first.servingDesc ?? ""}",
                      style: TextStyle(
                          color: const Color(0xFF171433).withOpacity(0.8),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600)),
                ),
                10.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: MultipleColorCircle(
                      colorOccurrences: {
                        const Color(0xFF8F01DF): ((((double.parse(
                                        widget.food.servings?[0].carbohydrate ??
                                            "0")) *
                                    4) /
                                double.parse(
                                    widget.food.servings?[0].calories ?? "0") *
                                100)
                            .roundZero()),
                        const Color(0xFFF5D25D): (((double.parse(
                                        widget.food.servings?[0].fat ?? "0") *
                                    9) /
                                double.parse(
                                    widget.food.servings?[0].calories ?? "0") *
                                100)
                            .roundZero()),
                        const Color(0xFFDDF235): (((double.parse(
                                        widget.food.servings?[0].protein ??
                                            "0") *
                                    4) /
                                double.parse(
                                    widget.food.servings?[0].calories ?? "0") *
                                100)
                            .roundZero())
                      },
                      height: 80,
                      child:
                          // crete circular container
                          Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GetBuilder<AddFoodController>(
                                  builder: (controller) {
                                return Text(
                                  '${controller.getTotalCalByServings(num.parse(widget.food.servings?[0].calories ?? "0")).round().toInt()}',
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w500),
                                );
                              }),
                              Text(
                                'Cal',
                                style: TextStyle(fontSize: 11.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GetBuilder<AddFoodController>(builder: (controller) {
                  return NutritionProgressDescription(
                    data: [
                      NutrtionProgressModel(
                          name: 'Carbs',
                          color: const Color(0xFF8F01DF),
                          total:
                              "${controller.getTotalCarbsByServings(num.parse(widget.food.servings?[0].carbohydrate ?? "0")).toInt()} ${widget.food.servings?[0].metricServingUnit ?? "g"}",
                          consumed:
                              "${(controller.maxHundred((num.parse(widget.food.servings?[0].carbohydrate ?? "0") * 4) / num.parse(widget.food.servings?[0].calories ?? "0") * 100).roundZero())}% "),
                      NutrtionProgressModel(
                          name: 'Fat',
                          color: const Color(0xFFF5D25D),
                          total:
                              "${controller.getTotalFatByServings(num.parse(widget.food.servings?[0].fat ?? "0")).toInt()} ${widget.food.servings?[0].metricServingUnit ?? "g"}",
                          consumed:
                              "${(controller.maxHundred((num.parse(widget.food.servings?[0].fat ?? "0") * 9) / num.parse(widget.food.servings?[0].calories ?? "0") * 100).roundZero())}% "),
                      NutrtionProgressModel(
                          name: 'Protein',
                          color: const Color(0xFFDDF235),
                          total:
                              "${controller.getTotalProteinByServings(num.parse(widget.food.servings?[0].protein ?? "0")).toInt()} ${widget.food.servings?[0].metricServingUnit ?? "g"}",
                          consumed:
                              "${(controller.maxHundred((num.parse(widget.food.servings?[0].protein ?? "0") * 4) / num.parse(widget.food.servings?[0].calories ?? "0") * 100).roundZero())}% "),
                    ],
                    backgroundColor: Colors.transparent,
                  );
                }),
                SearchHistoryItem(
                    title: controller.localization.showNutrientFacts!,
                    description: "",
                    isAdded: false,
                    callback: () {
                      Get.to(() => NutrientFactScreen(
                            servings: widget.food.servings![0],
                            numberOfServings:
                                double.parse(controller.numberOfServing.text),
                          ));
                    }),
                15.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: LiveWellTextField(
                          controller: controller.numberOfServing,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          hintText: null,
                          labelText: controller.localization.numberOfServing!,
                          errorText: null,
                          obscureText: false,
                          enabled: true,
                          margin: EdgeInsets.only(left: 8.w),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: InkWell(
                            onTap: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 20)
                                            .r,
                                        height: 380.h,
                                        child: Column(
                                          children: [
                                            Text(
                                              controller.localization.time!,
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF171433),
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 274.h,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                onDateTimeChanged: (time) {
                                                  if (Get.arguments != null) {
                                                    selectedTime = DateTime(
                                                        selectedTime.year,
                                                        selectedTime.month,
                                                        selectedTime.day,
                                                        time.hour,
                                                        time.minute);
                                                  } else {
                                                    selectedTime = time;
                                                  }
                                                },
                                              ),
                                            ),
                                            // create cancel button with outline
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                            width: 2,
                                                            color: const Color(
                                                                    0xFF171433)
                                                                .withOpacity(
                                                                    0.7)),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        controller.localization
                                                            .cancel!,
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xFF171433),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                ),
                                                const Spacer(),
                                                Expanded(
                                                  flex: 2,
                                                  child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF8F01DF),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        controller.time
                                                            .text = DateFormat(
                                                                'hh:mm a')
                                                            .format(
                                                                selectedTime);
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        controller
                                                            .localization.save!,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: IgnorePointer(
                              child: LiveWellTextField(
                                controller: controller.time,
                                hintText: null,
                                labelText: controller.localization.time!,
                                errorText: null,
                                obscureText: false,
                                enabled: false,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                32.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 76.h,
                  margin: const EdgeInsets.symmetric(horizontal: 16).r,
                  padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 24, right: 15)
                      .r,
                  decoration: BoxDecoration(
                    color: const Color(0xFF171433),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GetBuilder<AddFoodController>(
                                  builder: ((controller) {
                                    return Text(
                                        "${controller.percentOfDailyGoals(controller.getTotalCalByServings(num.parse(widget.food.servings?[0].calories ?? "0")).round().toInt())}% ${controller.localization.ofYourGoal}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600));
                                  }),
                                ),
                                const Spacer(),
                                GetBuilder<AddFoodController>(
                                    builder: (controller) {
                                  return Text(
                                      ("${controller.getTotalCalByServings(num.parse(widget.food.servings?[0].calories ?? "0")).round().toInt()} cal"),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600));
                                }),
                              ],
                            ),
                            7.verticalSpace,
                            GetBuilder<AddFoodController>(
                                builder: (controller) {
                              return LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                lineHeight: 7.0,
                                percent: controller.percentOfDailyGoals(
                                        controller
                                            .getTotalCalByServings(num.parse(
                                                widget.food.servings?[0]
                                                        .calories ??
                                                    "0"))
                                            .round()
                                            .toInt()) /
                                    100,
                                barRadius: const Radius.circular(4.0),
                                backgroundColor: const Color(0xFFF2F1F9),
                                progressColor: const Color(0xFFDDF235),
                              );
                            })
                          ],
                        ),
                      ),
                      // create submit button
                      8.horizontalSpace,
                      InkWell(
                        onTap: () {
                          controller.selectedTime.value =
                              selectedTime.toString();
                          controller.addMeals(widget.food, widget.mealTime);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 7)
                              .r,
                          height: 33.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDF235),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: Text(
                              controller.localization.submit!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,
              ],
            ),
          ),
        ));
  }
}

extension CustomRounder on double {
  int roundZero() {
    return this == 0 || isNaN || isInfinite ? 0 : round();
  }
}
