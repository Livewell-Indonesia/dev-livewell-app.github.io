import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/core/helper/tracker/livewell_tracker.dart';
import 'package:livewell/feature/profile/presentation/controller/exercise_information_controller.dart';
import 'package:livewell/feature/profile/presentation/page/account_settings_screen.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class ExerciseInformationScreen extends StatefulWidget {
  ExerciseInformationScreen({super.key});

  @override
  State<ExerciseInformationScreen> createState() => _ExerciseInformationScreenState();
}

class _ExerciseInformationScreenState extends State<ExerciseInformationScreen> {
  final ExerciseInformationController controller = Get.find();

  @override
  void initState() {
    controller.trackEvent(LivewellProfileEvent.physicalInformationPage);
    super.initState();
  }

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
                          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 39.h),
                          color: const Color(0xFFF1F1F1),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                20.verticalSpace,
                                AccountSettingsTextField(
                                  textEditingController: controller.exerciseController,
                                  hintText: 'Calories (kcal)'.tr,
                                  enabled: true,
                                  inputType: const TextInputType.numberWithOptions(),
                                  inputFormatter: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
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
                      controller.trackEvent(LivewellProfileEvent.physicalInformationPageSaveButton);
                      controller.save();
                    })
              ],
            ),
          ),
        ));
  }
}
