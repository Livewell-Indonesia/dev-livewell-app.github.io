import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/profile/presentation/controller/exercise_information_controller.dart';
import 'package:livewell/feature/profile/presentation/controller/physical_information_controller.dart';
import 'package:livewell/feature/profile/presentation/page/account_settings_screen.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class MyGoalsScreen extends StatefulWidget {
  MyGoalsScreen({super.key});

  @override
  State<MyGoalsScreen> createState() => _MyGoalsScreenState();
}

class _MyGoalsScreenState extends State<MyGoalsScreen> {
  final PhysicalInformationController controller = Get.find();

  final ExerciseInformationController exerciseController = Get.find();

  @override
  void initState() {
    controller.trackEvent(LivewellProfileEvent.myGoalsPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: controller.localization.goalsSetting!,
        body: Expanded(
          child: Column(
            children: [
              32.verticalSpace,
              Container(
                height: 570.h,
                width: 342.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30).r,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 18.h, left: 24.w, right: 24.w),
                      child: Row(
                        children: [
                          Text(
                            controller.localization.goalsSetting!,
                            style: TextStyle(
                                color: const Color(0xFF171433),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    12.verticalSpace,
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 39.h),
                        color: const Color(0xFFF1F1F1),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.dialog(Dialog(
                                  child: SizedBox(
                                      height: 500.h,
                                      width: 0.8.sw,
                                      child: Obx(() {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: GoalSelection.values
                                                  .map((e) => ListTile(
                                                        title: Text(
                                                          e.title(),
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF171433)),
                                                        ),
                                                        trailing: Radio(
                                                            value: e,
                                                            groupValue: controller
                                                                .selectedGoals
                                                                .value,
                                                            onChanged: (val) {
                                                              controller
                                                                      .selectedGoals
                                                                      .value =
                                                                  val as GoalSelection;
                                                            }),
                                                      ))
                                                  .toList(),
                                            ),
                                            30.verticalSpace,
                                            LiveWellButton(
                                                label: 'Save Changes'.tr,
                                                color: const Color(0xFF8F01DF),
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  Get.back();
                                                  controller.setGoal(controller
                                                      .selectedGoals.value);
                                                })
                                          ],
                                        );
                                      })),
                                ));
                              },
                              child: AccountSettingsTextField(
                                textEditingController: controller.specificGoal,
                                hintText: controller.localization.specificGoal!,
                                enabled: false,
                              ),
                            ),
                            16.verticalSpace,
                            AccountSettingsTextField(
                              textEditingController: controller.targetWeight,
                              hintText: controller.localization.targetWeightKg!,
                              enabled: true,
                              inputFormatter: Platform.isIOS
                                  ? []
                                  : [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,2}'))
                                    ],
                              inputType: const TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                            16.verticalSpace,
                            AccountSettingsTextField(
                              textEditingController: controller.drink,
                              hintText: controller.localization.drink!,
                              enabled: true,
                              inputType: TextInputType.number,
                              suffixText: "Glass",
                            ),
                            16.verticalSpace,
                            AccountSettingsTextField(
                              textEditingController: controller.sleep,
                              hintText: controller.localization.sleepHours!,
                              enabled: true,
                              inputType: const TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                            16.verticalSpace,
                            AccountSettingsTextField(
                              textEditingController:
                                  exerciseController.exerciseController,
                              hintText: 'Calories (kcal)'.tr,
                              enabled: true,
                              inputType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              LiveWellButton(
                label: controller.localization.save!,
                textColor: Colors.white,
                color: const Color(0xFF8F01DF),
                onPressed: () {
                  controller.onUpdateTapped(exerciseController);
                },
              ),
              32.verticalSpace
            ],
          ),
        ));
  }
}
