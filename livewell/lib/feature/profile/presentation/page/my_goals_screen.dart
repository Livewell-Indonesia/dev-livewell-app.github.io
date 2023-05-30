import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/profile/presentation/controller/physical_information_controller.dart';
import 'package:livewell/feature/profile/presentation/page/account_settings_screen.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class MyGoalsScreen extends StatelessWidget {
  final PhysicalInformationController controller = Get.find();
  MyGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'My Goals',
        body: Expanded(
          child: Column(
            children: [
              32.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 8.w),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Goals Setting'.tr,
                        style: TextStyle(
                            color: Color(0xFF171433),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    24.verticalSpace,
                    InkWell(
                      onTap: () {
                        Get.dialog(Dialog(
                          child: SizedBox(
                              height: 500.h,
                              width: 0.8.sw,
                              child: Obx(() {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: GoalSelection.values
                                          .map((e) => ListTile(
                                                title: Text(e.title()),
                                                trailing: Radio(
                                                    value: e,
                                                    groupValue: controller
                                                        .selectedGoals.value,
                                                    onChanged: (val) {
                                                      controller.selectedGoals
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
                                          controller.setGoal(
                                              controller.selectedGoals.value);
                                        })
                                  ],
                                );
                              })),
                        ));
                      },
                      child: AccountSettingsTextField(
                        textEditingController: controller.specificGoal,
                        hintText: 'Specific Goal'.tr,
                        enabled: false,
                      ),
                    ),
                    16.verticalSpace,
                    AccountSettingsTextField(
                      textEditingController: controller.targetWeight,
                      hintText: 'Target Weight (kg)'.tr,
                      enabled: true,
                      inputFormatter: Platform.isIOS
                          ? []
                          : [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'))
                            ],
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                    16.verticalSpace,
                    AccountSettingsTextField(
                      textEditingController: controller.drink,
                      hintText: 'Drink'.tr,
                      enabled: true,
                      inputType: TextInputType.number,
                    ),
                    16.verticalSpace,
                    AccountSettingsTextField(
                      textEditingController: controller.sleep,
                      hintText: 'Sleep (Hours)'.tr,
                      enabled: true,
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              LiveWellButton(
                label: 'Save'.tr,
                textColor: Colors.white,
                color: const Color(0xFF8F01DF),
                onPressed: () {
                  controller.onUpdateTapped();
                },
              ),
              32.verticalSpace
            ],
          ),
        ));
  }
}
