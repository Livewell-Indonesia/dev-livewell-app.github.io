import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/widgets/picker/ruler_picker.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../core/constant/constant.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final QuestionnaireController controller = Get.put(QuestionnaireController());

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: '',
      backgroundColor: Colors.white,
      body: Expanded(
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          Obx(() {
            return LinearPercentIndicator(
              padding: const EdgeInsets.symmetric(horizontal: 40).r,
              width: MediaQuery.of(context).size.width,
              lineHeight: 7.0,
              percent: (controller.currentPage.value.index + 1) /
                  QuestionnairePage.values.length,
              barRadius: const Radius.circular(4.0),
              backgroundColor: const Color(0xFFF2F1F9),
              progressColor: const Color(0xFFDDF235),
            );
          }),
          Obx(() {
            return QuestionnaireContent(
                currentPage: controller.currentPage.value);
          }),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: ChangePageIndicator(
              controller: controller,
            ),
          ),
          SizedBox(
            height: 65.h,
          )
        ]),
      ),
    );
  }
}

class QuestionnaireContent extends StatelessWidget {
  final QuestionnairePage currentPage;
  final QuestionnaireController controller = Get.find();
  QuestionnaireContent({required this.currentPage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        40.verticalSpace,
        Text(currentPage.title(),
            style: TextStyle(
                fontSize: 24.sp,
                color: const Color(0xFF171433),
                fontWeight: FontWeight.w600)),
        7.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).r,
          child: Text(
            currentPage.subtitle(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF171433).withOpacity(0.7),
                fontWeight: FontWeight.w500),
          ),
        ),
        40.verticalSpace,
        Container(
          child: findContent(),
        ),
      ],
    );
  }

  Widget findContent() {
    switch (currentPage) {
      case QuestionnairePage.gender:
        return GenderSelector();
      case QuestionnairePage.age:
        return AgeSelector();
      case QuestionnairePage.height:
        return HeightSelector();
      case QuestionnairePage.weight:
        return WeightSelector();
      case QuestionnairePage.drink:
        return DrinkSelector();
      case QuestionnairePage.sleep:
        return SleepSelector();
      case QuestionnairePage.dieatary:
        return DietrarySelector();
      case QuestionnairePage.goal:
        return GoalSelector();
      case QuestionnairePage.finish:
        return Text('finish');
    }
  }

  Column weightSelector() {
    return Column(
      children: [
        RulerPicker(
          beginValue: 0,
          endValue: 200,
          onValueChange: (value) {},
          width: 1.sw,
          height: 130,
          marker: Column(
            children: [
              15.verticalSpace,
              Container(
                  height: 74,
                  width: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8F01DF),
                    borderRadius: BorderRadius.circular(10),
                  ))
            ],
          ),
          rulerScaleTextStyle: TextStyle(
              color: const Color(0xFF8F01DF).withOpacity(0.5), fontSize: 16),
          scaleLineStyleList: [
            ScaleLineStyle(
                color: const Color(0xFF8F01DF).withOpacity(0.5),
                width: 5,
                height: 27,
                scale: 0),
            const ScaleLineStyle(
                color: Colors.red, width: 200, height: 13, scale: 10),
            ScaleLineStyle(
                color: const Color(0xFF8F01DF).withOpacity(0.5),
                width: 5,
                height: 15,
                scale: -1),
          ],
        )
      ],
    );
  }
}

class AgeSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  AgeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: DatePickerWidget(
        onMonthChangeStartWithFirstDate: false,
        maxDateTime: DateTime.now(),
        onChange: (dateTime, selectedIndex) {
          controller.date.value = dateTime;
        },
        pickerTheme: DateTimePickerTheme(
          showTitle: false,
        ),
      ),
      // child: CupertinoDatePicker(
      //   mode: CupertinoDatePickerMode.date,
      //   onDateTimeChanged: (value) {
      //     //controller.age.value = value;
      //   },
      // ),
      // child: CupertinoPicker(
      //   itemExtent: 55.h,
      //   onSelectedItemChanged: (index) {
      //     controller.age.value = index + 1;
      //   },
      //   selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
      //     background: Colors.transparent,
      //   ),
      //   useMagnifier: true,
      //   magnification: 1.3,
      //   children: List.generate(
      //     100,
      //     (index) {
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Obx(() {
      //             return Text(
      //               (index + 1).toString(),
      //               style: TextStyle(
      //                   color: controller.age.value == index + 1
      //                       ? Color(0xFF8F01DF)
      //                       : Color(0xFF171433).withOpacity(0.7),
      //                   fontSize: 34.sp),
      //             );
      //           })
      //         ],
      //       );
      //     },
      //   ),
      // ),
    );
  }
}

class ChangePageIndicator extends StatelessWidget {
  final QuestionnaireController controller;

  const ChangePageIndicator({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() {
          return controller.currentPage.value == QuestionnairePage.gender
              ? Container()
              : prevButton();
        }),
        const Spacer(),
        Obx(() {
          return controller.currentPage.value == QuestionnairePage.finish
              ? Container()
              : nextButton();
        }),
      ],
    );
  }

  InkWell nextButton() {
    return InkWell(
      onTap: () {
        controller.onButtonTapped();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 13.w),
        width: 89.w,
        height: 33.h,
        decoration: BoxDecoration(
            color: const Color(0xFF8F01DF),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: const [
            Text(
              'Next',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 12,
            )
          ],
        ),
      ),
    );
  }

  InkWell prevButton() {
    return InkWell(
      onTap: () {
        controller.onBackPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 13.w),
        width: 89.w,
        height: 33.h,
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color(0xFF171433).withOpacity(0.7), width: 2),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_back_ios_new,
              size: 12,
            ),
            const Spacer(),
            Text(
              'Pre',
              style: TextStyle(
                  color: const Color(0xFF171433),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class HeightSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  HeightSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: CupertinoPicker(
          itemExtent: 55.h,
          onSelectedItemChanged: (index) {
            controller.height.value = index + 1;
          },
          useMagnifier: true,
          magnification: 1.3,
          selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            background: Colors.transparent,
          ),
          children: List.generate(200, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    '${index + 1} cm',
                    style: TextStyle(
                        color: controller.height.value == index + 1
                            ? const Color(0xFF8F01DF)
                            : const Color(0xFF171433).withOpacity(0.7),
                        fontSize: 34.sp),
                  );
                })
              ],
            );
          })),
    );
  }
}

class DrinkSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  DrinkSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: CupertinoPicker(
          itemExtent: 55.h,
          onSelectedItemChanged: (index) {
            controller.drink.value = index + 1;
          },
          selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            background: Colors.transparent,
          ),
          useMagnifier: true,
          magnification: 1.3,
          children: List.generate(100, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        color: controller.drink.value == index + 1
                            ? const Color(0xFF8F01DF)
                            : const Color(0xFF171433).withOpacity(0.7),
                        fontSize: 34.sp),
                  );
                })
              ],
            );
          })),
    );
  }
}

class SleepSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  SleepSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: CupertinoPicker(
          itemExtent: 55.h,
          onSelectedItemChanged: (index) {
            controller.sleep.value = index + 1;
          },
          selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            background: Colors.transparent,
          ),
          useMagnifier: true,
          magnification: 1.3,
          children: List.generate(100, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        color: controller.sleep.value == index + 1
                            ? const Color(0xFF8F01DF)
                            : const Color(0xFF171433).withOpacity(0.7),
                        fontSize: 34.sp),
                  );
                })
              ],
            );
          })),
    );
  }
}

class DietrarySelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  DietrarySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 298.h,
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (DietrarySelection.none == DietrarySelection.values[index]) {
            return Container();
          } else {
            return Obx(() {
              return controller.selectedDietrary.value !=
                      DietrarySelection.values[index]
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          controller.selectedDietrary.value =
                              DietrarySelection.values[index];
                        },
                        child: Text(
                          DietrarySelection.values[index].title(),
                          style: TextStyle(
                              fontSize: 18,
                              color: const Color(0xFF171433).withOpacity(0.7)),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 19).r,
                      height: 57.h,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.selectedDietrary.value =
                                DietrarySelection.values[index];
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: BorderSide(
                                      color: const Color(0xFF8F01DF),
                                      width: 3.w))),
                          child: Obx(() {
                            return Text(
                              DietrarySelection.values[index].title(),
                              style: TextStyle(
                                  color: controller.selectedDietrary.value ==
                                          DietrarySelection.values[index]
                                      ? const Color(0xFF8F01DF)
                                      : const Color(0xFF171433)
                                          .withOpacity(0.7),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600),
                            );
                          })),
                    );
            });
          }
        },
        itemCount: DietrarySelection.values.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}

class GoalSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  GoalSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 298.h,
      child: ListView.separated(
        itemBuilder: (context, index) {
          // create button with rounded corner and border if selected, change color to purple
          if (GoalSelection.none == GoalSelection.values[index]) {
            return Container();
          } else {
            return Obx(() {
              return controller.selectedGoals.value !=
                      GoalSelection.values[index]
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          controller.selectedGoals.value =
                              GoalSelection.values[index];
                        },
                        child: Text(
                          GoalSelection.values[index].title(),
                          style: TextStyle(
                              fontSize: 18,
                              color: const Color(0xFF171433).withOpacity(0.7)),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 19).r,
                      height: 57.h,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.selectedGoals.value =
                                GoalSelection.values[index];
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: BorderSide(
                                      color: const Color(0xFF8F01DF),
                                      width: 3.w))),
                          child: Obx(() {
                            return Text(
                              GoalSelection.values[index].title(),
                              style: TextStyle(
                                  color: controller.selectedGoals.value ==
                                          GoalSelection.values[index]
                                      ? const Color(0xFF8F01DF)
                                      : const Color(0xFF171433)
                                          .withOpacity(0.7),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600),
                            );
                          })),
                    );
            });
          }
        },
        itemCount: GoalSelection.values.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}

class WeightSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  WeightSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298.h,
      child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
              initialItem: controller.weight.value - 1),
          itemExtent: 55.h,
          onSelectedItemChanged: (index) {
            controller.weight.value = index + 1;
          },
          useMagnifier: true,
          magnification: 1.3,
          selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            background: Colors.transparent,
          ),
          children: List.generate(200, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return Text(
                    '${index + 1} kg',
                    style: TextStyle(
                        color: controller.weight.value == index + 1
                            ? const Color(0xFF8F01DF)
                            : const Color(0xFF171433).withOpacity(0.7),
                        fontSize: 34.sp),
                  );
                })
              ],
            );
          })),
    );
  }
}

class GenderSelector extends StatelessWidget {
  final QuestionnaireController controller = Get.find();
  GenderSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(child: genderButton(Gender.male, () {})),
        Flexible(child: genderButton(Gender.female, () {})),
      ],
    );
  }

  Column genderButton(Gender gender, VoidCallback onTap) {
    return Column(
      children: [
        SizedBox(
            height: 0.19.sh,
            width: 0.346.sw,
            child: Obx(() {
              return InkWell(
                onTap: () {
                  controller.selectedGender.value = gender;
                },
                child: Opacity(
                  opacity:
                      gender == controller.selectedGender.value ? 1.0 : 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0).r,
                    child: Container(
                      decoration: BoxDecoration(
                        color: gender == Gender.male
                            ? Color(0xFFDDF235)
                            : Color(0xFF7FE4F0),
                      ),
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 20).r,
                      child: SvgPicture.asset(
                        gender == Gender.male
                            ? Constant.imgMaleSVG
                            : Constant.imgFemaleSVG,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              );
            })),
        19.verticalSpace,
        Obx(() {
          return Text(
            gender.label(),
            style: TextStyle(
                color: gender == controller.selectedGender.value
                    ? Color(0xFFDDF235)
                    : Color(0xFF171433).withOpacity(0.8),
                fontSize: 18.sp),
          );
        })
      ],
    );
  }
}
