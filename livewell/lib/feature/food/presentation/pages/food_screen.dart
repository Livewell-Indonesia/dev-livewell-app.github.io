import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/diary/domain/entity/user_meal_history_model.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
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
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: 'Food'.tr,
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
                              text: 'Today you have consumed '.tr,
                              style: TextStyles.titleHiEm(color: Colors.black),
                            ),
                            TextSpan(
                                text: "${controller.getTotalCal().value} Cal",
                                style: TextStyles.titleHiEm(
                                    color: const Color(0xFF8F01DF)))
                          ]));
                    })),
                const SizedBox(height: 20),
                Center(child: Obx(() {
                  return NutritionCircularProgress(
                    firstValue: Get.find<FoodController>()
                        .percentageOfDailyGoals()
                        .value
                        .toDouble(),
                    secondValue: (controller.getPercentMicroNut().value * 100),
                    thirdValue: (controller.getPercentMacroNut().value * 100),
                  );
                })),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.all(16.0).r,
                    child: NutritionProgressDescription(
                      data: [
                        NutrtionProgressModel(
                            name: 'Macro Nut',
                            color: const Color(0xFF34EAB2),
                            total: '',
                            consumed:
                                "${(controller.getPercentMacroNut().value * 100).round()}%"),
                        NutrtionProgressModel(
                            name: 'Micro Nut',
                            color: const Color(0xFF8F01DF),
                            total: '',
                            consumed:
                                "${(controller.getPercentMicroNut().value * 100).round()}%"),
                        NutrtionProgressModel(
                            name: 'Total Cal',
                            color: const Color(0xFFDDF235),
                            total: '',
                            consumed:
                                '${Get.find<FoodController>().percentageOfDailyGoals().value}%'),
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
                                leadingImage:
                                    MealTime.values[index].leadingImage(),
                                data: controller.mealHistory
                                    .where((p0) =>
                                        p0.mealType?.toUpperCase() ==
                                        MealTime.values[index].name
                                            .toUpperCase())
                                    .toList(),
                                onTap: () {
                                  AppNavigator.push(
                                      routeName: AppPages.addMeal,
                                      arguments: {
                                        "type": MealTime.values[index].name,
                                        "date": DateTime.now()
                                      });
                                },
                                onUpdate: (indexs, size) {
                                  controller.onUpdateTapped(
                                      MealTime.values[index], indexs, size);
                                },
                                onDelete: (item) {
                                  controller.onDeleteHistory(
                                      MealTime.values[index], item);
                                },
                              );
                            });
                          },
                          separatorBuilder: (context, index) {
                            return 8.verticalSpace;
                          },
                          itemCount: MealTime.values.length);
                })
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

  NutrtionProgressModel(
      {required this.name,
      required this.color,
      required this.total,
      required this.consumed});
}

class NutritionProgressDescription extends StatelessWidget {
  final List<NutrtionProgressModel> data;
  final Color backgroundColor;
  final Color? dividerColor;
  const NutritionProgressDescription(
      {Key? key,
      required this.data,
      this.backgroundColor = Colors.white,
      this.dividerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(16.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
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
                    return nutritionDescription(
                        color: data[index].color,
                        name: data[index].name,
                        total: data[index].total,
                        consumed: data[index].consumed);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: dividerColor,
                    );
                  },
                  itemCount: data.length),
            ),
          ),
        ],
      ),
    );
  }

  Padding nutritionDescription(
      {required Color color,
      required String name,
      required String total,
      required String consumed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(4.0))),
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

  const NutritionCircularProgress(
      {Key? key,
      required this.firstValue,
      required this.secondValue,
      required this.thirdValue})
      : super(key: key);

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
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Constant.icCalories),
                          Text(
                            '${Get.find<FoodController>().percentageOfDailyGoals().value}%',
                            style: TextStyles.titleHiEm(color: Colors.black),
                          ),
                          Text(
                            'of daily goals'.tr,
                            style: TextStyles.body(color: AppColors.textLoEm),
                          )
                        ],
                      ),
                    );
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

  const ButtonAddMeal({Key? key, required this.type, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 21.0),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
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
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
        return 'Breakfast'.tr;
      case MealTime.lunch:
        return 'Lunch'.tr;
      case MealTime.dinner:
        return 'Dinner'.tr;
      case MealTime.snack:
        return 'Snack'.tr;
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
    return 'Add '.tr + text();
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

final customWidth01 = CustomSliderWidths(trackWidth: 4, progressBarWidth: 12);
final customColors01 = CustomSliderColors(
    dotColor: Colors.transparent,
    trackColor: Colors.white,
    progressBarColor: const Color(0xFFDDF235),
    hideShadow: true);

final CircularSliderAppearance appearance01 = CircularSliderAppearance(
    customWidths: customWidth01,
    customColors: customColors01,
    startAngle: 270,
    angleRange: 360,
    size: 282.0,
    animationEnabled: true);

final customWidth02 = CustomSliderWidths(trackWidth: 4, progressBarWidth: 12);
final customColors02 = CustomSliderColors(
    dotColor: Colors.transparent,
    trackColor: Colors.white,
    progressBarColor: const Color(0xFF8F01DF),
    hideShadow: true);

final CircularSliderAppearance appearance02 = CircularSliderAppearance(
    customWidths: customWidth02,
    customColors: customColors02,
    startAngle: 270,
    angleRange: 360,
    size: 242.0,
    animationEnabled: true);

final customWidth03 = CustomSliderWidths(trackWidth: 4, progressBarWidth: 12);
final customColors03 = CustomSliderColors(
    dotColor: Colors.transparent,
    trackColor: Colors.white,
    progressBarColor: const Color(0xFF34EAB2),
    hideShadow: true);

final CircularSliderAppearance appearance03 = CircularSliderAppearance(
    customWidths: customWidth03,
    customColors: customColors03,
    startAngle: 270,
    angleRange: 360,
    size: 198.0,
    animationEnabled: true);

class ExpandableDiaryItemV2 extends StatelessWidget {
  final String title;
  final String leadingImage;
  final List<MealHistoryModel> data;
  final VoidCallback onTap;
  final void Function(int) onDelete;
  final void Function(int index, double value) onUpdate;
  const ExpandableDiaryItemV2(
      {Key? key,
      required this.title,
      required this.leadingImage,
      required this.data,
      required this.onTap,
      required this.onUpdate,
      required this.onDelete})
      : super(key: key);

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
                  bottomLeft: data.isNotEmpty
                      ? Radius.circular(0.r)
                      : Radius.circular(30.r),
                  bottomRight: data.isNotEmpty
                      ? Radius.circular(0.r)
                      : Radius.circular(30.r),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
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
                    style: TextStyle(
                        color: const Color(0xFF505050),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  8.horizontalSpace,
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '${getTotalCal(data)} cal',
                        style: TextStyle(
                            color: const Color(0xFF8F01DF),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
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
