import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livewell/feature/questionnaire/presentation/controller/questionnaire_controller.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/calories_need_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/gender_selector.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/health_condition_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/height_weight_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/landing_questionnaire.dart';
import 'package:livewell/feature/questionnaire/presentation/page/widget/name_questionnaire.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'widget/age_selector.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final QuestionnaireController controller = Get.put(QuestionnaireController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: false,
        child: LiveWellScaffold(
          title: controller.localization.onboardingPage?.healthProfile ?? 'Health Profile',
          allowBack: controller.currentPage.value != QuestionnairePage.landing,
          onBack: () {
            controller.onBackPressed();
          },
          backgroundColor: Colors.white,
          body: Expanded(
            child: Column(
              children: [
                32.verticalSpace,
                Obx(() {
                  if (controller.currentPage.value == QuestionnairePage.landing || controller.currentPage.value == QuestionnairePage.finish) {
                    return 8.verticalSpace;
                  } else {
                    return LinearPercentIndicator(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      width: MediaQuery.of(context).size.width,
                      lineHeight: 7.0,
                      percent: (controller.currentPage.value.realIndex()) / QuestionnairePage.landing.realLength(),
                      barRadius: const Radius.circular(4.0),
                      backgroundColor: const Color(0xFFF2F1F9),
                      progressColor: const Color(0xFFDDF235),
                    );
                  }
                }),
                Obx(() {
                  return findContent(controller.currentPage.value);
                })
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget findContent(QuestionnairePage currentPage) {
    switch (currentPage) {
      case QuestionnairePage.name:
        return NameQuestionnaire();
      case QuestionnairePage.gender:
        return GenderSelector();
      case QuestionnairePage.birthDate:
        return AgeSelector();
      case QuestionnairePage.caloriesNeed:
        return CaloriesNeedQuestionnaire();
      case QuestionnairePage.healthCondition:
        return HealthConditionQuestionnaire();
      case QuestionnairePage.landing:
        return LandingQuestionnaire();
      case QuestionnairePage.heightWeight:
        return HeightWeightQuestionnaire();
      case QuestionnairePage.finish:
        return Container();
    }
  }
}
