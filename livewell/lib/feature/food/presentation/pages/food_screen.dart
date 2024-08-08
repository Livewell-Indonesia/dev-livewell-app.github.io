import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/food/presentation/pages/add_food_screen.dart';
import 'package:livewell/feature/food/presentation/pages/nutrient_fact_screen.dart';
import 'package:livewell/feature/home/controller/home_controller.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/banner/nutriscore_banner.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../widgets/scaffold/livewell_scaffold.dart';
import '../controller/food_controller.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final FoodController controller = Get.put(FoodController());

  @override
  void initState() {
    controller.trackEvent(LivewellNutritionEvent.nutritionPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: controller.localization.nutritionPage?.nutrition ?? "Nutrition",
      body: Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.onInit();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(() {
                      return RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: controller.localization.nutritionPage?.todayYouHaveConsumed ?? "Today you have consumed ",
                              style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w600),
                            ),
                            TextSpan(text: "${controller.getTotalCal().value} Cal", style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 20.sp, fontWeight: FontWeight.w600))
                          ]));
                    })),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0).r,
                  child: Container(
                    padding: EdgeInsets.only(right: 20.w, top: 20.h, bottom: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        20.horizontalSpace,
                        Center(
                          child: Obx(() {
                            return NutritionCircularProgress(
                              firstValue: controller.getPercentageProtein().value,
                              secondValue: controller.getPercentageCarbs().value,
                              thirdValue: controller.getPercentageFat().value,
                            );
                          }),
                        ),
                        20.horizontalSpace,
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8.w,
                                        height: 8.w,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF8122D2)),
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        controller.localization.nutritionPage?.protein ?? "Protein",
                                        style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  trailing: Obx(() {
                                    return RichText(
                                        text: TextSpan(children: [
                                      TextSpan(text: controller.getConsumedProtein().value.toString(), style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: ' ${controller.localization.nutritionPage?.of ?? "of"} ${controller.getTargetProtein().value.toString()}',
                                          style: TextStyle(color: const Color(0xFF808080), fontSize: 14.sp, fontWeight: FontWeight.w400)),
                                    ]));
                                  }),
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8.w,
                                        height: 8.w,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFE15E2C)),
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        controller.localization.nutritionPage?.carbs ?? "Carbs",
                                        style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  trailing: Obx(() {
                                    return RichText(
                                        text: TextSpan(children: [
                                      TextSpan(text: controller.getConsumedCarbs().value.toString(), style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: ' ${controller.localization.nutritionPage?.of ?? "of"} ${controller.getTargetCarbs().value.toString()}',
                                          style: TextStyle(color: const Color(0xFF808080), fontSize: 14.sp, fontWeight: FontWeight.w400)),
                                    ]));
                                  }),
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8.w,
                                        height: 8.w,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF34EAB2)),
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        controller.localization.nutritionPage?.fat ?? "Fat",
                                        style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  trailing: Obx(() {
                                    return RichText(
                                        text: TextSpan(children: [
                                      TextSpan(text: controller.getConsumedFat().value.toString(), style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: ' ${controller.localization.nutritionPage?.of ?? "of"} ${controller.getTargetFat().value.toString()}',
                                          style: TextStyle(color: const Color(0xFF808080), fontSize: 14.sp, fontWeight: FontWeight.w400)),
                                    ]));
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0).r,
                  child: Obx(() {
                    return InkWell(
                      onTap: () {
                        controller.trackEvent(LivewellNutritionEvent.nutritionPageNutriscoreButton);
                        AppNavigator.push(routeName: AppPages.nutriScore);
                      },
                      child: NutriscoreBanner(value: (Get.find<DashboardController>().nutriScore.value.totalPoints ?? 0).toInt()),
                    );
                  }),
                ),
                20.verticalSpace,
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
                    child: NutritionProgressDescription(
                      data: [
                        NutrtionProgressModel(name: 'Macro Nut', color: const Color(0xFF34EAB2), total: '', consumed: "${(controller.getPercentMacroNut().value * 100).round()}%"),
                        NutrtionProgressModel(name: 'Micro Nut', color: const Color(0xFF8F01DF), total: '', consumed: "${(controller.getPercentMicroNut().value * 100).round()}%"),
                        NutrtionProgressModel(name: 'Total Cal', color: const Color(0xFFDDF235), total: '', consumed: '${Get.find<FoodController>().percentageOfDailyGoals().value}%'),
                      ],
                    ),
                  );
                }),
                Obx(() {
                  return controller.isLoadingHistory.value
                      ? Container()
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return ExpandableDiaryItemV2(
                                title: MealTime.values[index].text(),
                                leadingImage: MealTime.values[index].leadingImage(),
                                data: controller.mealHistory.where((p0) => p0.mealType?.toUpperCase() == MealTime.values[index].name.toUpperCase()).toList(),
                                onTap: () {
                                  controller.trackEvent(LivewellNutritionEvent.nutritionPageAddMealLogButton);
                                  AppNavigator.push(routeName: AppPages.addMeal, arguments: {"type": MealTime.values[index].name, "date": DateTime.now()});
                                },
                                onUpdate: (indexs, size) {
                                  controller.trackEvent(LivewellNutritionEvent.nutritionPageUpdateMealButton, properties: {"mealType": MealTime.values[index].name});
                                  controller.onUpdateTapped(MealTime.values[index], indexs, size);
                                },
                                onDelete: (item) {
                                  controller.trackEvent(LivewellNutritionEvent.nutritionPageDeleteMealButton, properties: {"mealType": MealTime.values[index].name});
                                  controller.onDeleteHistory(MealTime.values[index], item);
                                },
                              );
                            });
                          },
                          separatorBuilder: (context, index) {
                            return 8.verticalSpace;
                          },
                          itemCount: MealTime.values.length);
                }),
                40.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NutrtionProgressModel {
  final String name;
  final Color color;
  final String total;
  final String consumed;
  final double percentage;

  NutrtionProgressModel({required this.name, required this.color, required this.total, required this.consumed, this.percentage = 0});
}

