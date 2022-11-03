import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/equation/formula.dart';
import 'package:livewell/feature/food/presentation/controller/add_food_controller.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/chart/circular_nutrition.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../widgets/textfield/livewell_textfield.dart';
import '../../data/model/foods_model.dart';
import 'nutrient_fact_screen.dart';

class AddFoodScreen extends StatefulWidget {
  final Foods food;
  final MealTime mealTime;
  AddFoodScreen({required this.food, required this.mealTime, Key? key})
      : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final AddFoodController controller = Get.put(AddFoodController());
  DateTime selectedTime = DateTime.now();

  @override
  void initState() {
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
        title: 'Add Food',
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Padding(
                    padding: const EdgeInsets.only(left: 16.0).r,
                    child: Text(
                      widget.food.foodName ?? "",
                      style: GoogleFonts.archivo(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF8F01DF)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0).r,
                  child: Text(
                      widget.food.servings?.first.servingDescription ?? "",
                      style: TextStyle(
                          color: const Color(0xFF171433).withOpacity(0.8),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: MultipleColorCircle(
                      colorOccurrences: {
                        const Color(0xFF8F01DF): (((double.parse(
                                        widget.food.servings?[0].carbohydrate ??
                                            "1")) *
                                    4) /
                                int.parse(
                                    widget.food.servings?[0].calories ?? "1") *
                                100)
                            .round(),
                        const Color(0xFFF5D25D): ((double.parse(
                                        widget.food.servings?[0].fat ?? "1") *
                                    9) /
                                int.parse(
                                    widget.food.servings?[0].calories ?? "1") *
                                100)
                            .round(),
                        const Color(0xFFDDF235): ((double.parse(
                                        widget.food.servings?[0].protein ??
                                            "1") *
                                    4) /
                                int.parse(
                                    widget.food.servings?[0].calories ?? "1") *
                                100)
                            .round()
                      },
                      height: 100,
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
                                  '${controller.getTotalCalByServings(int.parse(widget.food.servings?[0].calories ?? "1"))}',
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
                              "${controller.getTotalCarbsByServings(num.parse(widget.food.servings?[0].carbohydrate ?? "1")).toInt()} ${widget.food.servings?[0].metricServingUnit ?? "g"}",
                          consumed:
                              "${((num.parse(widget.food.servings?[0].carbohydrate ?? "1") * 4) / int.parse(widget.food.servings?[0].calories ?? "1") * 100).round()}% "),
                      NutrtionProgressModel(
                          name: 'Fat',
                          color: const Color(0xFFF5D25D),
                          total:
                              "${controller.getTotalFatByServings(num.parse(widget.food.servings?[0].fat ?? "1")).toInt()} ${widget.food.servings?[0].metricServingUnit ?? "g"}",
                          consumed:
                              "${((num.parse(widget.food.servings?[0].fat ?? "1") * 9) / int.parse(widget.food.servings?[0].calories ?? "1") * 100).round()}% "),
                      NutrtionProgressModel(
                          name: 'Protein',
                          color: const Color(0xFFDDF235),
                          total:
                              "${controller.getTotalProteinByServings(num.parse(widget.food.servings?[0].protein ?? "1")).toInt()} ${widget.food.servings?[0].metricServingUnit ?? "g"}",
                          consumed:
                              "${((num.parse(widget.food.servings?[0].protein ?? "1") * 4) / int.parse(widget.food.servings?[0].calories ?? "1") * 100).round()}% "),
                    ],
                    backgroundColor: Colors.transparent,
                  );
                }),
                SearchHistoryItem(
                    title: 'Show nutrient facts',
                    description: "",
                    callback: () {
                      Get.to(() => NutrientFactScreen(
                            servings: widget.food.servings![0],
                          ));
                    }),
                15.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: LiveWellTextField(
                        controller: controller.servingSize,
                        hintText: null,
                        labelText: "Serving Size",
                        errorText: null,
                        obscureText: false,
                        enabled: false,
                      ),
                    ),
                    Expanded(
                      child: LiveWellTextField(
                        controller: controller.numberOfServing,
                        keyboardType: TextInputType.number,
                        hintText: null,
                        labelText: "Serving Size",
                        errorText: null,
                        obscureText: false,
                        enabled: true,
                      ),
                    )
                  ],
                ),
                15.verticalSpace,
                InkWell(
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
                                      'Time',
                                      style: TextStyle(
                                          color: const Color(0xFF171433),
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      height: 274.h,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.time,
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
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 2,
                                                    color:
                                                        const Color(0xFF171433)
                                                            .withOpacity(0.7)),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF171433),
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          flex: 2,
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF8F01DF),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                              ),
                                              onPressed: () {
                                                controller.time.text =
                                                    DateFormat('hh:mm a')
                                                        .format(selectedTime);
                                                Get.back();
                                              },
                                              child: Text(
                                                'Save',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
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
                        labelText: "time",
                        errorText: null,
                        obscureText: false,
                        enabled: false,
                      ),
                    )),
                15.verticalSpace,
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
                                Text(
                                    "${controller.percentOfDailyGoals(int.parse(widget.food.servings?[0].calories ?? "0"))}% of your daily goals",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600)),
                                const Spacer(),
                                Text(
                                    ("${widget.food.servings?[0].calories ?? "1"} cal"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            7.verticalSpace,
                            LinearPercentIndicator(
                              padding: EdgeInsets.zero,
                              lineHeight: 7.0,
                              percent: controller.percentOfDailyGoals(int.parse(
                                      widget.food.servings?[0].calories ??
                                          "0")) /
                                  100,
                              barRadius: const Radius.circular(4.0),
                              backgroundColor: const Color(0xFFF2F1F9),
                              progressColor: const Color(0xFFDDF235),
                            )
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
                            color: const Color(0xFF8F01DF),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
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
