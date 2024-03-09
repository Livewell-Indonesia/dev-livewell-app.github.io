import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/helper/get_meal_type_by_current_time.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/food/presentation/controller/add_food_controller.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/feature/food/presentation/pages/food_screen.dart';
import 'package:livewell/feature/nutrico/presentation/widget/nutri_score_plus_bottom_sheet.dart';
import 'package:livewell/feature/profile/presentation/page/user_settings_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/widgets/chart/circular_nutrition.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/livewell_textfield.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../data/model/foods_model.dart';
import 'nutrient_fact_screen.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final AddFoodController controller = Get.put(AddFoodController());
  DateTime selectedTime = DateTime.now();
  File? file;
  Foods? food;
  MealTime? mealTime;
  String? imageUrl;

  @override
  void initState() {
    controller.servingSize.text = food?.servings?[0].servingDescription ?? "";
    controller.numberOfServing.text = double.parse(food?.servings?[0].numberOfUnits ?? "1.0").toInt().toString();
    controller.selectedTime.value = selectedTime.toString();
    controller.time.text = DateFormat('hh:mm a').format(selectedTime);
    if (Get.arguments != null) {
      selectedTime = Get.arguments['date'] as DateTime;
      controller.selectedTime.value = selectedTime.toString();
      controller.time.text = DateFormat('hh:mm a').format(selectedTime);
      food = Get.arguments['food'];
      mealTime = Get.arguments['mealTime'];
      imageUrl = Get.arguments['imageUrl'];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Add Food',
        customTitleWidget: customTitleWidget(context),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              child: const Icon(Icons.edit_outlined),
              onTap: () {
                AppNavigator.push(routeName: AppPages.nutriCoScreen, arguments: {'type': getMealTypeByCurrentTime().name, 'date': DateTime.now(), 'name': food?.foodName ?? ""});
              },
            ),
            16.horizontalSpace,
            InkWell(
              child: const Icon(Icons.ios_share),
              onTap: () async {
                await showModalBottomSheet(
                    context: context,
                    shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                    builder: (context) {
                      return ImagePickerBottomSheet(onImageSelected: (img) async {
                        setState(() {
                          file = img;
                        });
                        await showModalBottomSheet(
                            context: Get.context!,
                            shape: ShapeBorder.lerp(const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))), 1),
                            builder: (context) {
                              return SizedBox(
                                height: 0.2.sh,
                                child: Column(
                                  children: [
                                    20.verticalSpace,
                                    Text(
                                      'Pick an Image Ratio:',
                                      style: TextStyle(color: const Color(0xff171433), fontSize: 24.sp, fontWeight: FontWeight.w700),
                                    ),
                                    20.verticalSpace,
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  AppNavigator.push(routeName: AppPages.selectTemplateShareFood, arguments: {'file': file, 'food': food, 'aspectRatio': 9 / 16});
                                                },
                                                child: const Text('16:9')),
                                          ),
                                          20.horizontalSpace,
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  AppNavigator.push(routeName: AppPages.selectTemplateShareFood, arguments: {'file': file, 'food': food, 'aspectRatio': 1 / 1});
                                                },
                                                child: const Text('1:1')),
                                          ),
                                        ],
                                      ),
                                    ),
                                    30.verticalSpace,
                                  ],
                                ),
                              );
                            });
                      });
                    });
              },
            ),
          ],
        ),
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.verticalSpace,
                Padding(
                    padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
                    child: Text(
                      food?.foodName ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Colors.black),
                    )),
                //8.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 16.0.w),
                  child: Text("${food?.servings?.first.servingDescription ?? ""} ${food?.servings?.first.servingDesc ?? ""}",
                      style: TextStyle(color: const Color(0xFF171433).withOpacity(0.8), fontSize: 14.sp, fontWeight: FontWeight.w600)),
                ),
                8.verticalSpace,
                (imageUrl != null)
                    ? Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            height: 200.h,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(imageUrl!),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r), bottomRight: Radius.circular(20.r)), color: Colors.white.withOpacity(0.6)),
                              child: Row(
                                children: [
                                  CustomBar(
                                    value1:
                                        (controller.maxHundred((num.parse(food?.servings?[0].carbohydrate ?? "0") * 4) / num.parse(food?.servings?[0].calories ?? "0") * 100).roundZero()).toDouble(),
                                    value2: (controller.maxHundred((num.parse(food?.servings?[0].fat ?? "0") * 9) / num.parse(food?.servings?[0].calories ?? "0") * 100).roundZero()).toDouble(),
                                    value3: (controller.maxHundred((num.parse(food?.servings?[0].protein ?? "0") * 4) / num.parse(food?.servings?[0].calories ?? "0") * 100).roundZero()).toDouble(),
                                    maxValue: 230.w,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${controller.getTotalCalByServings(num.parse(food?.servings?[0].calories ?? "0")).round().toInt()} cal',
                                    style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: MultipleColorCircle(
                            colorOccurrences: {
                              const Color(0xFF8F01DF): ((((double.parse(food?.servings?[0].carbohydrate ?? "0")) * 4) / double.parse(food?.servings?[0].calories ?? "0") * 100).roundZero()),
                              const Color(0xFFF5D25D): (((double.parse(food?.servings?[0].fat ?? "0") * 9) / double.parse(food?.servings?[0].calories ?? "0") * 100).roundZero()),
                              const Color(0xFFDDF235): (((double.parse(food?.servings?[0].protein ?? "0") * 4) / double.parse(food?.servings?[0].calories ?? "0") * 100).roundZero())
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
                                    GetBuilder<AddFoodController>(builder: (controller) {
                                      return Text(
                                        '${controller.getTotalCalByServings(num.parse(food?.servings?[0].calories ?? "0")).round().toInt()}',
                                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: const Color(0xFF171433)),
                                      );
                                    }),
                                    Text(
                                      'Cal',
                                      style: TextStyle(fontSize: 11.sp, color: const Color(0xFF171433)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GetBuilder<AddFoodController>(builder: (controller) {
                    return NutritionProgressDescription(
                      isFromNutricoPlus: true,
                      data: [
                        NutrtionProgressModel(
                            name: 'Carbs',
                            color: const Color(0xFF34EAB2),
                            total: "${controller.getTotalCarbsByServings(num.parse(food?.servings?[0].carbohydrate ?? "0")).toInt()} ${food?.servings?[0].metricServingUnit ?? "g"}",
                            consumed: "${(controller.maxHundred((num.parse(food?.servings?[0].carbohydrate ?? "0") * 4) / num.parse(food?.servings?[0].calories ?? "0") * 100).roundZero())}% ",
                            percentage: 0),
                        NutrtionProgressModel(
                            name: 'Fat',
                            color: const Color(0xFF8F01DF),
                            total: "${controller.getTotalFatByServings(num.parse(food?.servings?[0].fat ?? "0")).toInt()} ${food?.servings?[0].metricServingUnit ?? "g"}",
                            consumed: "${(controller.maxHundred((num.parse(food?.servings?[0].fat ?? "0") * 9) / num.parse(food?.servings?[0].calories ?? "0") * 100).roundZero())}% ",
                            percentage: 0),
                        NutrtionProgressModel(
                            name: 'Protein',
                            color: const Color(0xFFDDF235),
                            total: "${controller.getTotalProteinByServings(num.parse(food?.servings?[0].protein ?? "0")).toInt()} ${food?.servings?[0].metricServingUnit ?? "g"}",
                            consumed: "${(controller.maxHundred((num.parse(food?.servings?[0].protein ?? "0") * 4) / num.parse(food?.servings?[0].calories ?? "0") * 100).roundZero())}% ",
                            percentage: 0),
                      ],
                      backgroundColor: Colors.transparent,
                      dividerColor: const Color(0xFFEBEBEB),
                      servings: food!.servings![0],
                      numberOfServings: double.parse(controller.numberOfServing.text),
                    );
                  }),
                ),
                15.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: LiveWellTextField(
                          controller: controller.numberOfServing,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20).r,
                                        height: 380.h,
                                        child: Column(
                                          children: [
                                            Text(
                                              controller.localization.time!,
                                              style: TextStyle(color: const Color(0xFF171433), fontSize: 18.sp, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 274.h,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode.time,
                                                onDateTimeChanged: (time) {
                                                  if (Get.arguments != null) {
                                                    selectedTime = DateTime(selectedTime.year, selectedTime.month, selectedTime.day, time.hour, time.minute);
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
                                                        side: BorderSide(width: 2, color: const Color(0xFF171433).withOpacity(0.7)),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20.r),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        controller.localization.cancel!,
                                                        style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w500),
                                                      )),
                                                ),
                                                const Spacer(),
                                                Expanded(
                                                  flex: 2,
                                                  child: TextButton(
                                                      style: TextButton.styleFrom(
                                                        backgroundColor: const Color(0xFF8F01DF),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20.r),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        controller.time.text = DateFormat('hh:mm a').format(selectedTime);
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        controller.localization.save!,
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
                24.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 76.h,
                  margin: const EdgeInsets.symmetric(horizontal: 16).r,
                  padding: const EdgeInsets.only(top: 20, bottom: 20, left: 24, right: 15).r,
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
                                        "${controller.percentOfDailyGoals(controller.getTotalCalByServings(num.parse(food?.servings?[0].calories ?? "0")).round().toInt())}% ${controller.localization.ofYourGoal}",
                                        style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w600));
                                  }),
                                ),
                                const Spacer(),
                                GetBuilder<AddFoodController>(builder: (controller) {
                                  return Text(("${controller.getTotalCalByServings(num.parse(food?.servings?[0].calories ?? "0")).round().toInt()} cal"),
                                      style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w600));
                                }),
                              ],
                            ),
                            7.verticalSpace,
                            GetBuilder<AddFoodController>(builder: (controller) {
                              return LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                lineHeight: 7.0,
                                percent: controller.percentOfDailyGoals(controller.getTotalCalByServings(num.parse(food?.servings?[0].calories ?? "0")).round().toInt()) / 100,
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
                          controller.selectedTime.value = selectedTime.toString();
                          controller.addMeals(food!, mealTime!);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7).r,
                          height: 33.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDF235),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: Text(
                              controller.localization.submit!,
                              style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500),
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

  InkWell customTitleWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: shapeBorder(),
            builder: (context) {
              return Container(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: MealTime.values.map((e) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            mealTime = e;
                          });
                          Get.back();
                        },
                        title: Text(
                          e.text(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF505050),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            });
      },
      child: Row(
        children: [
          Text(
            mealTime?.text() ?? "",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          8.horizontalSpace,
          Icon(Icons.keyboard_arrow_down_sharp, size: 24.sp, color: const Color(0xFF171433)),
        ],
      ),
    );
  }
}

extension CustomRounder on double {
  int roundZero() {
    return this == 0 || isNaN || isInfinite ? 0 : round();
  }
}

class CustomBar extends StatelessWidget {
  final double value1;
  final double value2;
  final double value3;
  final double maxValue;

  CustomBar({
    required this.value1,
    required this.value2,
    required this.value3,
    this.maxValue = 230,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxValue,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFDDF235),
              borderRadius: BorderRadius.circular(8.r),
            ),
            width: (value3 / 100) * maxValue,
            height: 8.h,
          ),
          Positioned(
            right: ((value3 / 100) * maxValue) - 4.w,
            child: Container(
              width: (value2 / 100) * maxValue,
              height: 8.h,
              decoration: BoxDecoration(
                color: const Color(0xFF8F01DF),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          Positioned(
            right: (((value3 / 100) * maxValue) + ((value2 / 100) * maxValue)) - 9.w,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF34EAB2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              width: (value1 / 100) * maxValue,
              height: 8.h,
            ),
          ),
        ],
      ),
    );
  }
}
