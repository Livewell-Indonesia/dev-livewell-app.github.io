import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/exercise_target_selector.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/gender_selector.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/target_weight_selector.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../routes/app_navigator.dart';
import 'widget/age_selector.dart';
import 'widget/dietrary_selector.dart';
import 'widget/drink_selector.dart';
import 'widget/goal_selector.dart';
import 'widget/height_selector.dart';
import 'widget/sleep_selector.dart';
import 'widget/weight_selector.dart';

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
      allowBack: Get.previousRoute == AppPages.profile,
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
      case QuestionnairePage.exercise:
        return ExerciseTargetSelector();
      case QuestionnairePage.finish:
        return const Text('finish');
      case QuestionnairePage.targetWeight:
        return TargetWeightSelector();
    }
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
