import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/profile/presentation/controller/physical_information_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

import '../../../../widgets/buttons/livewell_button.dart';
import 'account_settings_screen.dart';

class PhysicalInformationScreen extends StatelessWidget {
  final PhysicalInformationController controller = Get.find();
  PhysicalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: controller.localization.physicalInformation!,
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
                            controller.localization.physicalInformation!,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    12.verticalSpace,
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            top: 39.h,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        color: const Color(0xFFF1F1F1),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  // show dialog with radio button to select gender
                                  Get.dialog(
                                      Dialog(
                                          child: SizedBox(
                                              height: 200.h,
                                              child: Obx(() {
                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      leading: Text(
                                                        controller
                                                            .localization.male!,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
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
                                                      leading: Text(
                                                        controller.localization
                                                            .female!,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
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
                                                        label: controller
                                                            .localization
                                                            .saveChanges!,
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
                                  hintText: controller.localization.gender!,
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
                                              label: controller
                                                  .localization.saveChanges!,
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
                                  hintText: controller.localization.age!,
                                  enabled: false,
                                ),
                              ),
                              20.verticalSpace,
                              AccountSettingsTextField(
                                textEditingController: controller.height,
                                hintText: controller.localization.heightCm!,
                                enabled: true,
                                inputType: TextInputType.number,
                              ),
                              20.verticalSpace,
                              AccountSettingsTextField(
                                textEditingController: controller.weight,
                                hintText: controller.localization.weightKg!,
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
                                textEditingController:
                                    controller.dietaryResitriction,
                                hintText:
                                    controller.localization.dietaryRestriction!,
                                enabled: true,
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
                  label: controller.localization.save!,
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
