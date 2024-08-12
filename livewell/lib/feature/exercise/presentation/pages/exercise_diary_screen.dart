import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/exercise/presentation/controller/exercise_controller.dart';

import '../../../../widgets/chart/circular_calories.dart';

class ExerciseDiaryScreen extends StatefulWidget {
  const ExerciseDiaryScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseDiaryScreen> createState() => _ExerciseDiaryScreenState();
}

class _ExerciseDiaryScreenState extends State<ExerciseDiaryScreen> {
  ExerciseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //40.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            return RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: controller.localization.exercisePage?.youHaveReached ?? "You have reached ",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433)),
                children: <TextSpan>[
                  TextSpan(text: "${controller.getGoalPercentage()}%", style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600, color: const Color(0xFF8F01DF))),
                  TextSpan(text: controller.localization.exercisePage?.ofYourGoal ?? "of your goal!", style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433))),
                ],
              ),
            );
          }),
        ),
        40.verticalSpace,
        SimpleCircularProgressBar(
          backColor: Colors.white,
          progressColors: const [Color(0xFF8F01DF)],
          mergeMode: true,
          backStrokeWidth: 8,
          size: 200.h,
          progressStrokeWidth: 14,
          valueNotifier: controller.goalValueNotifier,
          animationDuration: const Duration(seconds: 1),
          maxValue: 1,
          shadow: false,
          onGetText: (value) {
            return Text(
              "${controller.getGoalPercentage()}%",
              style: TextStyle(fontSize: 40.sp, color: const Color(0xFF171433)),
            );
          },
        ),
        30.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SimpleCircularProgressBar(
                    backColor: Colors.white,
                    progressColors: [const Color(0xFF171433).withOpacity(0.7)],
                    mergeMode: true,
                    backStrokeWidth: 5,
                    size: 70.h,
                    progressStrokeWidth: 8,
                    valueNotifier: controller.goalValueNotifier,
                    animationDuration: const Duration(seconds: 1),
                    maxValue: 1,
                    shadow: false,
                    onGetText: (value) {
                      return SvgPicture.asset("assets/icons/ic_calories_exercise.svg");
                    },
                  ),
                  16.verticalSpace,
                  Obx(() {
                    return Text(
                      "${controller.burntCalories.value.round()}\n ${controller.localization.exercisePage?.caloriesBurnt ?? "Calories Burnt"}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433)),
                    );
                  })
                ],
              ),
            ),
            20.horizontalSpace,
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SimpleCircularProgressBar(
                    backColor: Colors.white,
                    progressColors: [const Color(0xFF171433).withOpacity(0.7)],
                    mergeMode: true,
                    backStrokeWidth: 5,
                    size: 70.h,
                    progressStrokeWidth: 8,
                    valueNotifier: controller.stepsValueNotifier,
                    animationDuration: const Duration(seconds: 1),
                    maxValue: 1,
                    shadow: false,
                    onGetText: (value) {
                      return SvgPicture.asset("assets/icons/ic_steps_exercise.svg");
                    },
                  ),
                  16.verticalSpace,
                  Obx(() {
                    return Text(
                      "${controller.steps.value}\n ${controller.localization.exercisePage?.steps ?? "Steps"}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433)),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
        20.verticalSpace,
        Text('${controller.localization.exercisePage?.syncedVia ?? 'Synced Via'} ${Platform.isIOS ? 'Apple Health' : 'Google Fit'}',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: const Color(0xFF171433))),
      ],
    );
  }
}
