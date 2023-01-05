import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/daily_journal/presentation/page/daily_journal_screen.dart';
import 'package:livewell/feature/profile/presentation/controller/physical_information_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

import '../../../../widgets/buttons/livewell_button.dart';
import 'account_settings_screen.dart';

class PhysicalInformationScreen extends StatelessWidget {
  PhysicalInformationController controller =
      Get.put(PhysicalInformationController());
  PhysicalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: 'Physical Information',
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              55.verticalSpace,
              Container(
                height: 570.h,
                width: 342.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30).r,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 18.h, left: 24.w, right: 24.w),
                      child: Row(
                        children: [
                          Text(
                            "Physical Information",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text("edit")
                        ],
                      ),
                    ),
                    12.verticalSpace,
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 39.h),
                        color: const Color(0xFFF1F1F1),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  // show dialog with radio button to select gender
                                  Get.dialog(
                                      Dialog(
                                          child: Container(
                                              height: 200.h,
                                              child: Obx(() {
                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      leading: Text('Male'),
                                                      trailing: Radio(
                                                          value: 'Male',
                                                          groupValue: controller
                                                              .genderValue
                                                              .value,
                                                          onChanged: (val) {
                                                            controller
                                                                .setGender(val
                                                                    as String);
                                                          }),
                                                    ),
                                                    ListTile(
                                                      leading: Text('Female'),
                                                      trailing: Radio(
                                                          value: 'Female',
                                                          groupValue: controller
                                                              .genderValue
                                                              .value,
                                                          onChanged: (val) {
                                                            controller
                                                                .setGender(val
                                                                    as String);
                                                          }),
                                                    ),
                                                    LiveWellButton(
                                                        label: 'Save Changes',
                                                        color: const Color(
                                                            0xFF8F01DF),
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          Get.back();
                                                          controller
                                                              .setGenderTextField();
                                                        })
                                                  ],
                                                );
                                              }))),
                                      barrierDismissible: false);
                                },
                                child: AccountSettingsTextField(
                                  textEditingController: controller.gender,
                                  hintText: 'Gender',
                                  enabled: false,
                                ),
                              ),
                              20.verticalSpace,
                              InkWell(
                                onTap: () {
                                  Get.dialog(Dialog(
                                    child: SizedBox(
                                      height: 400.h,
                                      width: 0.8.sw,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Obx(() {
                                            return DatePickerWidget(
                                              initialDateTime: DateTime(
                                                  controller
                                                      .birthDate.value!.year,
                                                  controller
                                                      .birthDate.value!.month,
                                                  controller
                                                      .birthDate.value!.day),
                                              onMonthChangeStartWithFirstDate:
                                                  false,
                                              maxDateTime: DateTime.now(),
                                              dateFormat: 'yyyy-MMM-dd',
                                              onChange:
                                                  (dateTime, selectedIndex) {
                                                controller.birthDate.value =
                                                    dateTime;
                                              },
                                              pickerTheme:
                                                  const DateTimePickerTheme(
                                                showTitle: false,
                                              ),
                                            );
                                          }),
                                          30.verticalSpace,
                                          LiveWellButton(
                                              label: 'Save Changes',
                                              color: const Color(0xFF8F01DF),
                                              textColor: Colors.white,
                                              onPressed: () {
                                                Get.back();
                                                controller.setAgeTextField();
                                              })
                                        ],
                                      ),
                                    ),
                                  ));
                                },
                                child: AccountSettingsTextField(
                                  textEditingController: controller.age,
                                  hintText: 'Age',
                                  enabled: false,
                                ),
                              ),
                              20.verticalSpace,
                              AccountSettingsTextField(
                                textEditingController: controller.height,
                                hintText: 'Height (cm)',
                                enabled: true,
                                inputType: TextInputType.number,
                              ),
                              20.verticalSpace,
                              AccountSettingsTextField(
                                textEditingController: controller.weight,
                                hintText: 'Weight (kg)',
                                enabled: true,
                                inputFormatter: Platform.isIOS
                                    ? []
                                    : [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\.?\d{0,2}'))
                                      ],
                                inputType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              ),
                              20.verticalSpace,
                              AccountSettingsTextField(
                                textEditingController: controller.drink,
                                hintText: 'Drink',
                                enabled: true,
                                inputType: TextInputType.number,
                              ),
                              20.verticalSpace,
                              AccountSettingsTextField(
                                textEditingController:
                                    controller.dietaryResitriction,
                                hintText: 'Dietary Restriction',
                                enabled: true,
                              ),
                              20.verticalSpace,
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
                                                          title:
                                                              Text(e.title()),
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
                                                  label: 'Save Changes',
                                                  color:
                                                      const Color(0xFF8F01DF),
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    Get.back();
                                                    controller.setGoal(
                                                        controller.selectedGoals
                                                            .value);
                                                  })
                                            ],
                                          );
                                        })),
                                  ));
                                },
                                child: AccountSettingsTextField(
                                  textEditingController:
                                      controller.specificGoal,
                                  hintText: 'Specific Goal',
                                  enabled: false,
                                ),
                              ),
                              20.verticalSpace,
                              AccountSettingsTextField(
                                textEditingController: controller.targetWeight,
                                hintText: 'Target Weight (kg)',
                                enabled: true,
                                inputFormatter: Platform.isIOS
                                    ? []
                                    : [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\.?\d{0,2}'))
                                      ],
                                inputType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              ),
                              20.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              20.verticalSpace,
              LiveWellButton(
                  label: 'Save',
                  color: const Color(0xFF8F01DF),
                  textColor: Colors.white,
                  onPressed: () {
                    controller.onUpdateTapped();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
