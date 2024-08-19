import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/diary/presentation/page/user_diary_screen.dart';
import 'package:livewell/feature/profile/presentation/controller/exercise_information_controller.dart';
import 'package:livewell/feature/profile/presentation/controller/physical_information_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/title_questionnaire.dart';
import 'package:livewell/theme/design_system.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:livewell/widgets/textfield/auth_textfield.dart';

import '../../../../widgets/buttons/livewell_button.dart';
import 'account_settings_screen.dart';

class PhysicalInformationScreen extends StatelessWidget {
  final PhysicalInformationController controller = Get.find();
  PhysicalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
      title: controller.localization.physicalInformationPage?.physicalInformation ?? "Physical Information",
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
                      padding: EdgeInsets.only(top: 18.h, left: 24.w, right: 24.w),
                      child: Row(
                        children: [
                          Text(
                            controller.localization.physicalInformationPage?.physicalInformation ?? "Physical Information",
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    12.verticalSpace,
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 39.h, bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(32),
                                                  topRight: Radius.circular(32),
                                                  bottomLeft: Radius.circular(32),
                                                  bottomRight: Radius.circular(32),
                                                ),
                                              ),
                                              height: 200.h,
                                              child: Obx(() {
                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      leading: Text(
                                                        controller.localization.physicalInformationPage?.male ?? "Male",
                                                        style: const TextStyle(color: Colors.black),
                                                      ),
                                                      trailing: Radio(
                                                          value: 'Male',
                                                          groupValue: controller.genderValue.value,
                                                          onChanged: (val) {
                                                            controller.setGender(val as String);
                                                          }),
                                                    ),
                                                    ListTile(
                                                      leading: Text(
                                                        controller.localization.physicalInformationPage?.female ?? "Female",
                                                        style: const TextStyle(color: Colors.black),
                                                      ),
                                                      trailing: Radio(
                                                          value: 'Female',
                                                          groupValue: controller.genderValue.value,
                                                          onChanged: (val) {
                                                            controller.setGender(val as String);
                                                          }),
                                                    ),
                                                    LiveWellButton(
                                                        label: controller.localization.physicalInformationPage?.save ?? "Save Changes",
                                                        color: const Color(0xFF8F01DF),
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          Get.back();
                                                          controller.setGenderTextField();
                                                        })
                                                  ],
                                                );
                                              }))),
                                      barrierDismissible: false);
                                },
                                child: AccountSettingsTextField(
                                  textEditingController: controller.gender,
                                  hintText: controller.localization.physicalInformationPage?.gender ?? "Gender",
                                  enabled: false,
                                ),
                              ),
                              20.verticalSpace,
                              InkWell(
                                onTap: () {
                                  Get.dialog(Dialog(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(32),
                                          topRight: Radius.circular(32),
                                          bottomLeft: Radius.circular(32),
                                          bottomRight: Radius.circular(32),
                                        ),
                                      ),
                                      height: 400.h,
                                      width: 0.8.sw,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Obx(() {
                                            return DatePickerWidget(
                                              initialDateTime: DateTime(controller.birthDate.value!.year, controller.birthDate.value!.month, controller.birthDate.value!.day),
                                              onMonthChangeStartWithFirstDate: false,
                                              maxDateTime: DateTime.now(),
                                              dateFormat: 'yyyy-MMM-dd',
                                              onChange: (dateTime, selectedIndex) {
                                                controller.birthDate.value = dateTime;
                                              },
                                              pickerTheme: const DateTimePickerTheme(
                                                showTitle: false,
                                              ),
                                            );
                                          }),
                                          30.verticalSpace,
                                          LiveWellButton(
                                              label: controller.localization.physicalInformationPage?.save ?? "Save Changes",
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
                                  hintText: controller.localization.physicalInformationPage?.age ?? "Age",
                                  enabled: false,
                                ),
                              ),
                              20.verticalSpace,
                              AccountSettingsTextField(
                                textEditingController: controller.height,
                                hintText: controller.localization.physicalInformationPage?.heightCm ?? "Height (cm)",
                                enabled: true,
                                inputType: TextInputType.number,
                              ),
                              20.verticalSpace,
                              AccountSettingsTextField(
                                textEditingController: controller.weight,
                                hintText: controller.localization.physicalInformationPage?.weightKg ?? "Weight (kg)",
                                enabled: true,
                                inputFormatter: Platform.isIOS ? [] : [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                                inputType: const TextInputType.numberWithOptions(decimal: true),
                              ),
                              20.verticalSpace,
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: shapeBorder(),
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            32.verticalSpace,
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                                              child: TitleQuestionnaire(
                                                title: QuestionnairePage.healthCondition.title(),
                                                color: Theme.of(context).colorScheme.secondaryDarkBlue,
                                              ),
                                            ),
                                            40.verticalSpace,
                                            AuthTextField(
                                              controller: controller.dietaryResitriction,
                                              hintText: null,
                                              labelText: controller.localization.onboardingPage?.example ?? "examples: diabetes, high blood pressure, gluten sensitivity, etc.",
                                              errorText: null,
                                              obscureText: false,
                                              borderColor: const Color(0xFFE8E7E7),
                                              minLines: 10,
                                              maxLines: 10,
                                              borderRadius: 16,
                                            ),
                                            32.verticalSpace,
                                            LiveWellButton(
                                              label: controller.localization.physicalInformationPage?.save ?? "Save",
                                              color: Theme.of(context).colorScheme.primaryPurple,
                                              textColor: Colors.white,
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                            32.verticalSpace,
                                          ],
                                        );
                                      });
                                },
                                child: AccountSettingsTextField(
                                  textEditingController: controller.dietaryResitriction,
                                  hintText: controller.localization.physicalInformationPage?.dietaryRestriction ?? "Dietary Restriction",
                                  enabled: false,
                                ),
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
                  label: controller.localization.physicalInformationPage?.save ?? "Save",
                  color: const Color(0xFF8F01DF),
                  textColor: Colors.white,
                  onPressed: () {
                    controller.onUpdateTapped(Get.find<ExerciseInformationController>());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
