import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/exercise/presentation/controller/exercise_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/widgets/buttons/livewell_button.dart';

class ExerciseKYCScreen extends StatelessWidget {
  final controller = Get.find<ExerciseController>();
  ExerciseKYCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            48.verticalSpace,
            40.verticalSpace,
            // Text(QuestionnairePage.exercise.title(),
            //     style: TextStyle(
            //         fontSize: 24.sp,
            //         color: const Color(0xFF171433),
            //         fontWeight: FontWeight.w600)),
            7.verticalSpace,
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16).r,
            //   child: Text(
            //     QuestionnairePage.exercise.subtitle(),
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         fontSize: 16.sp,
            //         color: const Color(0xFF171433).withOpacity(0.7),
            //         fontWeight: FontWeight.w500),
            //   ),
            // ),
            40.verticalSpace,
            SizedBox(
              height: 298.h,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  // create button with rounded corner and border if selected, change color to purple
                  return Obx(() {
                    return controller.selectedExerciseTarget.value != TargetExerciseSelection.values[index]
                        ? Center(
                            child: InkWell(
                              onTap: () {
                                controller.selectedExerciseTarget.value = TargetExerciseSelection.values[index];
                              },
                              child: Text(
                                TargetExerciseSelection.values[index].title(),
                                style: TextStyle(fontSize: 18, color: const Color(0xFF171433).withOpacity(0.7)),
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 19).r,
                            height: 57.h,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.selectedExerciseTarget.value = TargetExerciseSelection.values[index];
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40), side: BorderSide(color: const Color(0xFF8F01DF), width: 3.w))),
                                child: Obx(() {
                                  return Text(
                                    TargetExerciseSelection.values[index].title(),
                                    style: TextStyle(
                                        color: controller.selectedExerciseTarget.value == TargetExerciseSelection.values[index] ? const Color(0xFF8F01DF) : const Color(0xFF171433).withOpacity(0.7),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w600),
                                  );
                                })),
                          );
                  });
                },
                itemCount: TargetExerciseSelection.values.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              ),
            ),
            const Spacer(),
            LiveWellButton(
              label: "Save",
              color: const Color(0xFF8F01DF),
              onPressed: () {
                controller.saveExerciseTarget();
              },
              textColor: Colors.white,
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
