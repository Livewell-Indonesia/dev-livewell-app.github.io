import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/constant/constant.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/food/presentation/pages/add_meal_screen.dart';
import 'package:livewell/routes/app_navigator.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/horizontal_picker/horizontal_picker.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../widgets/scaffold/livewell_scaffold.dart';
import '../controller/food_controller.dart';

class FoodScreen extends StatefulWidget {
  FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final FoodController controller = Get.put(FoodController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: 'Food',
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
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Today you have consumed ',
                            style: TextStyles.titleHiEm(color: Colors.black),
                          ),
                          TextSpan(
                              text:
                                  "${controller.dashboardData.value.dashboard?.caloriesTaken.toString()} Cal",
                              style: TextStyles.titleHiEm(color: Colors.orange))
                        ]))),
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
                            name: 'Macro nut',
                            color: const Color(0xFF34EAB2),
                            total: "",
                            consumed:
                                "${(controller.getPercentMacroNut().value * 100).round()}%"),
                        NutrtionProgressModel(
                            name: 'Micro nut',
                            color: const Color(0xFF8F01DF),
                            total: "",
                            consumed:
                                "${(controller.getPercentMicroNut().value * 100).round()}%"),
                        NutrtionProgressModel(
                            name: 'Total Cal',
                            color: const Color(0xFFDDF235),
                            total: "",
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
                              return ExpandableDiaryItem(
                                title: MealTime.values[index].appBarTitle(),
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
                            return 10.verticalSpace;
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
  List<NutrtionProgressModel> data;
  Color backgroundColor;
  Color? dividerColor;
  NutritionProgressDescription(
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
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 46,
            child: Container(
              child: Text(
                name,
                style: TextStyles.body(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 46,
            child: Container(
              child: Text(
                total,
                style: TextStyles.body(color: Colors.black),
              ),
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
                            'of daily goals',
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
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 21.0),
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
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
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
        return 'Breakfast';
      case MealTime.lunch:
        return 'Lunch';
      case MealTime.dinner:
        return 'Dinner';
      case MealTime.snack:
        return 'Snack';
    }
  }

  String appBarTitle() {
    return 'Add ${text()}';
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
    progressBarColor: Color(0xFFDDF235),
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
    progressBarColor: Color(0xFF8F01DF),
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
    progressBarColor: Color(0xFF34EAB2),
    hideShadow: true);

final CircularSliderAppearance appearance03 = CircularSliderAppearance(
    customWidths: customWidth03,
    customColors: customColors03,
    startAngle: 270,
    angleRange: 360,
    size: 198.0,
    animationEnabled: true);