class NutritionProgressDescription extends StatelessWidget {
  final List<NutrtionProgressModel> data;
  final Color backgroundColor;
  final Color? dividerColor;
  final bool isFromNutricoPlus;
  final int? calories;
  final Servings? servings;
  final double? numberOfServings;
  const NutritionProgressDescription(
      {Key? key, required this.data, this.backgroundColor = Colors.white, this.dividerColor, this.isFromNutricoPlus = false, this.calories, this.servings, this.numberOfServings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.0.h),
      decoration: BoxDecoration(color: isFromNutricoPlus ? Colors.white : backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(16.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isFromNutricoPlus)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomBar(
                      value1: data[0].percentage,
                      value2: data[1].percentage,
                      value3: data[2].percentage,
                      maxValue: 230,
                    ),
                    16.horizontalSpace,
                    Text(
                      '$calories cal',
                      style: TextStyle(color: const Color(0xFF171433), fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                8.verticalSpace,
                Divider(
                  color: dividerColor,
                ),
              ],
            ),
          LimitedBox(
            maxHeight: 164.h,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return nutritionDescription(color: data[index].color, name: data[index].name, total: data[index].total, consumed: data[index].consumed);
                  },
                  separatorBuilder: (context, index) {
                    return Container();
                  },
                  itemCount: data.length),
            ),
          ),
          if (isFromNutricoPlus)
            Column(
              children: [
                Divider(
                  color: dividerColor,
                ),
                8.verticalSpace,
                InkWell(
                  onTap: () {
                    Get.to(() => NutrientFactScreen(
                          servings: servings!,
                          numberOfServings: double.parse(numberOfServings.toString()),
                        ));
                  },
                  child: Row(
                    children: [
                      Text(
                        Get.find<DashboardController>().localization.nutritionPage?.showNutrientFacts ?? "Show Nutrient Facts",
                        style: TextStyle(color: const Color(0xFF505050), fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  Padding nutritionDescription({required Color color, required String name, required String total, required String consumed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(4.0))),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 46,
            child: Text(
              name,
              style: TextStyles.body(color: Colors.black),
            ),
          ),
          Expanded(
            flex: 46,
            child: Text(
              total,
              style: TextStyles.body(color: Colors.black),
            ),
          ),
          Expanded(
            flex: 20,
            child: Text(
              consumed,
              style: TextStyles.body(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}

class NutritionCircularProgress extends StatelessWidget {
  final double firstValue;
  final double secondValue;
  final double thirdValue;

  const NutritionCircularProgress({Key? key, required this.firstValue, required this.secondValue, required this.thirdValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: appearance01,
      min: 0,
      max: 100,
      initialValue: firstValue,
      innerWidget: (double value) {
        return Align(
          alignment: Alignment.center,
          child: SleekCircularSlider(
            appearance: appearance02,
            min: 0,
            max: 100,
            initialValue: secondValue,
            innerWidget: (double value) {
              return Align(
                alignment: Alignment.center,
                child: SleekCircularSlider(
                  appearance: appearance03,
                  min: 0,
                  max: 100,
                  initialValue: thirdValue,
                  innerWidget: (double value) {
                    return Container();
                    // return Center(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SvgPicture.asset(
                    //         Constant.icCalories,
                    //         width: 14.w,
                    //         height: 18.h,
                    //       ),
                    //       Text(
                    //           '${Get.find<FoodController>().percentageOfDailyGoals().value}%',
                    //           style: TextStyle(
                    //               color: const Color(0xFF171433),
                    //               fontSize: 24.sp,
                    //               fontWeight: FontWeight.w600)),
                    //       Text(
                    //         Get.find<HomeController>().localization.ofYourGoal!,
                    //         style: TextStyle(
                    //             color: Color(0xFF171433),
                    //             fontSize: 12.sp,
                    //             fontWeight: FontWeight.w500),
                    //       )
                    //     ],
                    //   ),
                    // );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ButtonAddMeal extends StatelessWidget {
  final MealTime type;
  final VoidCallback callback;

  const ButtonAddMeal({Key? key, required this.type, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 21.0),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16.0))),
          child: Row(
            children: [
              icons(),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  type.text(),
                  style: TextStyles.body(color: Colors.black),
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
              //create rounded button
            ],
          ),
        ),
      ),
    );
  }

  Widget icons() {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Image.asset(type.icon()),
    );
  }
}

enum MealTime {
  breakfast,
  lunch,
  dinner,
  snack,
}

extension MealTimeAttribute on MealTime {
  String text() {
    switch (this) {
      case MealTime.breakfast:
        return Get.find<HomeController>().localization.nutritionPage?.breakfast ?? "Breakfast";
      case MealTime.lunch:
        return Get.find<HomeController>().localization.nutritionPage?.lunch ?? "Lunch";
      case MealTime.dinner:
        return Get.find<HomeController>().localization.nutritionPage?.dinner ?? "Dinner";
      case MealTime.snack:
        return Get.find<HomeController>().localization.nutritionPage?.snack ?? "Snack";
    }
  }

  String leadingImage() {
    switch (this) {
      case MealTime.breakfast:
        return Constant.icBreakfast;
      case MealTime.lunch:
        return Constant.icLunch;
      case MealTime.dinner:
        return Constant.icDinner;
      case MealTime.snack:
        return Constant.icSnack;
    }
  }

  String appBarTitle() {
    return (Get.find<HomeController>().localization.addFoodPage?.add ?? "Add") + text();
  }

  String icon() {
    switch (this) {
      case MealTime.breakfast:
        return Constant.icBreakfast;
      case MealTime.lunch:
        return Constant.icLunch;
      case MealTime.dinner:
        return Constant.icDinner;
      case MealTime.snack:
        return Constant.icSnack;
    }
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

final customWidth01 = CustomSliderWidths(trackWidth: 1, progressBarWidth: 8);
final customColors01 = CustomSliderColors(dotColor: Colors.transparent, trackColor: const Color(0xFFEBEBEB), progressBarColor: const Color(0xFF8122D2), hideShadow: true);

final CircularSliderAppearance appearance01 =
    CircularSliderAppearance(customWidths: customWidth01, customColors: customColors01, startAngle: 270, angleRange: 360, size: 132.0, animationEnabled: true);

final customWidth02 = CustomSliderWidths(trackWidth: 1, progressBarWidth: 8);
final customColors02 = CustomSliderColors(dotColor: Colors.transparent, trackColor: const Color(0xFFEBEBEB), progressBarColor: const Color(0xFFE15E2C), hideShadow: true);

final CircularSliderAppearance appearance02 = CircularSliderAppearance(customWidths: customWidth02, customColors: customColors02, startAngle: 270, angleRange: 360, size: 92.0, animationEnabled: true);

final customWidth03 = CustomSliderWidths(trackWidth: 1, progressBarWidth: 8);
final customColors03 = CustomSliderColors(dotColor: Colors.transparent, trackColor: const Color(0xFFEBEBEB), progressBarColor: const Color(0xFF34EAB2), hideShadow: true);

final CircularSliderAppearance appearance03 = CircularSliderAppearance(customWidths: customWidth03, customColors: customColors03, startAngle: 270, angleRange: 360, size: 48.0, animationEnabled: true);

class ExpandableDiaryItemV2 extends StatelessWidget {
  final String title;
  final String leadingImage;
  final List<MealHistoryModel> data;
  final VoidCallback onTap;
  final void Function(int) onDelete;
  final void Function(int index, double value) onUpdate;
  const ExpandableDiaryItemV2({Key? key, required this.title, required this.leadingImage, required this.data, required this.onTap, required this.onUpdate, required this.onDelete}) : super(key: key);

  num getTotalCal(List<MealHistoryModel> mealHistory) {
    num totalCal = 0;
    for (var element in mealHistory) {
      totalCal += element.caloriesInG!;
    }
    if (totalCal > 0) {
      totalCal = (totalCal).round();
    }
    return totalCal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 72.h,
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                  bottomLeft: data.isNotEmpty ? Radius.circular(0.r) : Radius.circular(30.r),
                  bottomRight: data.isNotEmpty ? Radius.circular(0.r) : Radius.circular(30.r),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(leadingImage),
                  ),
                  16.horizontalSpace,
                  Text(
                    title,
                    style: TextStyle(color: const Color(0xFF505050), fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  8.horizontalSpace,
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: '${getTotalCal(data)} cal', style: TextStyle(color: const Color(0xFF8F01DF), fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  ])),
                  const Spacer(),
                  Container(
                    width: 35.w,
                    height: 35.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.add,
                      color: const Color(0xFF171433).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          data.isNotEmpty
              ? Flexible(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 20.h),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, item) {
                      return HistoryContent(
                        onDelete: onDelete,
                        onUpdate: onUpdate,
                        data: data,
                        index: item,
                      );
                    },
                    separatorBuilder: (context, item) {
                      return Padding(
                        padding: EdgeInsets.only(top: 7.5.h, bottom: 7.5.h),
                        child: const Divider(),
                      );
                    },
                    itemCount: data.length,
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
